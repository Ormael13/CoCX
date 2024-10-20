package classes.Transformations.Transformations {
import classes.BodyParts.*;
import classes.GeneticMemories.VaginaCountMem;
import classes.GeneticMemories.VaginaMem;
import classes.GlobalFlags.kFLAGS;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;
import classes.Transformations.*;
import classes.VaginaClass;

/**
 * Base class for transformation events.
 */
public class VaginaTransformations extends MutationsHelper {
	/*
    *	 ██       ██  █████   ██████  ██ ███   ██  █████
    * 	  ██     ██  ██   ██ ██       ██ ████  ██ ██   ██
    * 	   ██   ██   ███████ ██   ███ ██ ██ ██ ██ ███████
    * 	    ██ ██    ██   ██ ██    ██ ██ ██  ████ ██   ██
    *	     ███     ██   ██  ██████  ██ ██   ███ ██   ██
    */

	/*
        */
	public function UnlockVagina(): void {
		//noinspection FallThroughInSwitchStatementJS	// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
		switch (player.vaginas.length) {
			case 2: Metamorph.unlockMetamorphEx(VaginaCountMem.getMemory(VaginaCountMem.VAGINA2));
			case 1: Metamorph.unlockMetamorphEx(VaginaCountMem.getMemory(VaginaCountMem.VAGINA1));
				break;
			default: break;
		}
	}
	
	// -1: first not this type
	private function vaginaIndex(index:int, type:int):int {
		if (index < 0) {
			for (index = 0; index < player.vaginas.length; index++)
				if (player.vaginas[index].type != type) return index;
		}
		if (index >= player.vaginas.length) index = 0;
		return index;
	}
	// -1: are all vaginas this type
	private function isPresentVagina(index:int, type:int):Boolean {
		if (player.vaginas.length == 0) return false;
		if (index == -1) {
			for (index = 0; index < player.vaginas.length; index++)
				if (player.vaginas[index].type != type) return false;
		}
		return index < player.vaginas.length && player.vaginas[index].type == type;
	}

	public function VaginaNone(vagina:int = 0): Transformation {
		return new SimpleTransformation("Remove Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()) {
						desc += "A tightness in your groin is the only warning you get before your <b>[vagina "+(vagina+1)+"] disappears completely</b>!";
						if (doOutput) outputText(desc);

						player.removeVagina(vagina, 1);
					}
				},
				// is present
				function ():Boolean {
					return !player.hasVagina();
				}
		);
	}

	public function CockToVagina(vagina:int = 0): Transformation {
		return new SimpleTransformation("Remove Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cockTotal() == 1 && !player.hasVagina()) {
						desc += "Your [cock] suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.";
						if (!flags[kFLAGS.HYPER_HAPPY]) {
							if (player.hasBalls()) desc += "  At the same time, your [balls] fall victim to the same sensation; eagerly swallowed whole by your crotch.";
							desc += "  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>";
							player.balls = 0;
							player.ballSize = 1;
							transformations.VaginaHuman().applyEffect(false);
							player.removeCock(0, 1);
						}
					} else if (!flags[kFLAGS.HYPER_HAPPY]) {
						player.killCocks(1);
					}
					if (doOutput) outputText(desc);
				},
				// is present
				function ():Boolean {
					return player.hasVagina();
				},
				// is possible
				function ():Boolean {
					return !player.hasVagina() && player.hasCock();
				}
		);
	}

	public function GrowVaginaGenericText(): String {
		var desc:String = "";
		if (!player.hasVagina()) {
			if (player.hasBalls()) desc += "An itch starts behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, you lift up your balls to reveal your new vagina. ";
			else if (player.hasCock()) desc += "An itch starts on your groin, just below your [cocks]. You pull the manhood aside to give you a better view, and you're able to watch as your skin splits to give you a new vagina, complete with a tiny clit. ";
			else desc += "An itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit. " ;
			player.createVagina();
			player.clitLength = .25;
		} else {
			desc += "An itch starts in your [vagina] and it grows heated, almost bringing you to orgasm until suddenly you feel a doubling of sensation which sends you to your knees due to the sudden increase in pleasure. ";
			if (player.hasBalls()) desc += "You feel behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, you lift up your balls to reveal your new vagina. ";
			else if (player.hasCock()) desc += "An itch starts on your groin, just below your [cocks]. You pull the manhood aside to give you a better view, and you're able to watch as your skin splits to give you a new vagina, complete with a tiny clit. ";
			else desc += "An itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit. " ;
			player.createVagina(true, player.vaginas[0].vaginalWetness, player.vaginas[0].vaginalLooseness);
			player.vaginaType(player.vaginaType(), 1);
		}
		return desc;
	}

	public function SecondVagina(): Transformation {
		return new SimpleTransformation("Human Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "";

					desc += GrowVaginaGenericText();
					transformations.UnlockVagina();
					if (doOutput) outputText(desc);
				},
				// is present
				function ():Boolean {
					return player.vaginas.length == 2;
				}
		);
	}

	public function VaginaHuman(index:int = 0): Transformation {
		return new SimpleTransformation("Human Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "";
					var vagina:int = vaginaIndex(index, VaginaClass.HUMAN);

					if (player.vaginas.length > vagina){
						desc += "Something invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your [vagina "+(vagina+1)+"] and see it changing back to its ";
						if (player.vaginaType() == 5 || player.vaginaType() == 6)
							desc +="natural flesh colour.";
						else
							desc +="old human qualities.";
					}
					else {
						desc += GrowVaginaGenericText();
					}
					if (doOutput) outputText(desc);

					player.vaginaType(VaginaClass.HUMAN, vagina);

					transformations.UnlockVagina();
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.HUMAN);
				}
		);
	}

	public function VaginaHorse(index:int = 0): Transformation {
		return new SimpleTransformation("Equine Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.EQUINE);

					if (player.vaginas.length > vagina){
						desc += "You grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your [vagina "+(vagina+1)+"] has grown larger, in depth AND size. To your absolute surprise, it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have an equine vagina!</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "To your absolute surprise it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have a equine vagina!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.EQUINE, vagina);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING;

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.EQUINE));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.EQUINE);
				}
		);
	}

	public function VaginaKirin(index:int = 0): Transformation {
		return new SimpleTransformation("Kirin Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.KIRIN);

					if (player.vaginas.length > vagina){
						desc += "You grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your [vagina "+(vagina+1)+"] has grown larger, in depth AND size. To your absolute surprise, it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"Just as you thought the change was over you jump in surprise as a short static shock cause your clit to rise right out of its hood as your cunt begins changing color too!";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "To your absolute surprise it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease.";
					}
					if(player.isTaur()){
						desc += "You feel a sudden jolt in your pussy and moan in pleasure shoving your hindquarters against the nearest tree in an attempt to sooth the overwhelming itch." +
								" You moan as you spontaneously cum neon blue plasma painting the bark with your girl fluids." +
								" Wait, what? When you inspect your horsy cunt using your reflection in the water you discover it has changed color to neon blue." +
								" Furthermore it seems to naturally glow in the dark similar to a light bulb like the fluids it now squirt. ";
					}
					else{
						desc += "The sudden jolt in your pussy causes you to undress as an irrepressible desire to masturbate takes hold of you." +
								" You keep fingering your itchy pussy moaning as you cum neon blue plasma." +
								" Wait, what? When you inspect your [vagina] you discover it has changed color to neon blue." +
								" Furthermore it seems to naturally glow in the dark similar to a light bulb like the fluids it now squirt. ";
					}
					desc += "<b>You now have a neon blue kirin pussy that glow in the dark.</b>";
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.KIRIN, vagina);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING;

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.KIRIN));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.KIRIN);
				}
		);
	}

	public function VaginaSandTrap(index:int = 0): Transformation {
		return new SimpleTransformation("Sand Trap Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.BLACK_SAND_TRAP);

					if (player.vaginas.length > vagina){
						desc += "Your [vagina] feels... odd.  You undo your clothes and gingerly inspect your nether regions.  The tender pink color of your sex has disappeared, replaced with smooth, marble blackness starting at your lips and working inwards.";
						//(Wet:
						if (player.wetness() >= 3) desc += "  Your natural lubrication makes it gleam invitingly.";
						//(Corruption <50:
						if (player.cor < 50) desc +="  After a few cautious touches you decide it doesn't feel any different- it does certainly look odd, though.";
						else desc +="  After a few cautious touches you decide it doesn't feel any different - the sheer bizarreness of it is a big turn on though, and you feel it beginning to shine with anticipation at the thought of using it.";
						desc +="  <b>Your vagina is now ebony in color.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "The tender pink color of your sex slowly disappears, replaced with smooth, marble blackness starting at your lips and working inwards. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have an ebony coloured vagina!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.BLACK_SAND_TRAP);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.BLACK_SAND_TRAP));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.BLACK_SAND_TRAP);
				}
		);
	}

	public function VaginaCaveWyrm(index:int = 0): Transformation {
		return new SimpleTransformation("Cave Wyrm Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.CAVE_WYRM);

					if (player.vaginas.length > vagina){
						desc += "You feel a sudden jolt in your pussy and undress as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue fluids. Wait, what? When you inspect your [vagina] you discover it too has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  <b>You now have a neon blue pussy that glow in the dark.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "  You feel a sudden jolt in your new pussy as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue fluids. Wait, what? When you inspect your [vagina] you discover it too has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirts." +
								"  <b>You now have a neon blue pussy that glow in the dark.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.CAVE_WYRM);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.CAVE_WYRM));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.CAVE_WYRM);
				}
		);
	}

	public function VaginaCentipede(index:int = 0): Transformation {
		return new SimpleTransformation("Centipede Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.VENOM_DRIPPING);

					if (player.vaginas.length > vagina){
						desc += "You double over as an overwhelming heat pools in your groin ";
						if (player.vaginaType() != VaginaClass.VENOM_DRIPPING && player.vaginaType() != VaginaClass.HUMAN)
							desc +="as your vagina returns back to a human one, at least in appearance."+
									"  You moan out as your pussy tingles and clenches, drooling a strange dark purple liquid. ";
						if (player.skin.hasVenomousMarking())
							desc += "  It would seem your venomous markings altered something fundamental about your pussy, stimulating it into producing venom."
						else desc += "  It would seem your vagina has been stimulated to produce venom."
						desc += "<b>  You now have a Centipede vagina!</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "You moan out as your pussy tingles and clenches, drooling a strange dark purple liquid. ";
						if (player.skin.hasVenomousMarking())
							desc += "  It would seem your venomous markings altered something fundamental about your pussy, stimulating it into producing venom."
						else desc += "  It would seem your vagina has been stimulated to produce venom."
						desc += "<b>  You now have a Centipede vagina!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.VENOM_DRIPPING, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.VENOM_DRIPPING));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.VENOM_DRIPPING);
				}
		);
	}

	public function VaginaManticore(index:int = 0): Transformation {
		return new SimpleTransformation("Manticore Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.MANTICORE);

					if (player.vaginas.length > vagina){
						desc +="You suddenly became exceedingly aware of your surroundings, feeling the caress of the wind on your skin and especially its passage next to your [pussy]. " +
								"Out of curiosity you slide a single digit inside your pussy to test your new sensitivity and yelp a sound not unlike singing. " +
								"Your pussy has reached the sensitiveness of a manticore and the mere act of touching it will now cause you to moan an entire partition! " +
								"<b>Your ultrasensitive pussy is now exactly like that of a manticore!</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "Out of curiosity you slide a single digit inside your new pussy to test your sensitivity and yelp a sound not unlike singing. " +
								"Your pussy is as sensitive as that of a manticore and the merely touching it will now cause you to moan an entire partition! " +
								"<b>Your ultrasensitive pussy is now exactly like that of a manticore!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.MANTICORE, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.MANTICORE));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.MANTICORE);
				}
		);
	}

	public function VaginaCancer(index:int = 0): Transformation {
		return new SimpleTransformation("Cancer Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.CANCER);

					if (player.vaginas.length > vagina){
						desc += "Your pussy starts foaming bubbles for a few seconds, juice slowly flowing out. You cannot resist as your hands dive into your [vagina]. Your pussy gushes, foaming more and more bubbles until you suddenly shoot a powerful bubble jet. You make a dopey smile at the many uses of this you can already think of. <b>You now have an cancer vagina</b>.";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "To your absolute surprise it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have an cancer vagina!</b>";
					}
					if (player.vaginas[vagina].vaginalWetness < VaginaClass.WETNESS_DROOLING) {
						player.vaginas[vagina].vaginalWetness = VaginaClass.WETNESS_DROOLING;
						desc += " <b>You are now a squirter!</b>";
					}
					if (doOutput) outputText(desc);

					player.vaginaType(VaginaClass.CANCER, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.CANCER));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.CANCER);
				}
		);
	}

	public function VaginaDemonic(index:int = 0): Transformation {
		return new SimpleTransformation("Demonic Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.DEMONIC);

					if (player.vaginas.length > vagina) {
					}
					else {
						desc += GrowVaginaGenericText();
					}
					desc += "  Pressure begins building within your loins and your first instinct is to start fiercely fingering yourself in an effort to improve the pleasure, and to your surprise, your vaginal lips seem to reflexively clench around your fingers to kiss you. Wait, no, they're LITERALLY kissing your fingers. Where the hell did your cunt acquire such dexterity? "+
							"Just as you ponder this question, hunger seizes you over as the taste of sweat rushes to your mouth. Not your upper mouth, but the one between your legs has managed to taste the faint salty sweat coating your fingers! You can now taste and milk cum like never before using your "+
							"<b>brand new succubus cunt!</b>";
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.DEMONIC, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.DEMONIC));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.DEMONIC);
				}
		);
	}

	public function VaginaScylla(index:int = 0): Transformation {
		return new SimpleTransformation("Scylla Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.SCYLLA);

					if (player.vaginas.length > vagina){
						desc += "Something fundamental changes in your [vagina " +(vagina+1)+ "] as the insides begins to heat up. Out of curiosity you take a peek and are amazed that the interior of the gaping maw that is your cunt has changed in form and texture. For one you no longer have a clitoris, Instead, several concentric rings of small ultrasensitive nubs line up the walls of your cunt. "+
								"Intrigued you shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in. It takes all of your willpower not to fist yourself to orgasm. "+
								"<b>Your vagina is now like that of a scylla and can take in lengthier insertions.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "The insides of your vagina begins to heat up. Out of curiosity you take a peek and are amazed that the interior of the gaping maw that is your cunt has changed in form and texture. For one you no longer have a clitoris, Instead, several concentric rings of small ultrasensitive nubs line up the walls of your cunt. " +
								"Intrigued you shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in. It takes all of your willpower not to fist yourself to orgasm. " +
								"<b>Your vagina is now like that of a scylla and can take in lengthier insertions.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.SCYLLA, vagina);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING_WIDE;

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.SCYLLA));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.SCYLLA);
				},
				function ():Boolean {
					return player.lowerBody == LowerBody.SCYLLA;
				}
		);
	}

	public function VaginaNaga(index:int = 0): Transformation {
		return new SimpleTransformation("Naga Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.NAGA);

					if (player.vaginas.length > vagina) {
						desc += "Something fundamental changes in your [vagina " +(vagina+1)+ "] as the insides begins to heat up. Out of curiosity you take a peek and are amazed that the interior of your cunt has deepened to ridiculus extent running all the way farther into your tail.  "+
								"Intrigued you literally shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in heck you could easily insert a good part of your own tail inside and still find space. It takes all of your willpower not to fist yourself to orgasm. "+
								"<b>Your vagina is now like that of a naga and can take in lengthier insertions.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "The insides begins to heat up. Out of curiosity you take a peek and are amazed that the interior of your cunt has deepened to ridiculus extent running all the way farther into your tail. " +
								"Intrigued you literally shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in heck you could easily insert a good part of your own tail inside and still find space. It takes all of your willpower not to fist yourself to orgasm. " +
								"<b>Your vagina is now like that of a naga and can take in lengthier insertions.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING_WIDE;
					player.vaginaType(VaginaClass.NAGA, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.NAGA));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.NAGA);
				},
				// is possible
				function ():Boolean {
					return (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.HYDRA) && !isPresentVagina(index, VaginaClass.NAGA);
				}
		);
	}

	public function VaginaShark(index:int = 0): Transformation {
		return new SimpleTransformation("Shark Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.SHARK);

					if (player.vaginas.length > vagina){
						desc += "Something invisible brushes against your sex, making you twinge. Undoing your clothes, you take a look at your vagina. It looks normal at a first glance despite the odd sensation but inserting your fingers inside reveals that your walls are now covered with small sensitive tendril-like feelers. " +
								"You blush as they instinctively drive your digits further in, attempting to milk them like they would a penis. " +
								"<b>It looks like your vagina has turned into that of a shark girl.</b>";
						player.vaginaType(15);
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "It looks normal at a first glance despite the odd sensation but inserting your fingers inside reveals that your walls are now covered with small sensitive tendril-like feelers. " +
								"You blush as they instinctively drive your digits further in, attempting to milk them like they would a penis. " +
								"<b>It looks like your vagina has turned into that of a shark girl.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.SHARK, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.SHARK));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.SHARK);
				}
		);
	}

	public function VaginaRaiju(index:int = 0): Transformation {
		return new SimpleTransformation("Raiju Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.RAIJU);

					if (player.vaginas.length > vagina){
						desc += "You feel a sudden jolt in your pussy and undress as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue plasma. Wait, what? When you inspect your [vagina] you discover it has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  "+
								"<b>You now have a neon blue raiju pussy that glow in the dark.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "An irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue plasma. Wait, what? When you inspect your [vagina] you discover it has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  " +
								"<b>You now have a neon blue raiju pussy that glow in the dark.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.RAIJU, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.RAIJU));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.RAIJU);
				}
		);
	}

	public function VaginaAlraune(index:int = 0): Transformation {
		return new SimpleTransformation("Alraune Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.ALRAUNE);

					if (player.vaginas.length > vagina){
						desc += "Insert Text for Alraune Vagina TF";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "Insert Text for Alraune Vagina TF";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.ALRAUNE, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.ALRAUNE));
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.ALRAUNE);
				}
		);
	}

	public function VaginaArigean(index:int = 0): Transformation {
		return new SimpleTransformation("Arigean Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";
					var vagina:int = vaginaIndex(index, VaginaClass.ARIGEAN);

					if (player.vaginas.length > vagina){
						desc += "Insert Text for Arigean Vagina TF";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "Insert Text for Arigean Vagina TF";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.ARIGEAN, vagina);

					transformations.UnlockVagina();
				},
				// is present
				function ():Boolean {
					return isPresentVagina(index, VaginaClass.ARIGEAN);
				}
		);
	}
	/*
*/
}
}
