package classes 
{
	import classes.*; 
	import classes.GlobalFlags.*;
	
	public class PlayerAppearance extends BaseContent
	{
		public function PlayerAppearance() {}

		protected function footInchOrMetres(...args):String { return measurements.footInchOrMetres.apply(null, args); }
		protected function numInchesOrCentimetres(inches:Number):String { return measurements.numInchesOrCentimetres(inches); }
		protected function inchesOrCentimetres(...args):String { return measurements.inchesOrCentimetres.apply(null, args); }
		protected function shortSuffix(...args):String { return measurements.shortSuffix.apply(null, args); }

		public function appearance():void {
			funcs = new Array();
			args = new Array();
			//Temp vars
			var temp:Number = 0;
			var rando:Number = 0;
			//Determine race type:
			var race:String = "human";
			race = player.race();
			//Discuss race
			output.clear().header("Appearance");
			if (race != player.startingRace)	output.text("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm.  ");
			//Height and race.
			output.text("You are a [tallness] tall [malefemaleherm] [race], with [bodytype].");
			
			outputText("  <b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + " and using your " + player.weaponName + " as a weapon.</b>");
			if (player.featheryHairPinEquipped()) {
				// This may be relocated into a method later. Probably something, like player.headAccessory()
				// Note, that earrings count as piercings, meaning, that head accessories and earrings are to be handled seperately
				var hairPinText:String = "";
				hairPinText += "  <b>You have a hair-pin with a single red feather plume";
				if (player.hairLength > 0)
					hairPinText += " in your [hair].</b>";
				else
					hairPinText += " on your head.</b>";
				outputText(hairPinText);
			}
			if (player.jewelryName != "nothing") 
				outputText("  <b>Girding one of your fingers is " + player.jewelryName + ".</b>");
			//Face
			if (player.faceType == FACE_HUMAN || player.faceType == FACE_SHARK_TEETH || player.faceType == FACE_BUNNY || player.faceType == FACE_SPIDER_FANGS || player.faceType == FACE_FERRET_MASK) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  Your face is human in shape and structure, with [skin].");
				if (player.hasFur()) 
					outputText("  Under your [skinFurScales] you have a human-shaped head with [skin.noadj].");
				if (player.hasScales()) 
					outputText("  Your face is fairly human in shape, but is covered in [skin].");
				if (player.faceType == FACE_SHARK_TEETH) 
					outputText("  A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.");
				else if (player.faceType == FACE_BUNNY) 
					outputText("  The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.");
				else if (player.faceType == FACE_SPIDER_FANGS) 
					outputText("  A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.");
				else if (player.faceType == FACE_FERRET_MASK)
					outputText("  The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.");
			}
			else if (player.faceType == FACE_FERRET)
			{
				if (player.hasPlainSkin()) outputText("  Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers.  The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.");
				else outputText("  Your face is coated in " + player.furColor + " fur with [skin] underneath, an adorable cross between human and ferret features.  It is complete with a wet nose and whiskers.");
			}
			else if (player.faceType == FACE_RACCOON_MASK) 
			{
				//appearance for skinheads
				if (!player.hasFurOrScales()) 
				{
					outputText("  Your face is human in shape and structure, with [skin]");
					if ((player.skinTone == "ebony" || player.skinTone == "black") && (player.hasPlainSkin() || player.hasGooSkin())) 
						outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
					else outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
				}
				//appearance furscales
				else 
				{
					//(black/midnight furscales)
					if (((player.furColor == "black" || player.furColor == "midnight") && player.hasFurOrScales())) 
						outputText("  Under your [skinFurScales] hides a black raccoon mask, barely visible due to your inky hue, and");
					else outputText("  Your [skinFurScales] are decorated with a sly-looking raccoon mask, and under them");
					outputText(" you have a human-shaped head with [skin.noadj].");
				}
			}
			else if (player.faceType == FACE_RACCOON) 
			{
				outputText("  You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skinFurScales] by a band of white.");
				//(if skin)
				if (player.hasPlainSkin()) 
					outputText("  It looks a bit strange with only the skin and no fur.");
				else if (player.hasReptileScales()) 
					outputText("  The presence of said scales gives your visage an eerie look, more reptile than mammal.");
			}
			else if (player.faceType == FACE_FOX) 
			{
				outputText("  You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
				if (player.hasPlainSkin()) 
					outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skinFurScales]."); 
				else if (player.hasFur())
					if (player.hasDifferentUnderBody())
						outputText("  Your muzzle is decorated with [skinFurScales] on your upper jaw and head and with [underBody.skinFurScales] on your lower jaw.");
					else
						outputText("  A coat of [skinFurScales] decorates your muzzle.");
				else if (player.hasScales()) 
					outputText("  Strangely, [skinFurScales] adorn every inch of your animalistic visage.");
			}
			else if (player.faceType == FACE_BUCKTEETH) 
			{
				//appearance
				outputText("  Your face is generally human in shape and structure, with [skin]"
				          + (player.hasFur() ? " under your [skinFurScales]" : "") + " and mousey buckteeth.");
			}
			else if (player.faceType == FACE_MOUSE) 
			{
				//appearance
				outputText("  You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and [skin]"
				          + (player.hasFur() ? " under your [skinFurScales]" : "") + ".  Two large incisors complete it.");
			}
			//Naga
			if (player.faceType == FACE_SNAKE_FANGS) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a fairly normal face, with [skin].  The only oddity is your pair of dripping fangs which often hang over your lower lip.");
				if (player.hasFur()) 
					outputText("  Under your [skinFurScales] you have a human-shaped head with [skin.noadj].  In addition, a pair of fangs hang over your lower lip, dripping with venom.");
				if (player.hasScales()) 
					outputText("  Your face is fairly human in shape, but is covered in [skinFurScales].  In addition, a pair of fangs hang over your lower lip, dripping with venom.");
			}
			//horse-face
			if (player.faceType == FACE_HORSE) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  Your face is equine in shape and structure.  The odd visage is hairless and covered with [skinFurScales].");
				if (player.hasFur()) 
					outputText("  Your face is almost entirely equine in appearance, even having [skinFurScales].  Underneath the fur, you believe you have [skin.noadj].");
				if (player.hasScales()) 
					outputText("  You have the face and head structure of a horse, overlaid with glittering [skinFurScales].");
			}
			//wolf-face
			if (player.faceType == FACE_WOLF) 
			{
				outputText("  You have an angular wolf's face complete with a muzzle and black nose");
				if (!player.hasFur())
					outputText(", though devoid of any fur.");
				else
					outputText(".");
			}
			//dog-face
			if (player.faceType == FACE_DOG) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a dog-like face, complete with a wet nose.  The odd visage is hairless and covered with [skinFurScales].");
				if (player.hasFur()) 
					outputText("  You have a dog's face, complete with wet nose and panting tongue.  You've got [skinFurScales], hiding your [skin.noadj] underneath your furry visage.");
				if (player.hasScales()) 
					outputText("  You have the facial structure of a dog, wet nose and all, but overlaid with glittering [skinFurScales].");
			}
			//cat-face
			if (player.faceType == FACE_CAT) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a cat-like face, complete with a cute, moist nose and whiskers.  The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face.");
				if (player.hasFur())
					if (player.hasDifferentUnderBody())
						outputText("  You have a cat-like face, complete with moist nose and whiskers.  You have [skinFurScales] on your upper jaw and head, while your lower jaw is decorated by [underBody.skinFurScales], hiding your [skin.noadj] underneath.");
					else
						outputText("  You have a cat-like face, complete with moist nose and whiskers.  Your " + player.skinDesc + " is " + player.furColor + ", hiding your [skin.noadj] underneath.");
				if (player.hasScales()) 
					outputText("  Your facial structure blends humanoid features with those of a cat.  A moist nose and whiskers are included, but overlaid with glittering [skinFurScales].");
				if (player.eyeType != EYES_BLACK_EYES_SAND_TRAP)
				{
					outputText("  Of course, no feline face would be complete without vertically slit eyes");
					outputText(!player.hasReptileEyes() ? "." : ", although they come with a second set of eyelids, which is somewhat unusual for a cats face.");
				}
			}
			//Minotaaaauuuur-face
			if (player.faceType == FACE_COW_MINOTAUR) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Despite your lack of fur elsewhere, your visage does have a short layer of " + player.furColor + " fuzz.");
				if (player.hasFur()) 
					outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Your [skinFurScales] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.");
				if (player.hasScales()) 
					outputText("  Your face resembles a minotaur's, though strangely it is covered in shimmering scales, right up to the flat cow-like nose that protrudes from your face.");
			}
			//Lizard-face
			if (player.faceType == FACE_LIZARD) 
			{
				if (player.hasPlainSkin() || player.hasGooSkin()) 
					outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just [skin].");
				if (player.hasFur()) 
					outputText("  You have a face resembling that of a lizard.  Between the toothy maw, pointed snout, and the layer of [skinFurScales] covering your face, you have quite the fearsome visage.");
				if (player.hasScales()) {
					outputText("  Your face is that of a lizard, complete with a toothy maw and pointed snout.");
					if (!player.hasReptileUnderBody())
						outputText("  Reflective [skinFurScales] complete the look, making you look quite fearsome.");
					else
						outputText("  Reflective [skinFurScales] on your upper jaw and head and [underBody.skinFurScales] on your lower jaw complete the look, making you look quite fearsome.");
				}
			}
			if (player.faceType == FACE_DRAGON) 
			{
				outputText("  Your face is a narrow, reptilian muzzle.  It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw.  It gives you a regal but fierce visage.  Opening your mouth reveals several rows of dagger-like sharp teeth.  The fearsome visage is decorated by [skinFurScales]");
				outputText(player.hasReptileUnderBody() ? " on your upper jaw and head and [underBody.skinFurScales] on your lower jaw." : ".");
			}
			if (player.faceType == FACE_KANGAROO) 
			{
				outputText("  Your face is ");
				if (player.hasPlainSkin()) 
					outputText("bald");
				else outputText("covered with [skinFurScales]");
				outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.");
			}
			//<mod>
			if (player.faceType == FACE_PIG)
			{
				outputText("  Your face is like that of a pig, with " + player.skinTone + " skin, complete with a snout that is always wiggling.");
			}
			if (player.faceType == FACE_BOAR)
			{
				outputText("  Your face is like that of a boar, ");
				if (player.hasFur()) 
					outputText("with " + player.skinTone + " skin underneath your " + player.furColor + " fur"); 
				outputText(", complete with tusks and a snout that is always wiggling.");
			}
			if (player.faceType == FACE_RHINO)
			{
				outputText("  Your face is like that of a rhino");
				if (player.hasPlainSkin())
					outputText(", with [skin], complete with a long muzzle and a horn on your nose.");
				else
					outputText(" with a long muzzle and a horn on your nose.  Oddly, your face is also covered in [skinFurScales].");
			}
			if (player.faceType == FACE_ECHIDNA)
			{
				outputText("  Your odd visage consists of a long, thin echidna snout.");
				if (player.hasPlainSkin())
					outputText("  The [skin] that is revealed by your lack of fur looks quite unusual.");
				else if (player.hasFur())
					outputText("  It's covered in [skinFurScales].");
				else if (player.hasScales())
					outputText("  It's covered in [skinFurScales], making your face even more unusual.");
			}
			if (player.faceType == FACE_DEER)
			{
				outputText("  Your face is like that of a deer, with a nose at the end of your muzzle.");
				if (player.hasPlainSkin())
					outputText("  The [skin] that is revealed by your lack of fur looks quite unusual.");
				else if (player.hasFur())
					if (player.hasDifferentUnderBody())
						outputText("  It's covered in [skinFurScales] on your upper jaw and head and [underBody.skinFurScales]"
						          +" on your lower jaw that covers your [skin.noadj] underneath.");
					else
						outputText("  It's covered in [skinFurScales] that covers your [skin.noadj] underneath.");
				else if (player.hasScales())
					outputText("  It's covered in [skinFurScales], making your face looks more unusual.");
			}
			//</mod>
			//M/F stuff!
			outputText("  It has " + player.faceDesc() + ".");
			//Eyes
			if (player.eyeType == EYES_FOUR_SPIDER_EYES) 
				outputText("  In addition to your primary two eyes, you have a second, smaller pair on your forehead.");
			else if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) 
				outputText("  Your eyes are solid spheres of inky, alien darkness.");
			else if (player.eyeType == EYES_WOLF) 
				outputText("  Your amber eyes are circled by darkness to help keep the sun from obscuring your view and have a second eyelid to keep them wet. You're rather near-sighted, but your peripherals are great!");
			else if (player.faceType != FACE_CAT && player.hasReptileEyes())
			{
				outputText("  Your eyes are");
				switch (player.eyeType)
				{
					case EYES_DRAGON: outputText(" prideful, fierce dragon eyes with vertically slitted pupils and burning orange irises. They glitter even in the darkness and they"); break;
					case EYES_LIZARD: outputText(" those of a lizard with vertically slitted pupils and green-yellowish irises. They"); break;
					case EYES_BASILISK: outputText(" basilisk eyes, grey reptilian pools with vertically slitted pupils. They");
				}
				outputText(" come with the typical second set of eyelids, allowing you to blink twice as much as others.");
				if (player.eyeType == EYES_BASILISK)
					outputText(" Others seem compelled to look into them.");
			}

			//Hair
			//if bald
			if (player.hairLength == 0) 
			{
				if (player.hasFur()) 
					outputText("  You have no hair, only a thin layer of fur atop of your head.  ");
				else outputText("  You are totally bald, showing only shiny " + player.skinTone + " " + player.skinDesc + " where your hair should be.");
				if (player.earType == EARS_HORSE) 
					outputText("  A pair of horse-like ears rise up from the top of your head.");
				else if (player.earType == EARS_FERRET) 
					outputText("  A pair of small, rounded ferret ears sit on top of your head.");
				else if (player.earType == EARS_DOG) 
					outputText("  A pair of dog ears protrude from your skull, flopping down adorably.");
				else if (player.earType == EARS_COW) 
					outputText("  A pair of round, floppy cow ears protrude from the sides of your skull.");
				else if (player.earType == EARS_ELFIN) 
					outputText("  A pair of large pointy ears stick out from your skull.");
				else if (player.earType == EARS_CAT) 
					outputText("  A pair of cute, fuzzy cat ears have sprouted from the top of your head.");
				else if (player.earType == EARS_PIG) 
					outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head.");
				else if (player.earType == EARS_LIZARD) 
					outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.");
				else if (player.earType == EARS_BUNNY) 
					outputText("  A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.");
				else if (player.earType == EARS_FOX) 
					outputText("  A pair of large, adept fox ears sit high on your head, always listening.");
				else if (player.earType == EARS_DRAGON) 
					outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.");
				else if (player.earType == EARS_RACCOON) 
					outputText("  A pair of vaguely egg-shaped, furry raccoon ears adorns your head.");
				else if (player.earType == EARS_MOUSE) 
					outputText("  A pair of large, dish-shaped mouse ears tops your head.");
				//<mod>
				else if (player.earType == EARS_PIG) 
					outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head.");
				else if (player.earType == EARS_RHINO) 
					outputText("  A pair of open tubular rhino ears protrude from your head.");
				else if (player.earType == EARS_ECHIDNA)
					outputText("  A pair of small rounded openings appear on your head that are your ears.");
				else if (player.earType == EARS_DEER) 
					outputText("  A pair of deer-like ears rise up from the top of your head.");
				else if (player.earType == EARS_WOLF) 
					outputText("  A pair of wolf ears stick out from your head, attuned to every sound around you.");
				//</mod>
				if (player.antennae == ANTENNAE_BEE) 
					outputText("  Floppy antennae also appear on your skull, bouncing and swaying in the breeze.");
			}
			//not bald
			else 
			{
				if (player.earType == EARS_HUMAN) 
					outputText("  Your [hair] looks good on you, accentuating your features well.");
				else if (player.earType == EARS_FERRET) 
					outputText("  A pair of small, rounded ferret ears burst through the top of your [hair].");
				else if (player.earType == EARS_HORSE) 
					outputText("  The [hair] on your head parts around a pair of very horse-like ears that grow up from your head.");
				else if (player.earType == EARS_DOG) 
					outputText("  The [hair] on your head is overlapped by a pair of pointed dog ears.");
				else if (player.earType == EARS_COW) 
					outputText("  The [hair] on your head is parted by a pair of rounded cow ears that stick out sideways.");
				else if (player.earType == EARS_ELFIN) 
					outputText("  The [hair] on your head is parted by a pair of cute pointed ears, bigger than your old human ones.");
				else if (player.earType == EARS_CAT) 
					outputText("  The [hair] on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises.");
				else if (player.earType == EARS_LIZARD) 
					outputText("  The [hair] atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears.");
				else if (player.earType == EARS_BUNNY) 
					outputText("  A pair of floppy rabbit ears stick up out of your [hair], bouncing around as you walk.");
				else if (player.earType == EARS_KANGAROO) 
					outputText("  The [hair] atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle.");
				else if (player.earType == EARS_FOX) 
					outputText("  The [hair] atop your head is parted by a pair of large, adept fox ears that always seem to be listening.");
				else if (player.earType == EARS_DRAGON) 
					outputText("  The [hair] atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.");
				else if (player.earType == EARS_RACCOON) 
					outputText("  The [hair] on your head parts around a pair of egg-shaped, furry raccoon ears.");
				else if (player.earType == EARS_MOUSE) 
					outputText("  The [hair] atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently.");
				//<mod> Mod-added ears
				else if (player.earType == EARS_PIG) 
					outputText("  The [hair] on your head is parted by a pair of pointy, floppy pig ears. They often flick about when you’re not thinking about it.");
				else if (player.earType == EARS_RHINO) 
					outputText("  The [hair] on your head is parted by a pair of tubular rhino ears.");
				else if (player.earType == EARS_ECHIDNA) 
					outputText("  Your [hair] makes it near-impossible to see the small, rounded openings that are your ears.");
				else if (player.earType == EARS_DEER) 
					outputText("  The [hair] on your head parts around a pair of deer-like ears that grow up from your head.");
				else if (player.earType == EARS_WOLF) 
					outputText("  A pair of wolf ears stick out from your head, parting your [hair] and remaining alert to your surroundings.");
				//</mod>
				if (player.gillType == GILLS_FISH) 
				{
					output.text("  A set of fish like gills reside on your neck, several small slits that can close flat against your skin."
					           +" They allow you to stay in the water for quite a long time.");
				}
				// GILLS_ANEMONE are handled below
				if (player.antennae == ANTENNAE_BEE) 
				{
					if (player.earType == EARS_BUNNY) 
						outputText("  Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
					else outputText("  Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
				}
			}
			
			//Beards!
			if (player.beardLength > 0) {
				outputText("  You have a " + player.beardDescript() + " ");
				if (player.beardStyle != BEARD_GOATEE) {
					outputText("covering your ");
					if (rand(2) == 0) outputText("jaw");
					else outputText("chin and cheeks")
				}
				else {
					outputText("protruding from your chin");
				}
				outputText(".");
			}
			
			//Tongue
			if (player.tongueType == TONGUE_SNAKE) 
				outputText("  A snake-like tongue occasionally flits between your lips, tasting the air.");
			else if (player.tongueType == TONGUE_DEMONIC) 
				outputText("  A slowly undulating tongue occasionally slips from between your lips.  It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.");
			else if (player.tongueType == TONGUE_DRACONIC) 
				outputText("  Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet.  It has sufficient manual dexterity that you can use it almost like a third arm.");
			else if (player.tongueType == TONGUE_ECHIDNA)
				outputText("  A thin echidna tongue, at least a foot long, occasionally flits out from between your lips.");
			else if (player.tongueType == TONGUE_LIZARD)
				outputText("  Your mouth contains a thick, fleshy lizard tongue, bringing to mind the tongue of large predatory reptiles."
				          +" It can reach up to one foot, its forked tips tasting the air as they flick at the end of each movement.");
			//Horns
			//Demonic horns
			if (player.hornType == HORNS_DEMON) 
			{
				if (player.horns == 2) 
					outputText("  A small pair of pointed horns has broken through the " + player.skinDesc + " on your forehead, proclaiming some demonic taint to any who see them.");
				if (player.horns == 4) 
					outputText("  A quartet of prominent horns has broken through your " + player.skinDesc + ".  The back pair are longer, and curve back along your head.  The front pair protrude forward demonically.");
				if (player.horns == 6) 
					outputText("  Six horns have sprouted through your " + player.skinDesc + ", the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost "+numInchesOrCentimetres(8)+" long upwards and a little forward.");
				if (player.horns >= 8) 
					outputText("  A large number of thick demonic horns sprout through your " + player.skinDesc + ", each pair sprouting behind the ones before.  The front jut forwards nearly "+numInchesOrCentimetres(10)+" while the rest curve back over your head, some of the points ending just below your ears.  You estimate you have a total of " + num2Text(player.horns) + " horns.");	
			}
			//Minotaur horns
			if (player.hornType == HORNS_COW_MINOTAUR) 
			{
				if (player.horns < 3) 
					outputText("  Two tiny horn-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.");
				if (player.horns >= 3 && player.horns < 6) 
					outputText("  Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.");
				if (player.horns >= 6 && player.horns < 12) 
					outputText("  Two large horns sprout from your forehead, curving forwards like those of a bull.");
				if (player.horns >= 12 && player.horns < 20) 
					outputText("  Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long.  They have dangerous looking points.");
				if (player.horns >= 20) 
					outputText("  Two huge horns erupt from your forehead, curving outward at first, then forwards.  The weight of them is heavy, and they end in dangerous looking points.");
			}
			//Lizard horns
			if (player.horns > 0 && player.hornType == HORNS_DRACONIC_X2) 
			{
				outputText("  A pair of " + numInchesOrCentimetres(player.horns) + " horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.");
			}
			//Super lizard horns
			if (player.hornType == HORNS_DRACONIC_X4_12_INCH_LONG) 
				outputText("  Two pairs of horns, roughly a foot long, sprout from the sides of your head.  They sweep back and give you a fearsome look, almost like the dragons from your village's legends.");
			//Antlers!
			if (player.hornType == HORNS_ANTLERS) 
			{
				if (player.horns > 0) 
					outputText("  Two antlers, forking into " + num2Text(player.horns) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.");
			}
			if (player.hornType == HORNS_GOAT)
			{
				if (player.horns == 1) 
					outputText("  A pair of stubby goat horns sprout from the sides of your head.");
				else
					outputText("  A pair of tall-standing goat horns sprout from the sides of your head.  They are curved and patterned with ridges.");
			}
			if (player.hornType == HORNS_RHINO)
			{
				if (player.horns >= 2) {
					if (player.faceType == FACE_RHINO)
						outputText("  A second horn sprouts from your forehead just above the horn on your nose.");
					else
						outputText("  A single horn sprouts from your forehead.  It is conical and resembles a rhino's horn.");
					outputText("  You estimate it to be about "+numInchesOrCentimetres(7)+" long.");
				}
				else {
					outputText("  A single horn sprouts from your forehead.  It is conical and resembles a rhino's horn.  You estimate it to be about "+numInchesOrCentimetres(6)+" long.");
				}
			}
			if (player.hornType == HORNS_UNICORN)
			{
				outputText("  A single sharp nub of a horn sprouts from the center of your forehead.");
				if (player.horns < 12)
					outputText("  You estimate it to be about "+numInchesOrCentimetres(6)+" long.");
				else
					outputText("  It has developed its own cute little spiral. You estimate it to be about "+numInchesOrCentimetres(12)+" long, "+numInchesOrCentimetres(2)+" thick and very sturdy. A very useful natural weapon.");
			}
			//BODY PG HERE
			outputText("\n\nYou have a humanoid shape with the usual torso, arms, hands, and fingers.");
			//WINGS!
			if (player.wingType == WING_TYPE_BEE_LIKE_SMALL) 
				outputText("  A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.");
			if (player.wingType == WING_TYPE_BEE_LIKE_LARGE) 
				outputText("  A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.");
			if (player.wingType == WING_TYPE_BAT_LIKE_TINY) 
				outputText("  A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.");
			if (player.wingType == WING_TYPE_BAT_LIKE_LARGE) 
				outputText("  A pair of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
			if (player.wingType == WING_TYPE_SHARK_FIN) 
				outputText("  A large shark-like fin has sprouted between your shoulder blades.  With it you have far more control over swimming underwater.");
			if (player.wingType == WING_TYPE_FEATHERED_LARGE) 
				outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the " + player.furColor + "-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.");
			if (player.wingType == WING_TYPE_DRACONIC_SMALL) 
				outputText("  Small, vestigial wings sprout from your shoulders.  They might look like bat's wings, but the membranes are covered in fine, delicate scales.");
			else if (player.wingType == WING_TYPE_DRACONIC_LARGE) 
				outputText("  Magnificent wings sprout from your shoulders.  When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
			else if (player.wingType == WING_TYPE_GIANT_DRAGONFLY) 
				outputText("  Giant dragonfly wings hang from your shoulders.  At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.");

			//Wing arms
			if (player.armType == ARM_TYPE_HARPY) 
				outputText("  Feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.");
			else if (player.armType == ARM_TYPE_WOLF) 
				outputText("  Your arms are shaped like a wolf's, overly muscular at your shoulders and biceps before quickly slimming down. They're covered in " + player.furColor + " fur and end in paws with just enough flexibility to be used as hands. They're rather difficult to move in directions besides back and forth.");	
			else if (player.armType == ARM_TYPE_SPIDER) 
				outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves from a distance.");	
			else if (player.armType == ARM_TYPE_SALAMANDER)
				outputText("  Shining thick, leathery red scales cover your arms from the biceps down and your fingernails are now short, fiery-red curved claws.");
			else if (player.armType == ARM_TYPE_PREDATOR)
				outputText("  Your arms are covered by [skinFurScales] and your fingernails are now " + player.claws() + ".");
			//Done with head bits. Move on to body stuff
			// <mod name="BodyParts.UnderBody" author="Stadler76">
			if (player.hasDifferentUnderBody())
				outputText("  While most of your body is covered by [skinFurScales] you have [underBody.skinFurScales] covering your belly.");
			// </mod>
			//Horse lowerbody, other lowerbody texts appear lower
			if (player.isTaur()) 
			{
				if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) 
					outputText("  From the waist down you have the body of a horse, with all " + num2Text(player.legCount)+ " legs capped by hooves.");
				else if (player.lowerBody == LOWER_BODY_TYPE_PONY) 
					outputText("  From the waist down you have an incredibly cute and cartoonish parody of a horse's body, with all " + num2Text(player.legCount)+ " legs ending in flat, rounded feet.");
				else
					outputText("  Where your legs would normally start you have grown the body of a feral animal, with all " + num2Text(player.legCount)+ " legs.");
			}
			if (player.isDrider()) 
				outputText("  Where your legs would normally start you have grown the body of a spider, with " + num2Text(player.legCount) + " spindly legs that sprout from its sides.");
			//Hip info only displays if you aren't a centaur. 
			if (!player.isTaur()) 
			{
				if (player.thickness > 70) 
				{
					outputText("  You have " + player.hipDescript());
					if (player.hipRating < 6) 
					{
						if (player.tone < 65) 
							outputText(" buried under a noticeable muffin-top, and");
						else outputText(" that blend into your pillar-like waist, and");
					}
					if (player.hipRating >= 6 && player.hipRating < 10) 
						outputText(" that blend into the rest of your thick form, and");
					if (player.hipRating >= 10 && player.hipRating < 15) 
						outputText(" that would be much more noticeable if you weren't so wide-bodied, and");
					if (player.hipRating >= 15 && player.hipRating < 20) 
						outputText(" that sway and emphasize your thick, curvy shape, and");
					if (player.hipRating >= 20) 
						outputText(" that sway hypnotically on your extra-curvy frame, and");
				}
				else if (player.thickness < 30) 
				{
					outputText("  You have " + player.hipDescript());
					if (player.hipRating < 6) 
						outputText(" that match your trim, lithe body, and");
					if (player.hipRating >= 6 && player.hipRating < 10) 
						outputText(" that sway to and fro, emphasized by your trim body, and");
					if (player.hipRating >= 10 && player.hipRating < 15) 
						outputText(" that swell out under your trim waistline, and");
					if (player.hipRating >= 15 && player.hipRating < 20) 
						outputText(", emphasized by your narrow waist, and");
					if (player.hipRating >= 20) 
						outputText(" that swell disproportionately wide on your lithe frame, and");
				}
				//STANDARD
				else 
				{
					outputText("  You have " + player.hipDescript());
					if (player.hipRating < 6) 
						outputText(", and");
					if (player.femininity > 50) 
					{
						if (player.hipRating >= 6 && player.hipRating < 10) 
							outputText(" that draw the attention of those around you, and");
						if (player.hipRating >= 10 && player.hipRating < 15) 
							outputText(" that make you walk with a sexy, swinging gait, and");
						if (player.hipRating >= 15 && player.hipRating < 20) 
							outputText(" that make it look like you've birthed many children, and");
						if (player.hipRating >= 20) 
							outputText(" that make you look more like an animal waiting to be bred than any kind of human, and");
					}
					else 
					{
						if (player.hipRating >= 6 && player.hipRating < 10) 
							outputText(" that give you a graceful stride, and");
						if (player.hipRating >= 10 && player.hipRating < 15) 
							outputText(" that add a little feminine swing to your gait, and");
						if (player.hipRating >= 15 && player.hipRating < 20) 
							outputText(" that force you to sway and wiggle as you move, and");
						if (player.hipRating >= 20) 
						{
							outputText(" that give your ");
							if (player.balls > 0) 
								outputText("balls plenty of room to breathe");
							else if (player.hasCock()) 
								outputText(player.multiCockDescript() + " plenty of room to swing");
							else if (player.hasVagina()) 
								outputText(player.vaginaDescript() + " a nice, wide berth");
							else outputText("vacant groin plenty of room");
							outputText(", and");
						}
					}
				}
			}
			//ASS
			//Horse version
			if (player.isTaur()) 
			{
				//FATBUTT
				if (player.tone < 65) 
				{
					outputText("  Your " + player.buttDescript());
					if (player.buttRating < 4) 
						outputText(" is lean, from what you can see of it.");
					if (player.buttRating >= 4 && player.buttRating < 6) 
						outputText(" looks fairly average.");
					if (player.buttRating >= 6 && player.buttRating <10) 
						outputText(" is fairly plump and healthy.");
					if (player.buttRating >= 10 && player.buttRating < 15) 
						outputText(" jiggles a bit as you trot around.");
					if (player.buttRating >= 15 && player.buttRating < 20) 
						outputText(" jiggles and wobbles as you trot about.");
					if (player.buttRating >= 20) 
						outputText(" is obscenely large, bordering freakish, even for a horse.");
				}
				//GIRL LOOK AT DAT BOOTY
				else 
				{
					outputText("  Your " + player.buttDescript());
					if (player.buttRating < 4) 
						outputText(" is barely noticeable, showing off the muscles of your haunches.");
					if (player.buttRating >= 4 && player.buttRating < 6) 
						outputText(" matches your toned equine frame quite well.");
					if (player.buttRating >= 6 && player.buttRating <10) 
						outputText(" gives hints of just how much muscle you could put into a kick.");
					if (player.buttRating >= 10 && player.buttRating < 15) 
						outputText(" surges with muscle whenever you trot about.");
					if (player.buttRating >= 15 && player.buttRating < 20) 
						outputText(" flexes its considerable mass as you move.");
					if (player.buttRating >= 20) 
						outputText(" is stacked with layers of muscle, huge even for a horse.");
				}
			}
			//Non-horse PCs
			else 
			{
				//TUBBY ASS
				if (player.tone < 60) 
				{
					outputText(" your " + player.buttDescript());
					if (player.buttRating < 4) 
						outputText(" looks great under your gear.");
					if (player.buttRating >= 4 && player.buttRating < 6) 
						outputText(" has the barest amount of sexy jiggle.");
					if (player.buttRating >= 6 && player.buttRating <10) 
						outputText(" fills out your clothing nicely.");
					if (player.buttRating >= 10 && player.buttRating < 15) 
						outputText(" wobbles enticingly with every step.");
					if (player.buttRating >= 15 && player.buttRating < 20) 
						outputText(" wobbles like a bowl full of jello as you walk.");
					if (player.buttRating >= 20) 
						outputText(" is obscenely large, bordering freakish, and makes it difficult to run.");
				}
				//FITBUTT
				else 
				{
					outputText(" your " + player.buttDescript());
					if (player.buttRating < 4) 
						outputText(" molds closely against your form.");
					if (player.buttRating >= 4 && player.buttRating < 6) 
						outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.");
					if (player.buttRating >= 6 && player.buttRating <10) 
						outputText(" fills out your clothing nicely.");
					if (player.buttRating >= 10 && player.buttRating < 15) 
						outputText(" stretches your gear, flexing it with each step.");
					if (player.buttRating >= 15 && player.buttRating < 20) 
						outputText(" threatens to bust out from under your kit each time you clench it.");
					if (player.buttRating >= 20) 
						outputText(" is marvelously large, but completely stacked with muscle.");
				}
			}
			//TAILS
			if (player.tailType == TAIL_TYPE_HORSE) 
				outputText("  A long " + player.hairColor + " horsetail hangs from your " + player.buttDescript() + ", smooth and shiny.");
			if (player.tailType == TAIL_TYPE_FERRET)
				outputText("  A long ferret tail sprouts from above your [butt].  It is thin, tapered, and covered in shaggy " + player.furColor + " fur.");
			if (player.tailType == TAIL_TYPE_DOG) 
				outputText("  A fuzzy " + player.furColor + " dogtail sprouts just above your " + player.buttDescript() + ", wagging to and fro whenever you are happy.");
			if (player.tailType == TAIL_TYPE_DEMONIC) 
				outputText("  A narrow tail ending in a spaded tip curls down from your " + player.buttDescript() + ", wrapping around your " + player.leg() + " sensually at every opportunity.");
			if (player.tailType == TAIL_TYPE_COW) 
				outputText("  A long cowtail with a puffy tip swishes back and forth as if swatting at flies.");
			if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) 
			{
				outputText("  A large, spherical spider-abdomen has grown out from your backside, covered in shiny black chitin.  Though it's heavy and bobs with every motion, it doesn't seem to slow you down.");
				if (player.tailVenom > 50 && player.tailVenom < 80) 
					outputText("  Your bulging arachnid posterior feels fairly full of webbing.");
				if (player.tailVenom >= 80 && player.tailVenom < 100) 
					outputText("  Your arachnid rear bulges and feels very full of webbing.");
				if (player.tailVenom == 100) 
					outputText("  Your swollen spider-butt is distended with the sheer amount of webbing it's holding.");
			}
			if (player.tailType == TAIL_TYPE_BEE_ABDOMEN) 
			{
				outputText("  A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.");
				if (player.tailVenom > 50 && player.tailVenom < 80) 
					outputText("  A single drop of poison hangs from your exposed stinger.");
				if (player.tailVenom >= 80 && player.tailVenom < 100) 
					outputText("  Poisonous bee venom coats your stinger completely.");
				if (player.tailVenom == 100) 
					outputText("  Venom drips from your poisoned stinger regularly.");
			}
			if (player.tailType == TAIL_TYPE_SHARK) 
			{
				outputText("  A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air.");
			}
			if (player.tailType == TAIL_TYPE_CAT) 
			{
				outputText("  A soft " + player.furColor + " cat-tail sprouts just above your " + player.buttDescript() + ", curling and twisting with every step to maintain perfect balance.");
			}
			if (player.tailType == TAIL_TYPE_LIZARD) 
			{
				if (player.hasDifferentUnderBody())
				{
					outputText("  A tapered tail, covered in [skinFurScales] with [underBody.skinFurScales] along its underside hangs down from just"
					          +" above your [ass].  It sways back and forth, assisting you with keeping your balance.");
				}
				else
				{
					outputText("  A tapered tail hangs down from just above your [ass].  It sways back and forth, assisting you with keeping your balance.");
				}
			}
			if(player.tailType == TAIL_TYPE_SALAMANDER) 
			{
				outputText("  A tapered, covered in red scales tail hangs down from just above your " + player.assDescript() + ".  It sways back and forth, assisting you with keeping your balance. When you are in battle or when you want could set ablaze whole tail in red-hot fire.");
			}
			if (player.tailType == TAIL_TYPE_RABBIT) 
				outputText("  A short, soft bunny tail sprouts just above your " + player.assDescript() + ", twitching constantly whenever you don't think about it.");
			else if (player.tailType == TAIL_TYPE_HARPY) 
				outputText("  A tail of feathers fans out from just above your " + player.assDescript() + ", twitching instinctively to help guide you if you were to take flight.");
			else if (player.tailType == TAIL_TYPE_KANGAROO) 
			{
				outputText("  A conical, ");
				if (player.hasGooSkin()) 
					outputText("gooey, " + player.skinTone);
				else outputText("furry, " + player.furColor);
				outputText(", tail extends from your " + player.assDescript() + ", bouncing up and down as you move and helping to counterbalance you.");
			}
			else if (player.tailType == TAIL_TYPE_FOX) 
			{
				if (player.tailVenom <= 1) 
					outputText("  A swishing " + player.furColor + " fox's brush extends from your " + player.assDescript() + ", curling around your body - the soft fur feels lovely.");
				else outputText("  " + Num2Text(player.tailVenom) + " swishing " + player.furColor + " fox's tails extend from your " + player.assDescript() + ", curling around your body - the soft fur feels lovely.");
			}
			else if (player.tailType == TAIL_TYPE_DRACONIC) 
			{
				if (player.hasDifferentUnderBody())
				{
					outputText("  A thin, prehensile reptilian tail, covered in [skinFurScales] with [underBody.skinFurScales] along its underside"
					          +" and almost as long as you are tall, swings behind you like a living bullwhip. Its tip menaces with spikes of bone,"
					          +" meant to deliver painful blows.");
				}
				else
				{
					outputText("  A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip.  Its tip menaces with spikes of bone, meant to deliver painful blows.");
				}
			}
			//appearance
			else if (player.tailType == TAIL_TYPE_RACCOON) 
			{
				outputText("  A black-and-" + player.furColor + "-ringed raccoon tail waves behind you.");
			}
			else if (player.tailType == TAIL_TYPE_MOUSE) 
			{
				//appearance
				outputText("  A naked, " + player.skinTone + " mouse tail pokes from your butt, dragging on the ground and twitching occasionally.");
			}
			//<mod>
			else if (player.tailType == TAIL_TYPE_BEHEMOTH) 
			{
				outputText("  A long seemingly-tapering tail pokes from your butt, ending in spikes just like behemoth's.");
			}
			else if (player.tailType == TAIL_TYPE_PIG) 
			{
				outputText("  A short, curly pig tail sprouts from just above your butt.");
			}
			else if (player.tailType == TAIL_TYPE_SCORPION) 
			{
				outputText("  A chitinous scorpion tail sprouts from just above your butt, ready to dispense venom.");
			}
			else if (player.tailType == TAIL_TYPE_GOAT) 
			{
				outputText("  A very short, stubby goat tail sprouts from just above your butt.");
			}
			else if (player.tailType == TAIL_TYPE_RHINO) 
			{
				outputText("  A ropey rhino tail sprouts from just above your butt, swishing from time to time.");
			}
			else if (player.tailType == TAIL_TYPE_ECHIDNA) 
			{
				outputText("  A stumpy echidna tail forms just about your [ass].");
			}
			else if (player.tailType == TAIL_TYPE_DEER) 
			{
				outputText("  A very short, stubby deer tail sprouts from just above your butt.");
			}
			else if (player.tailType == TAIL_TYPE_WOLF)
			{
				outputText("  A thick-furred wolf tail hangs above your [ass].");
			}
			//</mod>
			//LOWERBODY SPECIAL
			if (player.lowerBody == LOWER_BODY_TYPE_HUMAN) 
				outputText("  " + Num2Text(player.legCount)+ " normal human legs grow down from your waist, ending in normal human feet.");
			else if (player.lowerBody == LOWER_BODY_TYPE_FERRET) 
				outputText("  " + Num2Text(player.legCount)+ " furry, digitigrade legs form below your [hips].  The fur is thinner on the feet, and your toes are tipped with claws.");
			else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) 
				outputText("  Your " + num2Text(player.legCount)+ " legs are muscled and jointed oddly, covered in fur, and end in a bestial hooves.");
			else if (player.lowerBody == LOWER_BODY_TYPE_WOLF) 
				outputText("  You have " + num2Text(player.legCount) + " digitigrade legs that end in wolf paws.");
			else if (player.lowerBody == LOWER_BODY_TYPE_DOG) 
				outputText("  " + Num2Text(player.legCount)+ " digitigrade legs grow downwards from your waist, ending in dog-like hind-paws.");
			else if (player.lowerBody == LOWER_BODY_TYPE_NAGA)
				if (player.hasReptileUnderBody(true)) {
					var nagaColors:Array = ["", ""];
					if (player.underBody.type == UNDER_BODY_TYPE_NAGA)
						nagaColors = [player.underBody.skin.tone, player.nagaLowerBodyColor2()];
					else
						nagaColors = [player.skin.tone, player.underBody.skin.tone];

					outputText("  Below your waist, in place of where your legs would be, your body transitions into a long snake like tail."
					          +" Your snake-like lower body is covered by " + nagaColors[0] + " color scales,"
					          +" with " + nagaColors[1] + " color ventral scales along your underside.");
				} else
					outputText("  Below your waist your flesh is fused together into a very long snake-like tail.");
			//Horse body is placed higher for readability purposes
			else if (player.lowerBody == LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS) 
				outputText("  Your " + num2Text(player.legCount)+ " perfect lissome legs end in mostly human feet, apart from the horn protruding straight down from the heel that forces you to walk with a sexy, swaying gait.");
			else if (player.lowerBody == LOWER_BODY_TYPE_DEMONIC_CLAWS) 
				outputText("  Your " + num2Text(player.legCount)+ " lithe legs are capped with flexible clawed feet.  Sharp black nails grow where once you had toe-nails, giving you fantastic grip.");
			else if (player.lowerBody == LOWER_BODY_TYPE_BEE) 
				outputText("  Your " + num2Text(player.legCount)+ " legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.  A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee.");
			else if (player.lowerBody == LOWER_BODY_TYPE_GOO) 
				outputText("  In place of legs you have a shifting amorphous blob.  Thankfully it's quite easy to propel yourself around on.  The lowest portions of your " + player.armorName + " float around inside you, bringing you no discomfort.");
			else if (player.lowerBody == LOWER_BODY_TYPE_CAT) 
				outputText("  " + Num2Text(player.legCount)+ " digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws.");
			else if (player.lowerBody == LOWER_BODY_TYPE_LIZARD) 
				outputText("  " + Num2Text(player.legCount)+ " digitigrade legs grow down from your " + player.hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
			else if(player.lowerBody == LOWER_BODY_TYPE_SALAMANDER) 
				outputText("  " + Num2Text(player.legCount)+ " digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your " + player.hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
			else if (player.lowerBody == LOWER_BODY_TYPE_BUNNY) 
				outputText("  Your " + num2Text(player.legCount)+ " legs thicken below the waist as they turn into soft-furred rabbit-like legs.  You even have large bunny feet that make hopping around a little easier than walking.");
			else if (player.lowerBody == LOWER_BODY_TYPE_HARPY) 
				outputText("  Your " + num2Text(player.legCount)+ " legs are covered with " + player.furColor + " plumage.  Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.");
			else if (player.lowerBody == LOWER_BODY_TYPE_KANGAROO) 
				outputText("  Your " + num2Text(player.legCount)+ " furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes.");
			else if (player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS) 
				outputText("  Your " + num2Text(player.legCount)+ " legs are covered in a reflective black, insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.");
			else if (player.lowerBody == LOWER_BODY_TYPE_FOX) 
				outputText("  Your " + num2Text(player.legCount)+ " legs are crooked into high knees with hocks and long feet, like those of a fox; cute bulbous toes decorate the ends.");
			else if (player.lowerBody == LOWER_BODY_TYPE_DRAGON) 
				outputText("  " + Num2Text(player.legCount)+ " human-like legs grow down from your " + player.hipDescript() + ", sheathed in scales and ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.");
			else if (player.lowerBody == LOWER_BODY_TYPE_RACCOON) 
				outputText("  Your " + num2Text(player.legCount)+ " legs, though covered in fur, are humanlike.  Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch.");
			else if (player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED) 
				outputText("  " + Num2Text(player.legCount)+ " digitigrade legs form below your [hips], ending in cloven hooves.");
			if (player.findPerk(PerkLib.Incorporeality) >= 0)
				outputText("  Of course, your " + player.legs() + " are partially transparent due to their ghostly nature."); // isn't goo transparent anyway?
			outputText("\n");
			if (player.hasStatusEffect(StatusEffects.GooStuffed))
			{
				outputText("\n<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>\n");
			}
			//Pregnancy Shiiiiiitz
			if ((player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) || player.isPregnant()) 
			{
				if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) 
				{
					outputText("<b>");
					//Compute size
					temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
					if (player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20) 
					{
						outputText("Your swollen pregnant belly is as large as a ");
						if (temp < 10) 
							outputText("basketball.");
						if (temp >= 10 && temp < 20) 
							outputText("watermelon.");
						if (temp >= 20) 
							outputText("beach ball.");
					}
					if (player.pregnancyIncubation <= 20) 
					{
						outputText("Your swollen pregnant belly is as large as a ");
						if (temp < 10) 
							outputText("watermelon.");
						if (temp >= 10 && temp < 20) 
							outputText("beach ball.");
						if (temp >= 20) 
							outputText("large medicine ball.");
					}
					outputText("</b>");
					temp = 0;
				}
				//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
				else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > player.pregnancyIncubation) 
				{
					if (player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75) 
					{
						outputText("<b>You've got the beginnings of a small pot-belly.</b>");
					}
					else if (player.buttPregnancyIncubation >= 50) 
					{
						outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>");	
					}
					else if (player.buttPregnancyIncubation >= 30) 
					{
						outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
					}
					else 
					{ //Surely Benoit and Cotton deserve their place in this list
						if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (flags[kFLAGS.JOJO_STATUS] <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
						else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
						else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
					}
				}
				//URTA PREG
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA) 
				{
					if (player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360)
					{
						outputText("<b>Your belly is larger than it used to be.</b>\n");
					}
					if (player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288) 
					{
						outputText("<b>Your belly is more noticeably distended.   You're pretty sure it's Urta's.</b>");
					}
					if (player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216) 
					{
						outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>");
					}
					if (player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144) 
					{
						outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you.  It's gotten heavy enough to be a pain to carry around all the time.</b>");
					}
					if (player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72) 
					{
						outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.  It's large and round, frequently moving.</b>");
					}
					if (player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) 
					{
						outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
					}
					if (player.pregnancyIncubation <= 48) 
					{
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
					}
				}
				else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) 
				{
					if (player.buttPregnancyIncubation >= 8) 
						outputText("<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>");
					else outputText("<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>");
				}
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
					outputText("<b>Your belly remains swollen like a watermelon. ");
					if (player.pregnancyIncubation <= 100)
						outputText("It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>");
					else if (player.pregnancyIncubation <= 140)
						outputText("It feels like it’s full of thick syrup or jelly.</b>");
					else outputText("It still feels like there’s a solid ball inside your womb.</b>");    
				}
				else 
				{
					if (player.pregnancyIncubation <= 336 && player.pregnancyIncubation > 280)
					{
						outputText("<b>Your belly is larger than it used to be.</b>");
					}
					if (player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216) 
					{
						outputText("<b>Your belly is more noticeably distended.   You are probably pregnant.</b>");
					}
					if (player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180) 
					{
						outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>");
					}
					if (player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120) 
					{
						outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>");
					}
					if (player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72) 
					{
						outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>");
					}
					if (player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) 
					{
						outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
					}
					if (player.pregnancyIncubation <= 48) 
					{ //Surely Benoit and Cotton deserve their place in this list
						if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && flags[kFLAGS.JOJO_STATUS] <= 0) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
						else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE) 
							outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
						else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
					}
				}
				outputText("\n");
			}
			outputText("\n");
			if (player.gillType == GILLS_ANEMONE) 
				outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest.  They allow you to stay in the water for quite a long time.  ");
			//Chesticles..I mean bewbz.
			if (player.breastRows.length == 1) 
			{
				outputText("You have " + num2Text(player.breastRows[temp].breasts) + " " + player.breastDescript(temp) + ", each supporting ");
				outputText( player.breastRows[temp].nipplesPerBreast == 1 ? "a" : num2Text(player.breastRows[temp].nipplesPerBreast)); //Number of nipples.
				outputText(" " + shortSuffix(player.nippleLength) + " ");		  // Length of nipples
				outputText(player.nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? "." : "s.")); //Nipple description and plural
				if (player.breastRows[0].milkFullness > 75) 
					outputText("  Your " + player.breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.");
				if (player.breastRows[0].breastRating >= 1) 
					outputText("  You could easily fill a " + player.breastCup(temp) + " bra.");
				//Done with tits.  Move on.
				outputText("\n");
			}
			//many rows
			else 
			{
				outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n");
				while (temp < player.breastRows.length) 
				{
					if (temp == 0) 
						outputText("--Your uppermost rack houses ");
					if (temp == 1) 
						outputText("\n--The second row holds ");
					if (temp == 2) 
						outputText("\n--Your third row of breasts contains ");
					if (temp == 3) 
						outputText("\n--Your fourth set of tits cradles ");
					if (temp == 4) 
						outputText("\n--Your fifth and final mammary grouping swells with ");
					outputText(num2Text(player.breastRows[temp].breasts) + " " + player.breastDescript(temp) + " with ");
					outputText(num2Text(player.breastRows[temp].nipplesPerBreast)); //Number of nipples per breast
					outputText(" " + shortSuffix(player.nippleLength) + " ");		// Length of nipples
					outputText(player.nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each.")); //Description and Plural
					if (player.breastRows[temp].breastRating >= 1) 
						outputText("  They could easily fill a " + player.breastCup(temp) + " bra.");
					if (player.breastRows[temp].milkFullness > 75) 
						outputText("  Your " + player.breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.");
					temp++;
				}
				//Done with tits.  Move on.
				outputText("\n");
			}	
			//Crotchial stuff - mention snake
			if (player.lowerBody == LOWER_BODY_TYPE_NAGA && player.gender > 0) 
			{
				outputText("\nYour sex");
				if (player.gender == 3 || player.cocks.length > 1) 
					outputText("es are ");
				else outputText(" is ");
				outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n");
			}

			// Cock Descriptions //
			if (player.hasCock()) {
				rando = rand(100);

				// Is taur and has multiple cocks?
				if      (player.isTaur() && player.cocks.length == 1)
					outputText("\nYour equipment has shifted to lie between your hind legs, like a feral animal.");
				else if (player.isTaur())
					outputText("\nBetween your hind legs, you have grown " + player.multiCockDescript() + "!\n");
				else if (player.cocks.length == 1)
					outputText("\n");
				else
					outputText("\nWhere a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!\n");
			
				for (var cock_index:int = 0; cock_index < player.cocks.length; cock_index++) {
					rando++;

					// How to start the sentence?
					if  (player.cocks.length == 1)  outputText("Your ");
					else if (cock_index == 0)      outputText("--Your first ");
					else if (rando % 5 == 0)       outputText("--The next ");
					else if (rando % 5 == 1)       outputText("--The " + num2Text2(cock_index+1) + " of your ");
					else if (rando % 5 == 2)       outputText("--One of your ");
					else if (rando % 5 == 3)       outputText("--The " + num2Text2(cock_index+1) + " ");
					else if (rando % 5 == 4)       outputText("--Another of your ");

					// How large?
					outputText(player.cockDescript(cock_index) + ((rando % 5) % 3 == 0 || cock_index == 0 ? "":"s") +  " is " + inchesOrCentimetres(player.cocks[cock_index].cockLength) + " long and ");
					outputText(inchesOrCentimetres(player.cocks[cock_index].cockThickness));
					if      (rando % 3 == 0)  outputText(" wide.");
					else if (rando % 3 == 1)  outputText(" thick.");
					else if (rando % 3 == 2)  outputText(" in diameter.");

					// What flavor of cock do you have?
					if (player.cocks[cock_index].cockType == CockTypesEnum.HORSE) 
						outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of its shaft flares proudly, just like a horse's.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.DOG) 
						outputText("  It is shiny, pointed, and covered in veins, just like a large dog's cock.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.WOLF) 
						outputText("  It is shiny red, pointed, and covered in veins, just like a large wolf's cock.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.FOX) 
						outputText("  It is shiny, pointed, and covered in veins, just like a large fox's cock.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.DEMON) 
						outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.TENTACLE) 
						outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.CAT) 
						outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.LIZARD) 
						outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.ANEMONE) 
						outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.KANGAROO) 
						outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.DRAGON) 
						outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.BEE)
						outputText("  It's a long, smooth black shaft that's rigid to the touch.  Its base is ringed with a layer of " + shortSuffix(4) + " long soft bee hair.  The tip has a much finer layer of short yellow hairs.  The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.PIG)
						outputText("  It's bright pinkish red, ending in a prominent corkscrew shape at the tip.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.AVIAN)
						outputText("  It's a red, tapered cock that ends in a tip.  It rests nicely in a sheath.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.RHINO)
						outputText("  It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center.");
					else if (player.cocks[cock_index].cockType == CockTypesEnum.ECHIDNA)
						outputText("  It is quite a sight to behold, coming well-equipped with four heads.");

					// Knot?
					if (player.cocks[cock_index].knotMultiplier > 1) {
						if (player.cocks[cock_index].knotMultiplier >= 1.8) 
							outputText("  The obscenely swollen lump of flesh near the base of your " + player.cockDescript(cock_index) + " looks almost comically mismatched for your cock.");
						else if (player.cocks[cock_index].knotMultiplier >= 1.4) 
							outputText("  A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(cock_index) + ", to ensure it stays where it belongs during mating.");
						else // knotMultiplier < 1.4
							outputText("  A small knot of thicker flesh is near the base of your " + player.cockDescript(cock_index) + ", ready to expand to help you lodge it inside a female.");
						outputText("  The knot is " + inchesOrCentimetres(player.cocks[cock_index].cockThickness * player.cocks[cock_index].knotMultiplier) + " thick when at full size.");
					}

					// Sock Flavor
					if (player.cocks[cock_index].sock != "" && player.cocks[cock_index].sock != null){
						// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
						// Anyways, check against null values, and stuff works again.
						trace("Found a sock description (WTF even is a sock?)", player.cocks[cock_index].sock);
						sockDescript(cock_index);
					}
					outputText("\n");
				}

				//Worm flavor
				if (player.hasStatusEffect(StatusEffects.Infested))
					outputText("Every now and again slimy worms coated in spunk slip partway out of your " + player.multiCockDescriptLight() + ", tasting the air like tongues of snakes.\n");
			}


			//Of Balls and Sacks!
			if (player.balls > 0) 
			{
				if (player.hasStatusEffect(StatusEffects.Uniball))
				{
					if (player.hasGooSkin()) 
						outputText("Your [sack] clings tightly to your groin, dripping and holding " + player.ballsDescript() + " snugly against you.");
					else
						outputText("Your [sack] clings tightly to your groin, holding " + player.ballsDescript() + " snugly against you.");
				}
				else if (player.cocks.length == 0) 
				{
					if (player.hasPlainSkin()) 
						outputText("A " + player.sackDescript() + " with " + player.ballsDescript() + " swings heavily under where a penis would normally grow.");
					if (player.hasFur()) 
						outputText("A fuzzy " + player.sackDescript() + " filled with " + player.ballsDescript() + " swings low under where a penis would normally grow.");
					if (player.hasScales()) 
						outputText("A scaley " + player.sackDescript() + " hugs your " + player.ballsDescript() + " tightly against your body.");
					if (player.hasGooSkin()) 
						outputText("An oozing, semi-solid sack with " + player.ballsDescript() + " swings heavily under where a penis would normally grow.");
				}
				else 
				{
					if (player.hasPlainSkin()) 
						outputText("A " + player.sackDescript() + " with " + player.ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".");
					if (player.hasFur()) 
						outputText("A fuzzy " + player.sackDescript() + " filled with " + player.ballsDescript() + " swings low under your " + player.multiCockDescriptLight() + ".");
					if (player.hasScales()) 
						outputText("A scaley " + player.sackDescript() + " hugs your " + player.ballsDescript() + " tightly against your body.");
					if (player.hasGooSkin()) 
						outputText("An oozing, semi-solid sack with " + player.ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".");
				}
				outputText("  You estimate each of them to be about " + numInchesOrCentimetres(player.ballSize) + " across\n");
			}	
			//VAGOOZ
			if (player.vaginas.length > 0) 
			{
				if (player.gender == 2 && player.isTaur()) 
					outputText("\nYour womanly parts have shifted to lie between your hind legs, in a rather feral fashion.");
				outputText("\n");
				if (player.vaginas.length == 1) 
					outputText("You have a " + player.vaginaDescript(0) + ", with a " + inchesOrCentimetres(player.getClitLength()) + " clit");
				if (player.vaginas[0].virgin) 
					outputText(" and an intact hymen"); // Wait, won't this fuck up, with multiple vaginas?
				outputText(".  ");
				if (player.vaginas.length > 1) 
					outputText("You have " + player.vaginas.length+ " " + player.vaginaDescript(0) + "s, with " + inchesOrCentimetres(player.getClitLength()) + "-centimetre clits each.  ");
				if (player.lib < 50 && player.lust < 50) //not particularly horny
				
				{
					//Wetness
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness< VAGINA_WETNESS_DROOLING) 
						outputText("Moisture gleams in ");
					if (player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_DROOLING) 
					{
						outputText("Occasional beads of ");
						outputText("lubricant drip from ");
					}
					//Different description based on vag looseness
					if (player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_WET) 
					{
						if (player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_LOOSE) 
							outputText("your " + player.vaginaDescript(0) + ". ");
						if (player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_GAPING_WIDE) 
							outputText("your " + player.vaginaDescript(0) + ", its lips slightly parted. ");
						if (player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_GAPING_WIDE) 
							outputText("the massive hole that is your " + player.vaginaDescript(0) + ".  ");
					}
				}
				if ((player.lib>=50 || player.lust >=50) && (player.lib< 80 && player.lust < 80)) //kinda horny
				
				{
					//Wetness
					if (player.vaginas[0].vaginalWetness< VAGINA_WETNESS_WET) 
						outputText("Moisture gleams in ");
					if (player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness< VAGINA_WETNESS_DROOLING) 
					{
						outputText("Occasional beads of ");
						outputText("lubricant drip from ");
					}
					if (player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_DROOLING) 
					{
						outputText("Thin streams of ");
						outputText("lubricant occasionally dribble from ");
					}
					//Different description based on vag looseness
					if (player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_LOOSE) 
						outputText("your " + player.vaginaDescript(0) + ". ");
					if (player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_GAPING_WIDE) 
						outputText("your " + player.vaginaDescript(0) + ", its lips slightly parted. ");
					if (player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_GAPING_WIDE) 
						outputText("the massive hole that is your " + player.vaginaDescript(0) + ".  ");
				}
				if ((player.lib> 80 || player.lust > 80)) //WTF horny!
				
				{
					//Wetness
					if (player.vaginas[0].vaginalWetness< VAGINA_WETNESS_WET) 
					
					{
						outputText("Occasional beads of ");
						outputText("lubricant drip from ");
					}
					if (player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness< VAGINA_WETNESS_DROOLING)
					
					{
						outputText("Thin streams of ");
						outputText("lubricant occasionally dribble from ");
					}
					if (player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_DROOLING) 
					
					{
						outputText("Thick streams of ");
						outputText("lubricant drool constantly from ");
					}
					//Different description based on vag looseness
					if (player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_LOOSE) 
						outputText("your " + player.vaginaDescript(0) + ". ");
					if (player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_GAPING_WIDE) 
						outputText("your " + player.vaginaDescript(0) + ", its lips slightly parted. ");
					if (player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_GAPING_WIDE) 
						outputText("the massive hole that is your cunt.  ");
				}
				//Line Drop for next descript!
				outputText("\n");
			}
			//Genderless lovun'
			if (player.cocks.length == 0 && player.vaginas.length == 0) 
				outputText("\nYou have a curious lack of any sexual endowments.\n");
			
			
			//BUNGHOLIO
			if (player.ass) 
			{
				outputText("\n");
				outputText("You have one " + player.assholeDescript() + ", placed between your butt-cheeks where it belongs.\n");
			}
			//Piercings!
			if (player.eyebrowPierced > 0) 
				outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.");
			if (player.earsPierced > 0) 
				outputText("\nYour ears are pierced with " + player.earsPShort + ".");
			if (player.nosePierced > 0) 
				outputText("\nA " + player.nosePShort + " dangles from your nose.");
			if (player.lipPierced > 0) 
				outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.");
			if (player.tonguePierced > 0) 
				outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.");
			if (player.nipplesPierced == 3) 
				outputText("\nYour " + player.nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.");
			else if (player.nipplesPierced > 0) 
				outputText("\nYour " + player.nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".");
			if (player.cocks.length > 0) 
			{
				if (player.cocks[0].pierced > 0) 
				{
					outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your " + player.cockDescript(0) + ".");
				}
			}
			if (flags[kFLAGS.CERAPH_BELLYBUTTON_PIERCING] == 1) 
				outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.");
			if (player.hasVagina()) 
			{
				if (player.vaginas[0].labiaPierced > 0) 
					outputText("\nYour " + player.vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips.");
				if (player.vaginas[0].clitPierced > 0) 
					outputText("\nImpossible to ignore, your " + player.clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ".");
			}
			//MONEY!
			if (player.gems == 0) 
				outputText("\n\n<b>Your money-purse is devoid of any currency.");
			else if (player.gems == 1) 
				outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gem, collected in your travels.");
			else if (player.gems > 1) 
				outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.");
			else {
				outputText("\n\n<b>Something is wrong with your gems!</b>");
			}
			menu();
			doNext(playerMenu);
			output.flush();
		}

		public function sockDescript(index:int):void 
		{
			outputText("  ");
			if (player.cocks[index].sock == "wool") 
				outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");
			else if (player.cocks[index].sock == "alabaster") 
				outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");
			else if (player.cocks[index].sock == "cockring") 
				outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");
			else if (player.cocks[index].sock == "viridian") 
				outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns.  Just wearing it makes your body, especially your cock, tingle.");
			else if (player.cocks[index].sock == "scarlet") 
				outputText("It's covered by a lacey red cock-sock that clings tightly to your member.  Just wearing it makes your cock throb, as if it yearns to be larger...");
			else if (player.cocks[index].sock == "cobalt") 
				outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly.  It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");
			else if (player.cocks[index].sock == "gilded") 
				outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems.  Despite the warmth of your body, the cock-sock remains cool.");
			else if (player.cocks[index].sock == "amaranthine") 
			
			{
				outputText("It's covered by a lacey purple cock-sock");
				if (player.cocks[index].cockType != CockTypesEnum.DISPLACER) 
					outputText(" that fits somewhat awkwardly on your member");
				else
					outputText(" that fits your coeurl cock perfectly");
				outputText(".  Just wearing it makes you feel stronger and more powerful.");
			}
			else if (player.cocks[index].sock == "red") 
				outputText("It's covered by a red cock-sock that seems to glow.  Just wearing it makes you feel a bit powerful.");
			else if (player.cocks[index].sock == "green") 
				outputText("It's covered by a green cock-sock that seems to glow.  Just wearing it makes you feel a bit healthier.");
			else if (player.cocks[index].sock == "blue") 
				outputText("It's covered by a blue cock-sock that seems to glow.  Just wearing it makes you feel like you can cast spells more effectively.");

			else outputText("<b>Yo, this is an error.</b>");
		}
		
	}
}
