package classes.Transformations.Transformations {
import classes.Cock;
import classes.CockTypesEnum;
import classes.GeneticMemories.CockCountMem;
import classes.GeneticMemories.CockMem;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;
import classes.Transformations.*;
import classes.VaginaClass;

/**
 * Base class for transformation events.
 */
public class CockTransformations extends MutationsHelper {
	/*
    *	  ██████  ██████   ██████ ██    ██
    *	 ██      ██    ██ ██      ██  ██
    *	 ██      ██    ██ ██      ████
    *	 ██      ██    ██ ██      ██  ██
    *	  ██████  ██████   ██████ ██    ██
    */

	/*
        */
	public function UnlockCocks():void {
		//noinspection FallThroughInSwitchStatementJS	// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
		switch (player.cockTotal()) {
			case 10: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK10));
			case 9: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK9));
			case 8: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK8));
			case 7: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK7));
			case 6: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK6));
			case 5: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK5));
			case 4: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK4));
			case 3: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK3));
			case 2: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK2));
			case 1: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK1));
				break;
		}
	}

	public function CockNone(index:int = 0): Transformation {
		return new SimpleTransformation("Remove Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = (index < 0) ? rand(player.cocks.length) : index;

					desc += "You have a strange feeling as your crotch tingles.  Opening your [armor], <b>you realize that one of your cocks have vanished completely!</b>";
					if (doOutput) outputText(desc);

					player.removeCock(cock, 1);
				},
				// is present
				function ():Boolean {
					return index < 0 ? player.cockTotal() > 0 : index >= player.cockTotal();
				}
		);
	}

	public function GrowCockGenericText(): String {
		var desc:String = "";
		if (player.isTaur()) desc += "You feel a sudden stabbing pain between your back legs" +(player.hasVagina()?" just below your [vagina]":"")+" and bend over, moaning in agony. falling on your back so you can get a stare at your hindquarters you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		else if (!player.hasVagina() && !player.hasCock()) desc +="You feel a sudden stabbing pain in your groin and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		else if (player.hasCock()) desc += "You feel a sudden stabbing pain above your [cocks] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		else desc +="You feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		return desc;
	}

	// convert -1 to 'first not of that type'
	private function cockIndex(cock:int, type:CockTypesEnum):int {
		if (cock >= 0) return cock;
		for (cock = 0; cock < player.cocks.length; cock++) if (player.cocks[cock].cockType != type) return cock;
		return 0
	}
	// -1: are all cocks this type
	private function isPresentCock(index:int, type:CockTypesEnum):Boolean {
		if (player.cocks.length == 0) return false;
		if (index == -1) return player.countCocksOfType(type) == player.cocks.length;
		return index < player.cocks.length && player.cocks[index].cockType == type;
	}
	
	public function CockHuman(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Human Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.HUMAN);

					if (player.cocks.length > cock){
						desc += "A strange tingling begins behind your [cock], slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your [armor] to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, "+
								"<b>leaving you with a completely human penis.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += ", you are the proud owner of "+(player.hasVagina()?" not only a [vagina], but":"")+"<b> You now have a human cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.HUMAN;

					transformations.UnlockCocks();
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.HUMAN);
				}
		);
	}

	public function CockHorse(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Horse Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.HORSE);

					if (player.cockTotal() > cock){
						desc += "Your [cock "+(cock+1)+"] begins to feel strange.  You pull down your clothes to take a look and see it darkening";

						desc += player.hasSheath()? "." : " as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.";
						desc += "  The shaft suddenly explodes with movement, growing longer and developing a thick flared head, leaking a steady stream of animal-cum.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond its previous size and takes on a more leathery texture.";

						//Text for dogdicks
						if (player.hasKnot(cock)) desc += "  You notice your knot vanishing, the extra flesh pushing more fresh horsecock out from your sheath.";
						else desc += "  The skin is mottled brown and black and feels more sensitive than normal.";

					}
					else {
						desc += GrowCockGenericText();
						desc += "your cock begins to feel strange... you see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.HORSE;
					player.cocks[cock].knotMultiplier = 1;
					if (doOutput) outputText("<b>  Your hands are drawn to the strange new [cock "+(cock+1)+"]</b>, and you jerk yourself off, splattering thick ropes of cum with intense force.");

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.HORSE));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.HORSE)
				}
		);
	}

	public function CockKirin(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Kirin Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.KIRIN);

					if (player.isTaur()){
						desc += "You moan in confusion as changes rushes to your rapidly hardening [cock "+(cock+1)+"] which begins unloading shots after shots of neon blue cum." +
								" Wait, what? When you look between your forelegs to inspect your [cock "+(cock+1)+"] you discover it to indeed be dripping neon blue plasma.";
					}
					else{
						desc += "You feel a sudden itch in your privates and undress as an irrepressible desire to masturbate takes hold of you." +
								" You keep stroking your twitching [cock "+(cock+1)+"], moaning as you cum neon blue fluids." +
								" Wait, what? When you inspect your [cock "+(cock+1)+"] you discover it to indeed be dripping neon blue plasma.";
					}
					desc += " A sudden rush of pleasure causes you to moan and arch your back as your penis starts to throb again.";

					if (player.cockTotal() > cock){
						desc += " Your overwhelmed cock begins to change further";

						desc += player.hasSheath()? "." : " as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.";
						desc += "  The shaft suddenly explodes with movement, growing longer and developing a thick flared head, leaking a steady stream of plasma.  Your cock pushes out of your sheath, inch after inch of blue flesh growing beyond its previous size and takes on a more leathery texture.";

						//Text for dogdicks
						if (player.hasKnot(cock)) desc += "  You notice your knot vanishing, the extra flesh pushing more fresh horsecock out from your sheath.";
						else desc += "  The skin is pale blue and feels more sensitive than normal.";

					}
					else {
						desc += GrowCockGenericText();
						desc += "Your overwhelmed cock begins to change further... you see it change color as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member, lightning coating its shape, as it suddenly grows into a horse-like penis, dwarfing its old size. The skin is a glowing pale blue and feels more sensitive than normal. Unable to hold the flow of pleasure back you spontaneously begin splattering cum with intense force.";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.KIRIN;
					player.cocks[cock].knotMultiplier = 1;
					if (doOutput) outputText("<b>  Unable to hold the flow of pleasure back you spontaneously cum from your [cock "+(cock+1)+"], splattering thick ropes of plasma with intense force.</b>");

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.KIRIN));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.KIRIN)
				}
		);
	}

	public function CockDog(index:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.4): Transformation {
		return new SimpleTransformation("Dog Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.DOG);

					if (player.cocks.length > cock){
						if (player.cocks[cock].cockType == CockTypesEnum.HORSE) {
							desc += "Your [cock "+(cock+1)+"] shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes and you";
							//Tweak length/thickness.
							if (player.cocks[cock].cockLength > 6) player.cocks[cock].cockLength -= 2;
							else player.cocks[cock].cockLength -= .5;
							player.cocks[cock].cockThickness += .5;
						}
						else if (["tentacle","plant"].indexOf(player.cocks[cock].cockType.Group) >= 0)
							desc += "Your [cock "+(cock+1)+"] coils in on itself, reshaping and losing its coloration, becoming a shiny red. You";
						else desc += "Your [cock "+(cock+1)+"] clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. You"
						desc += " shudder as the crown of your [cock "+(cock+1)+"] reshapes into a point, the sensations nearly too much for you. "
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						if (player.cocks[cock].knotMultiplier <= 1) desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. "
						else if (player.cocks[cock].knotMultiplier < knot) desc += "The knot on your new red pecker grows extremely sensitive as it grows thicker than before. ";
						desc += "You throw back your head as the transformation completes, your cock much thicker than before.  <b>You now have a dog-cock.</b>";

					}
					else {
						desc += GrowCockGenericText();
						desc += "Your cock clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. ";
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. ";
						desc += "You throw back your head as the transformation completes, that was intense!  <b>You now have a dog-cock.</b>"
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.DOG;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DOG));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.DOG)
				}
		);
	}

	public function CockDemon(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Demon Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.DEMON);

					if (player.cocks.length > cock){

						desc += "You smile, watching your [cock] grow longer.  Inches of newfound dick-flesh erupt from your crotch.  Before you can play with your transformed tool, a wave of burning desire passes through you.  ";
						if(player.cor < 80) desc += "You watch in horror as the skin of your [cock] turns shiny and purplish-black.  ";
						else desc += "Curious, you watch the skin of your [cock] turn a shiny-dark purple.  ";

						if(player.cor < 50) desc += "Corrupt nodules begin to spring up over its entire length.  <b>Your penis is transforming into a demon cock!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the head.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crown of your [cock], seemingly completing its transformation, until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes!  ";
						else desc += "As you watch expectantly, tiny wriggling nodules begin to erupt from the purplish skin, like those magnificent cocks you saw on demons!  <b>Your penis is transforming into a demon cock!</b>  You pant and moan in happiness as it lengthens one last time.  As you stroke all of its amazing length with both hands, the excitement of possessing such a beautiful pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your [cock]'s crown, you notice that the squirts getting out of your cock-slit are not completely white and gradually become darker, the last drops being pitch-black! Your new [cock] pulsates darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid, which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke the huge, dark, bumpy shaft, that if this feels as good as this looks, it doesn't really matter.  ";
					}
					else {
						if (!player.hasVagina() && !player.hasCock()) desc +="A sudden pressure builds in your groin ";
						else if (player.hasCock()) desc += "A sudden pressure builds above your [cocks] ";
						else desc +="A sudden pressure builds just above your [vagina] ";
						desc += "and you bend over, stripping off your clothes.You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ";
						if(player.cor < 80) desc += "In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.";
						else desc +="Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...";
						desc += "<b> You now have a demon dick!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].cockThickness < 2)
						player.cocks[0].cockThickness = 2;
					player.cocks[cock].cockType = CockTypesEnum.DEMON;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DEMON));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.DEMON)
				}
		);
	}

	public function CockTentacle(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Tentacle Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.TENTACLE);

					if (player.cocks.length > cock){
						desc += "Your " + num2Text2(cock+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your [cock "+(cock+1)+"] has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a";

						if(player.tentacleCocks() > 0) desc +="nother";
						desc +=" tentacle-cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "Your feel it bending and flexing of its own volition... looking down, you see it morph into a green vine-like shape.  <b>You now have a tentacle cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.3) player.cocks[cock].knotMultiplier = 1.3;
					player.cocks[cock].cockType = CockTypesEnum.TENTACLE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.TENTACLE));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.TENTACLE)
				}
		);
	}

	public function CockScylla(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Scylla Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.SCYLLATENTACLE);

					if (player.cocks.length > cock){
						desc += "Your feel your [cock "+(cock+1)+"] bending and flexing of its own volition... looking down, you see it morph into a tentacle-like shape.  <b>You now have a tentacle cock!</b>  ";
					}
					else {
						desc += GrowCockGenericText();
						desc += "Your feel your cock bending and flexing of its own volition... looking down, you see it morph into a tentacle-like shape.  <b>You now have a tentacle cock!</b>  ";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.SCYLLATENTACLE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.SCYLLATENTACLE));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.SCYLLATENTACLE)
				}
		);
	}

	public function CockCat(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Cat Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.CAT);

					if (player.cocks.length > cock){
						desc += "One of your penises begins to feel strange.  You pull down your clothes to take a look and see your [cock "+(cock+1)+"] swells up with near-painful arousal and begin to transform.  It turns pink and begins to narrow until the tip is barely wide enough to accommodate your urethra.  Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base of your [cock "+(cock+1)+"] and shrink towards the tip. The smallest are barely visible. <b>Your new feline dong throbs powerfully</b> and spurts a few droplets of cum.";
						if (player.hasSheath()) desc += "  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.";
						else {
							desc +="  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your [cock "+(cock+1)+"]'s root, tightening and pulling it inside its depths.";
							if (player.hasBalls()) desc +="  Thankfully, your balls appear untouched.";
						}
					}
					else {
						desc += GrowCockGenericText();
						desc += "You see your cock swells up with near-painful arousal and begin to transform.  It turns pink and begins to narrow until the tip is barely wide enough to accommodate your urethra.  Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base of your cock and shrink towards the tip. The smallest are barely visible. <b>Your new feline dong throbs powerfully</b> and spurts a few droplets of cum.";
						if (player.hasSheath()) desc += "  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.";
						else {
							desc +="  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's root, tightening and pulling it inside its depths.";
							if (player.hasBalls()) desc +="  Thankfully, your balls appear untouched.";
						}
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].knotMultiplier = 1;
					player.cocks[cock].cockType = CockTypesEnum.CAT;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.CAT));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.CAT)
				}
		);
	}

	public function CockCancer(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Cancer Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.CANCER);

					if (player.cocks.length > cock) {
						desc += "Your [cock] begins foaming bubbles... well, guess thats going to take some time to get used to? <b>Your penis is now foaming bubbles like that of a Cancer!</b>";
						//(REMOVE SHEATH IF NECESSARY)
						if (player.hasSheath())
							desc +="[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your [cock "+(cock+1)+"]'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "your cock begins foaming bubbles... well, guess thats going to take some time to get used to? <b>Your penis is now foaming bubbles like that of a Cancer!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.CANCER;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.CANCER));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.CANCER)
				}
		);
	}

	public function CockLizard(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Lizard Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.LIZARD);

					if (player.cocks.length > cock){
						if (player.lizardCocks() > 0) {
							desc += "A familiar tingle starts in your crotch, and before you can miss the show, you pull open your [armor].  As if operating on a cue, "+
									((player.cockTotal() == 2)? desc += "your other dick" : "another one of your dicks")+
									" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  "+
									"Pre-cum oozes from the tip"+
									" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>";
							//(REMOVE SHEATH IF NECESSARY)
							if (player.hasSheath()) {
								player.cocks[cock].cockType = CockTypesEnum.LIZARD;
								if (!player.hasSheath()) desc += ("[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
							}
						}
						else {
							desc += "A slow tingle warms your groin.  Before it can progress any further, you yank back your [armor] to investigate.  Your [cock "+(cock+1)+"] is changing!  It ripples loosely from "+
									(player.hasSheath() ? "sheath " : "base ") + "to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your [cock "+(cock+1)+"] resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker "+
									(player.cor < 33 ? "horrifies you." : (player.cor < 66 ?"is a little strange for your tastes." :"looks like it might be more fun to receive than use on others."));
							if (player.hasVagina()) desc+= "Maybe you could find someone else with one to ride?"
							else desc+= "Maybe you should test it out on someone and ask them exactly how it feels?";
							desc+="  <b>You now have a bulbous, reptile-like cock.</b>";
							if (player.hasSheath()) {
								player.cocks[cock].cockType = CockTypesEnum.LIZARD;
								if (!player.hasSheath()) desc += ("[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
							}
						}
					}
					else {
						if (player.lizardCocks() > 0) {
							desc += "A knot of pressure forms in your groin, forcing you off your [feet] as you try to endure it.  You examine the affected area and see a lump starting to bulge under your [skin.type], adjacent to your [cock].  The flesh darkens, turning purple";
							if (player.hasCoat())
								desc += " and shedding " + player.coatColor;
							desc += " as the bulge lengthens, pushing out from your body.  Too surprised to react, you can only pant in pain and watch as the fleshy lump starts to take on a penis-like appearance.  <b>You're growing a second lizard-cock!</b>  It doesn't stop growing until it's just as long as its brother and the same shade of shiny purple.  A dribble of cum oozes from its tip, and you feel relief at last.";
						} else {
							desc += GrowCockGenericText();
							desc += "it ripples loosely from "+
									(player.hasSheath() ? "sheath " : "base ") + "to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your cock resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker "+
									(player.cor < 33 ? "horrifies you." : (player.cor < 66 ?"is a little strange for your tastes." :"looks like it might be more fun to receive than use on others."));
							if (player.hasVagina()) desc+= "Maybe you could find someone else with one to ride?"
							else desc+= "Maybe you should test it out on someone and ask them exactly how it feels?";
							desc+="  <b>You now have a bulbous, reptile-like cock.</b>";
						}
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.LIZARD;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.LIZARD));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.LIZARD)
				}
		);
	}

	public function CockCaveWyrm(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Cave Wyrm Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.CAVE_WYRM);

					if (player.cocks.length > cock){
						desc += "You feel a sudden itch in your cock and undress as an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your [cock "+(cock+1)+"] you discover it has not only changed color to neon blue but reshaped into a lizard cock. Furthermore it seems to naturally glow in the dark like the fluids that comes out of it. <b>You now have a neon blue lizard cock that glow in the dark.</b>";
						//(REMOVE SHEATH IF NECESSARY)
						if (player.hasSheath()) {
							player.cocks[cock].cockType = CockTypesEnum.CAVE_WYRM;
							if (!player.hasSheath()) desc += "[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>";
						}
					}
					else {
						desc += GrowCockGenericText();
						desc += "an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your new cock you discover it has not only changed color to neon blue but reshaped into a lizard cock. Furthermore it seems to naturally glow in the dark like the fluids that comes out of it. <b>You now have a neon blue lizard cock that glow in the dark.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.CAVE_WYRM;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.CAVE_WYRM));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.CAVE_WYRM)
				}
		);
	}

	public function CockAnemone(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Anemone Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.ANEMONE);

					if (player.cocks.length > cock) {
						desc += "A strange tingling begins at the base of your [cock], slowly crawling up across its entire length.  You shift nervously as the feeling intensifies.  You undo your [armor] to check, and see  small blue-green tendrils emerging all around the base of your cock and  as it too shifts colour. The tentacles wave about"+
								"<b>You have a new anemone-penis!</b>";
						desc += "  The tentacles writhe around, rubbing against your [cocks] and the head of your new blue pecker";
						player.cocks[cock].cockType = CockTypesEnum.ANEMONE;
						desc += " and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress [eachcock] sensually, leaving behind a tingling trail of vibrant pleasure";
						//[(if no dick1 and no balls)
						if(player.cockTotal() == 1 && player.balls == 0) desc += "; you feel a pressure build below the shaft, near your asshole";
						desc += ".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ";
						if(player.cumQ() < 100) desc += "glob";
						else if(player.cumQ() < 500) desc += "squirt";
						else desc += "spray";
						desc += " of semen shoots from your new penis and lands on your ";
						//[(if boobs)
						if(player.biggestTitSize() >= 1) desc += allBreastsDescript() + " and ";
						desc += "stomach";
						//[(dick1 exists)
						if(player.cockTotal() > 1) desc += ", followed in short order by white squirts from [eachcock] remaining";
						if(player.hasVagina()) {
							desc += ".  Your [vag] quivers and pulses as well, adding ";
							if(player.wetness() < VaginaClass.WETNESS_SLICK) desc += "a trickle";
							else if(player.wetness() < VaginaClass.WETNESS_SLAVERING) desc += "a squirt";
							else desc += "nearly a cupful of fluid";
							desc += " from your female orgasm to the puddle on the ground below your ass.";
						}
					}
					else {
						desc += "You lay down and place a fresh anemone tentacle in the ground before you. "
						desc += "As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  The small anemone and you both lay there.  You watch it flexing its body, wedging the head under itself, and elevating the base.";
						desc += "You watch as the strange thing sets butt-end down on your pubic mound and adheres";
						//[(if cocks)
						if(player.cockTotal() > 0) desc += " below your " + player.multiCockDescriptLight();
						desc +=". A sharp pinch lances through the nerves in your groin and sends your hands to it reflexively.  You shift your grip and pull at it a few times, but the thing doesn't budge.  The handling of it only serves to make the stalk thicken and become stiff; gradually you notice that you're feeling the sensation of your own pulling not from the skin at the point of attachment but from the stalk itself, and this realization is accompanied by the ring of tentacles opening and pulling back to reveal the crown of a penis!  <b>You have a new anemone-penis!</b>";
						//[(dick slot 1 exists)
						if(player.cockTotal() > 0) desc += "  The tentacles writhe around, rubbing against your " + player.multiCockDescriptLight();
						//(doesn't exist)
						else desc += "  The tentacles curl inwards, rubbing on the head of your new blue pecker";
						player.createCock((4+rand(3)),1.2, CockTypesEnum.ANEMONE);
						desc += " and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress [eachcock] sensually, leaving behind a tingling trail of vibrant pleasure";
						//[(if no dick1 and no balls)
						if(player.cockTotal() == 1 && player.balls == 0) desc += "; you feel a pressure build below the shaft, near your asshole";
						desc += ".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ";
						if(player.cumQ() < 100) desc += "glob";
						else if(player.cumQ() < 500) desc += "squirt";
						else desc += "spray";
						desc += " of semen shoots from your new penis and lands on your ";
						//[(if boobs)
						if(player.biggestTitSize() >= 1) desc += allBreastsDescript() + " and ";
						desc += "stomach";
						//[(dick1 exists)
						if(player.cockTotal() > 1) desc += ", followed in short order by white squirts from [eachcock] remaining";
						if(player.hasVagina()) {
							desc += ".  Your [vag] quivers and pulses as well, adding ";
							if(player.wetness() < VaginaClass.WETNESS_SLICK) desc += "a trickle";
							else if(player.wetness() < VaginaClass.WETNESS_SLAVERING) desc += "a squirt";
							else desc += "nearly a cupful of fluid";
							desc += " from your female orgasm to the puddle on the ground below your ass.";
						}
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.ANEMONE));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.ANEMONE)
				}
		);
	}

	public function CockKangaroo(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Kangaroo Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.KANGAROO);

					if (player.cocks.length > cock){
						desc += "You feel a sharp pinch at the end of your penis and whip down your clothes to check.  Before your eyes, the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into ";
						if (player.hasSheath()) desc += "your sheath";
						else desc += "a sheath that forms at the base of it";
						desc += ".  <b>You now have a kangaroo-penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into";
						if (player.hasSheath()) desc += "your sheath";
						else desc += "a sheath that forms at the base of it";
						desc += ".  <b>You now have a kangaroo-penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.KANGAROO;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.KANGAROO));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.KANGAROO)
				}
		);
	}

	public function CockDragon(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Dragon Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.DRAGON);

					if (player.cocks.length > cock){
						desc += "Your " + player.cockDescript(cock) + " tingles as pins and needles sweep across it.  You pull open your [armor] to watch as it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ";
						if (player.sens >= 50) desc += "however, it's not until you press on your"+(player.cocks[cock].hasKnot()?"":" new,")+" sensitive knot that you manage to blow your load and enjoy the last few spasms of pleasure as it finally finishes changing.";
						else desc += "but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.";
						if (player.cocks[cock].knotMultiplier < 1.3 && player.cocks[cock].knotMultiplier > 1) desc += "The knot on your cock grows extremely sensitive as it grows thicker than before. ";
						desc += "The knot on your cock grows extremely sensitive as it grows thicker than before. ";
						desc += "  <b>You now have a dragon penis.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ";
						if (player.sens >= 50) desc += "however, it's not until you press on your new, sensitive knot that you manage to blow your load and enjoy the last few spasms of pleasure as it finally finishes changing.";
						else desc += "but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.";
						desc += "  <b>You now have a dragon penis.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.3) player.cocks[cock].knotMultiplier = 1.3;
					player.cocks[cock].cockType = CockTypesEnum.DRAGON;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DRAGON));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.DRAGON)
				}
		);
	}

	public function CockDisplacer(index:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.5): Transformation {
		return new SimpleTransformation("Displacer Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.DISPLACER);

					if (player.cocks.length > cock){
						desc += "You feel an incessant hardness beneath you and realize your cock is dangling out of its sheath.";
						if (!player.hasSheath()) desc += "  Wait... did you have a sheath before? Well you do now.";
						if (player.cocks[cock].knotMultiplier < knot && player.cocks[cock].knotMultiplier > 1) desc += "The knot on your cock grows extremely sensitive as it grows thicker than before. ";
						desc += "  You blink your eyes again... is something wrong with your dick?  At first glance, it appears to be a normal canine dick complete with a knot... but the tip seems to have five grooves along the sides.  When you think about it, you find the tip opening up, splaying out into something resembling a five-armed starfish, with the tips ending in wiggling tendrils, the inner-flesh covered in bumpy nodules that stiffen in the cool air.  With another thought, the cock returns to its normal, almost-canine like appearance, though it's definitely thicker around the tip than an actual canine dick.";
						desc += "You give your <b>new coeurl cock</b> a few tentative strokes";
					}
					else {
						desc += GrowCockGenericText();
						desc += "it shifts again. At first glance, it appears to be a normal canine dick complete with a knot... but the tip seems to have five grooves along the sides.  When you think about it, you find the tip opening up, splaying out into something resembling a five-armed starfish, with the tips ending in wiggling tendrils, the inner-flesh covered in bumpy nodules that stiffen in the cool air.  With another thought, the cock returns to its normal, almost-canine like appearance, though it's definitely thicker around the tip than an actual canine dick.";
						desc += "You give your <b>new coeurl cock</b> a few tentative strokes";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if(player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.DISPLACER;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DISPLACER));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.DISPLACER)
				}
		);
	}

	public function CockFox(index:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.25): Transformation {
		return new SimpleTransformation("Fox Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.FOX);

					if (player.cocks.length > cock){
						if (player.cocks[cock].cockType == CockTypesEnum.HORSE) {
							desc += "Your [cock "+(cock+1)+"] shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes and you";
							//Tweak length/thickness.
							if (player.cocks[cock].cockLength > 6) player.cocks[cock].cockLength -= 2;
							else player.cocks[cock].cockLength -= .5;
							player.cocks[cock].cockThickness += .5;
						}
						else if (["tentacle","plant"].indexOf(player.cocks[cock].cockType.Group) >= 0)
							desc += "Your [cock "+(cock+1)+"] coils in on itself, reshaping and losing its coloration, becoming a shiny red. You";
						else desc += "Your [cock "+(cock+1)+"] clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. You"
						desc += " shudder as the crown of your [cock "+(cock+1)+"] reshapes into a point, the sensations nearly too much for you. "
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						if (player.cocks[cock].knotMultiplier <= 1) desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. "
						else if (player.cocks[cock].knotMultiplier < knot) desc += "The knot on your new red pecker grows extremely sensitive as it grows thicker than before. ";
						desc += "You throw back your head as the transformation completes, your cock much thicker than before.  <b>You now have a fox-cock.</b>";

					}
					else {
						desc += GrowCockGenericText();
						desc += "Your cock clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. ";
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. ";
						desc += "You throw back your head as the transformation completes, that was intense!  <b>You now have a fox-cock.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.FOX;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.FOX));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.FOX)
				}
		);
	}

	public function CockBee(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Bee Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.BEE);

					if (player.cocks.length > cock){
						desc += "Your huge [cock "+(cock+1)+"] suddenly starts to hurt, especially the tip of the thing.  At the same time, you feel your length start to get incredibly sensitive and the base of your shaft starts to itch.  You tear off your [armor] and watch in fascination as your [cock] starts to change.  The shaft turns black, while becoming hard and smooth to the touch, while the base develops a mane of four inch long yellow bee hair.  As the transformation continues, your member grows even larger than before.  However, it is the tip that keeps your attention the most, as a much finer layer of short yellow hairs grow around it.  Its appearance isn’t the thing that you care about right now, it is the pain that is filling it.  ";
						desc += "It is entirely different from the usual feeling you get when you’re cock grows larger from imbibing transformative substances.  When the changes stop, the tip is shaped like a typical human mushroom cap covered in fine bee hair, but it feels nothing like what you’d expect a human dick to feel like.  Your whole length is incredibly sensitive, and touching it gives you incredible stimulation, but you’re sure that no matter how much you rub it, you aren’t going to cum by yourself.  You want cool honey covering it, you want tight walls surrounding it, you want to fertilize hundreds of eggs with it.  These desires are almost overwhelming.  ";
						desc += "<b>You now have a bee cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "the shaft turns black, while becoming hard and smooth to the touch, while the base develops a mane of four inch long yellow bee hair.  As the transformation continues, your member grows even larger than before.  However, it is the tip that keeps your attention the most, as a much finer layer of short yellow hairs grow around it.  Its appearance isn’t the thing that you care about right now, it is the pain that is filling it.  ";
						desc += "It is entirely different from the usual feeling you get when you’re cock grows larger from imbibing transformative substances.  When the changes stop, the tip is shaped like a typical human mushroom cap covered in fine bee hair, but it feels nothing like what you’d expect a human dick to feel like.  Your whole length is incredibly sensitive, and touching it gives you incredible stimulation, but you’re sure that no matter how much you rub it, you aren’t going to cum by yourself.  You want cool honey covering it, you want tight walls surrounding it, you want to fertilize hundreds of eggs with it.  These desires are almost overwhelming.  ";
						desc += "<b>You now have a bee cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.BEE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.BEE));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.BEE)
				}
		);
	}

	public function CockPig(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Pig Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.PIG);

					if (player.cocks.length > cock){
						desc += "You feel an uncomfortable pinching sensation in your [cock "+(cock+1)+"]. " + player.clothedOrNakedLower("You pull open your [armor]", "You look down at your exposed groin") + ", watching as it warps and changes. As the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "and as the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.PIG;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.PIG));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.PIG)
				}
		);
	}

	public function CockAvian(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Avian Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.AVIAN);

					if (player.cocks.length > cock){
						desc += "A warm tingling on your nethers makes you check down if the transformative had an effect on your genitals. Giving them a thorough check, you notice that, effectively, your " + cockDescript(cock) + " has changed.  ";
						desc += "It has acquired a reddish-pink coloration, with a smooth texture. The most notorious thing is its tapered, albeit slightly wavy shape, as well as its pointy head. All in all it has a very bird-like appearance.  <b>Seems like you’ve got an avian penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "you see it has acquired a reddish-pink coloration, with a smooth texture. The most notorious thing is its tapered, albeit slightly wavy shape, as well as its pointy head. All in all it has a very bird-like appearance.  <b>Seems like you’ve got an avian penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.AVIAN;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.AVIAN));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.AVIAN)
				}
		);
	}

	public function CockRhino(index:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation {
		return new SimpleTransformation("Rhino Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.RHINO);

					if (player.cocks.length > cock){
						desc += "You feel a stirring in your loins as your [cock "+(cock+1)+"] grows rock hard. ";
						desc += "You " + player.clothedOrNakedLower("pull it out from your [armor]", "lean over");
						desc += (inBlackCock? ", right there in the center of The Black Cock":"") +", to take a look. You watch as the skin of your cock becomes a smooth, tough pink colored phallus. It takes on a long and narrow shape with an oval shaped bulge along the center. You feel a tightness near the base where your skin seems to be bunching up. A sheath begins forming around your flared rhino cock’s root, tightening as your stiff rhino dick elongates and settles, the thick flared head, leaking a steady stream of funky animal-cum. <b>You now have a rhino-dick.</b>";

					}
					else {
						desc += GrowCockGenericText();
						desc += "the skin of your cock becomes a smooth, tough pink colored phallus. It takes on a long and narrow shape with an oval shaped bulge along the center. You feel a tightness near the base where your skin seems to be bunching up. A sheath begins forming around your flared rhino cock’s root, tightening as your stiff rhino dick elongates and settles, the thick flared head, leaking a steady stream of funky animal-cum. <b>You now have a rhino-dick.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.RHINO;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.RHINO));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.RHINO)
				}
		);
	}

	public function CockEchidna(index:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation {
		return new SimpleTransformation("Echidna Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.ECHIDNA);

					if (player.cocks.length > cock){
						desc += "Your [cock "+(cock+1)+"] suddenly becomes rock hard out of nowhere. You " + player.clothedOrNakedLower("pull it out from your [armor]"+(inBlackCock?", right in the middle of the food tent":"")+", watching", "watch") + " as it begins to shift and change. It becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath.";
						desc += " <b>You now have an echidna penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "it becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath."+
								" <b>You now have an echidna penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.ECHIDNA;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.ECHIDNA));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.ECHIDNA)
				}
		);
	}

	public function CockWolf(index:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.1): Transformation {
		return new SimpleTransformation("Wolf Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.WOLF);

					if (player.cocks.length > cock){
						desc += "Your " + cockDescript(cock) + " clenches painfully, becoming achingly, throbbingly erect. ";
						if (!player.hasSheath()) desc +="A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You shudder as the crown of your prick reshapes into a point, the sensations nearly too much for you. You throw back your head as the transformation completes, your knotted wolf-cock much thicker than before.";
						if (player.cocks[cock].knotMultiplier < knot) desc += "The knot on your new red pecker grows extremely sensitive as it grows thicker than before. ";
						desc += "  <b>You now have a wolf-cock.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You shudder as the crown of your prick reshapes into a point, the sensations nearly too much for you. You throw back your head as the transformation completes, your knotted wolf-cock much thicker than before.";
						desc += "  <b>You now have a wolf-cock.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].cockThickness < 1.5)
						player.thickenCock(cock, 2);
					if (player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.WOLF;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.WOLF));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.WOLF)
				}
		);
	}

	public function CockStamen(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Stamen Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.STAMEN);

					if (player.cocks.length > cock){
						desc += "You feel a strange tingling in your " + num2Text2(cock+1) + " cock. You remove your [armor] and look down and witness your cock shifting into a peculiar form. Its tapered, [color] and crowned by several colorful balls that look sort of like knots. Its covered in sweet smelling dust...  you're secreting pollen!  <b>You now have a";
						if(player.tentacleCocks() > 0) desc += "nother";
						desc +=" plantlike stamen cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "You feel a strange tingling in your " + num2Text2(cock+1) + " cock and look down to witness your cock shifting into a peculiar form. Its tapered, [color] and crowned by several colorful balls that look sort of like knots. Its covered in sweet smelling dust...  you're secreting pollen!  <b>You now have a plantlike stamen cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.3) player.cocks[cock].knotMultiplier = 1.3;
					player.cocks[cock].cockType = CockTypesEnum.STAMEN;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.STAMEN));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.STAMEN)
				}
		);
	}

	public function CockRedPanda(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Red Panda Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.RED_PANDA);

					if (player.cocks.length > cock){
						desc += "The skin surrounding your penis folds, encapsulating it and turning itself into a protective sheath.  ";
						desc += "<b>You now have a red-panda cock!</b>";
					}
					else {
						if (!player.hasVagina() && !player.hasCock()) desc +="You feel a sudden stabbing pain in your groin and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else if (player.hasCock()) desc += "You feel a sudden stabbing pain above your [cocks] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else desc +="You feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						desc += "The skin surrounding your penis folds, encapsulating it and turning itself into a protective sheath.  ";
						desc += "<b>You now have a red-panda cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.RED_PANDA;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.RED_PANDA));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.RED_PANDA)
				}
		);
	}

	public function CockGryphon(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Gryphon Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.GRYPHON);

					if (player.cocks.length > cock){
						desc += "Your nethers tingle under its effect.[pg]Giving them a glimpse, the first thing that becomes obvious is that your " + cockDescript(cock) + " becomes a bit thicker, but albeit it retained its avian, tapered shape; its slightly wavy form became more straight. ";
						desc += "It’s reddish-pink color became pink and it’s tip became more conical. Nevertheless, the main chance manifested across its length, where small, soft barbs grew, giving your member an the appearance of an avian-feline hybrid one.  <b>You'll have to try around your new gryphon cock to know how’ they’ll feel to use,</b> but you’re sure that it’ll be pleasant both for you and your partners.";
					}
					else {
						desc += GrowCockGenericText();
						desc += "your cock becomes a bit thicker, but albeit it retained it’s avian, tapered shape, it’s slightly wavy form became more straight. " +
								"It’s reddish-pink color became pink and it’s tip became more conical. Nevertheless, the main chance manifested across its length, where small, soft barbs grew, giving your member an the appearance of an avian-feline hybrid one.  <b>You'll have to try around your new gryphon cock to know how they’ll feel to use,</b> but you’re sure that it’ll be pleasant both for you and your partners.";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.GRYPHON;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.GRYPHON));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.GRYPHON)
				}
		);
	}

	public function CockCentipede(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Centipede Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.OOMUKADE);

					if (player.cocks.length > cock){
						if (player.hasSheath()) {
							player.cocks[cock].cockType = CockTypesEnum.OOMUKADE;
							if (!player.hasSheath())
								desc += "Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + player.cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b> " +
										"This said the changes are only starting as you moan out feeling your cock harden and tingle as it dribbles venoms.";
						}
						desc += "You moan out, feeling your cock harden and tingle as it dribbles a strange dark purple liquid. <b>You now have a venom dripping, centipede cock.</b>";
					}
					else {
						if (!player.hasVagina() && !player.hasCock()) desc +="You feel a sudden stabbing pain in your groin and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else if (player.hasCock()) desc += "You feel a sudden stabbing pain above your [cocks] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else desc +="You feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						desc += "You moan out, feeling your cock harden and tingle as it dribbles a strange dark purple liquid. <b>You now have a venom dripping, centipede cock.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.OOMUKADE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.OOMUKADE));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.OOMUKADE)
				}
		);
	}

	public function CockRaiju(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Raiju Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.RAIJU);

					if (player.cocks.length > cock){
						desc += "You feel a sudden itch in your cock and undress as an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your [cock] you discover its tip not only has changed color to neon blue but is now tappered with a sheath like that of a raiju. Furthermore it seems to naturally glow in the dark like the plasma that naturaly drips out of it. <b>You now have a neon blue raiju cock that glow in the dark.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your cock you discover its tip not only has changed color to neon blue but is now tappered with a sheath like that of a raiju. Furthermore it seems to naturally glow in the dark like the plasma that naturaly drips out of it. <b>You now have a neon blue raiju cock that glow in the dark.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.25) player.cocks[cock].knotMultiplier = 1.25;
					player.cocks[cock].cockType = CockTypesEnum.RAIJU;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.RAIJU));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.RAIJU)
				}
		);
	}

	public function CockUshiOni(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Ushi Oni Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.USHI_ONI);

					if (player.cocks.length > cock){
						desc += "[pg]<b>HOW THE HELL, IT DOES NOT EXIST YET</b>[pg]" +
								"<b> You now have a Ushi Oni cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "[pg]<b>HOW THE HELL, IT DOES NOT EXIST YET</b>[pg]" +
								"<b> You now have a Ushi Oni cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.USHI_ONI;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.USHI_ONI));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.USHI_ONI)
				}
		);
	}

	public function CockArigean(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Arigean Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.ARIGEAN);

					if (player.cocks.length > cock){
						desc += "[pg]<b>HOW THE HELL, IT DOES NOT EXIST YET</b>[pg]" +
								"<b> You now have an Arigean cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "[pg]<b>HOW THE HELL, IT DOES NOT EXIST YET</b>[pg]" +
								"<b> You now have an Arigean cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.ARIGEAN;

					transformations.UnlockCocks();
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.ARIGEAN)
				}
		);
	}

	public function CockInsect(index:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Insect Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var cock:int = cockIndex(index, CockTypesEnum.INSECT);

					if (player.cocks.length > cock){
						desc += "Your " + num2Text2(cock+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer";
						desc += player.hasSheath()? "" : " out of its new sheath";
						desc += ", all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your [cock "+(cock+1)+"] has become a tentacle!  As you watch, it withdraws back into its sheath; it's colored a dull white, and evidence seems to suggest you can make it extend out at will.  <b>You now have a";
						if(player.tentacleCocks() > 0) desc += "nother";
						desc += " tentacle-cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "Your feel it bending and flexing of its own volition... looking down, you see it morph into a white vine-like shape.  <b>You now have an insect cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].knotMultiplier = 1;
					player.cocks[cock].cockType = CockTypesEnum.INSECT;

					UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.INSECT));
				},
				// is present
				function ():Boolean {
					return isPresentCock(index, CockTypesEnum.INSECT)
				}
		);
	}

	public function GrowKnot(cock:int = 0, crit:Number = 1, mod:Number = 1, div:Number = 20): Transformation { return new SimpleTransformation( "Grow knot of cock",
			// apply effect
			function (doOutput:Boolean): void {
				var desc:String = "[pg]";

				if (cock == -1) { //choose smallest dog knot if not specified
					var choice:int = 0;
					//set temp2 to first wolfdick for initialization
					while (choice < player.cocks.length) {
						if (player.isDogCock(choice)) {
							cock = choice;
							break;
						} else choice++;
					}
					//Reset choice for next check
					choice = player.cocks.length;
					//Find smallest knot
					while (choice > 0) {
						choice--;
						if (player.isDogCock(choice) && player.cocks[choice].knotMultiplier < player.cocks[cock].knotMultiplier) cock = choice;
					}
					//Have smallest knotted cock selected.
				}

				var knot:Number = (rand(2) + mod) / div * crit;
				if (player.cocks[cock].knotMultiplier >= 1.5) knot /= 2;
				if (player.cocks[cock].knotMultiplier >= 1.75) knot /= 2;
				if (player.cocks[cock].knotMultiplier >= 2) knot /= 5;
				player.cocks[cock].knotMultiplier += (knot);
				if (knot < .06) desc +="Your " + cockDescript(cock) + " feels unusually tight in your sheath as your knot grows.";
				else if (knot <= .12) desc += "Your " + cockDescript(cock) + " pops free of your sheath, thickening nicely into a bigger knot.";
				else  desc +="Your " + cockDescript(cock) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.";
				dynStats("lus", 5 * crit, "scale", false);
				player.addCurse("sen", 1, 1);

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return !player.isDogCock(cock);
			}
	);}

	public function CockChangeType(type:CockTypesEnum, grow:Boolean, oneByOne:Boolean=false):Transformation {
		return new SimpleTransformation("CockChangeType("+type.DisplayName+","+grow+","+oneByOne+")",
				// apply effect
				function (doOutput:Boolean):void {
					var n:int = player.cocks.length;
					if (grow && n == 0) n = 1;
					for (var i:int = 0; i < n; i++) {
						var cock:Cock = player.cocks[i];
						if (!cock || cock.cockType != type) {
							switch (type) {
								case CockTypesEnum.HUMAN:
									CockHuman(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DOG:
									CockDog(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DEMON:
									CockDemon(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.TENTACLE:
									CockTentacle(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.SCYLLATENTACLE:
									CockScylla(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.CAT:
									CockCat(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.CANCER:
									CockCancer(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.LIZARD:
									CockLizard(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.CAVE_WYRM:
									CockCaveWyrm(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.ANEMONE:
									CockAnemone(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.KANGAROO:
									CockKangaroo(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DRAGON:
									CockDragon(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DISPLACER:
									CockDisplacer(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.FOX:
									CockFox(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.BEE:
									CockBee(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.PIG:
									CockPig(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.AVIAN:
									CockAvian(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.RHINO:
									CockRhino(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.ECHIDNA:
									CockEchidna(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.WOLF:
									CockWolf(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.STAMEN:
									CockStamen(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.RED_PANDA:
									CockRedPanda(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.GRYPHON:
									CockGryphon(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.OOMUKADE:
									CockCentipede(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
//								case CockTypesEnum.MINDBREAKER:
									// CockMindbreaker(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
//									break;
								case CockTypesEnum.RAIJU:
									CockRaiju(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.USHI_ONI:
									CockUshiOni(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.INSECT:
									CockInsect(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								default:
									if (cock) {
										cock.cockType = type;
									} else {
										player.createCock(5.5, 1, type);
									}
							}
							if (oneByOne) break;
						}
					}
				},
				// is present
				function():Boolean {
					return player.countCocksOfType(type) == player.cocks.length;
				});
	}
	/*
*/
}
}