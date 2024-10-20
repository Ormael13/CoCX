package classes.Transformations.Transformations {
import classes.Transformations.*;
import classes.BodyParts.BodyMaterial;
import classes.BodyParts.Skin;
import classes.GeneticMemories.SkinMem;
import classes.GeneticMemories.SkinPatternMem;
import classes.Items.MutationsHelper;
import classes.Races.*;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class SkinTransformations extends MutationsHelper {
/*
*    ███████ ██   ██ ██ ███    ██
*    ██      ██  ██  ██ ████   ██
*    ███████ █████   ██ ██ ██  ██
*         ██ ██  ██  ██ ██  ██ ██
*    ███████ ██   ██ ██ ██   ████
*/

/*
  */
	public function SkinColor(colors: /*String*/ Array): Transformation {
		return new SimpleTransformation("Skin Color: " + colors.join("|"),
				// apply effect
				function (doOutput: Boolean): void {
					var color: String = randomChoice(colors);
					var desc: String = "";

					desc += "Whoah, that was weird.  You just hallucinated that your ";
					if (player.hasCoat()) desc += "skin";
					else desc += player.skinDesc;
					desc += " turned " + color + ".  No way!  It's staying, it really changed color!";

					player.skinColor = color;
					if (doOutput) outputText(desc);
				},
				// is present
				function (): Boolean {
					return InCollection(player.skinColor, colors);
				}
		)
	}

	public const SkinPlain: Transformation = new SimpleTransformation("Plain Skin",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				switch (player.coatType()) {
					case Skin.FUR:
						desc += "Your fur itches incessantly, so you start scratching it. It starts coming off in big clumps before the whole mess begins sloughing off your body. In seconds, your skin is nude. <b>You've lost your fur!</b>";
						break;
					case Skin.SCALES:
						desc += "Your scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your scales!</b>";
						break;
					case Skin.DRAGON_SCALES:
						desc += "Your dragon scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your dragon scales!</b>";
						break;
					default:
						desc += "Your [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin. <b>Your skin is once again normal!</b>";
				}

				if (doOutput) outputText(desc);
				player.skin.setBaseOnly({ type: Skin.PLAIN, adj: "", desc: "skin" });
			},
			// is present
			function (): Boolean {
				return player.skinType === Skin.PLAIN && player.skin.coverage == Skin.COVERAGE_NONE;
			}
	);

	public const SkinSlippery: Transformation = new SimpleTransformation("Slippery Skin",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				switch (player.coatType()) {
					case Skin.FUR:
						desc += "Your fur itches incessantly, so you start scratching it. It starts coming off in big clumps before the whole mess begins sloughing off your body. In seconds, your skin is nude. <b>You've lost your fur!</b>";
						break;
					case Skin.SCALES:
						desc += "Your scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your scales!</b>";
						break;
					case Skin.DRAGON_SCALES:
						desc += "Your dragon scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your dragon scales!</b>";
						break;
					default:
						desc += "Your [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin. <b>Your skin is slippery!</b>";
				}

				if (doOutput) outputText(desc);
				player.skin.setBaseOnly({ type: Skin.PLAIN, adj: "slippery" });
			},
			// is present
			function (): Boolean {
				return player.skinType === Skin.PLAIN && player.skin.coverage == Skin.COVERAGE_NONE && player.skinAdj === "slippery";
			}
	);

	public const SkinTransparent: Transformation = new SimpleTransformation("Transparent Skin",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				switch (player.coatType()) {
					case Skin.FUR:
						desc += "Your fur itches incessantly, so you start scratching it. It starts coming off in big clumps before the whole mess begins sloughing off your body. In seconds, your skin is nude. <b>You've lost your fur!</b>";
						break;
					case Skin.SCALES:
					case Skin.AQUA_SCALES:
					case Skin.AQUA_RUBBER_LIKE:
					case Skin.DRAGON_SCALES:
						desc += "Your scales itch incessantly, so you scratch at them. They start falling off wholesale, leaving you standing in a pile of scales after only a few moments. <b>You've lost your scales!</b>";
						break;
					default:
						desc += "Your [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.";
				}
				const color: String = randomChoice("white", "sable");
				var adj: String = "milky";
				if (color == "sable") adj = "ashen";
				desc += "[pg]You feel lightheaded all of a sudden. You bring your hands up to clutch your head only to find the color slowly fading from your skin or rather it’s losing its opacity altogether. You examine your body and see that you’ve become almost entirely transparent, adding to your ethereal appearance. <b>You now have transparent "+adj+" "+color+" skin.</b>";

				if (doOutput) outputText(desc);
                player.skin.setBaseOnly({ type: Skin.TRANSPARENT, color: color, adj: adj});
				Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.GHOST));
			},
			// is present
			function (): Boolean {
				return player.skinType === Skin.TRANSPARENT && player.skin.coverage == Skin.COVERAGE_NONE;
			}
	);

	/**
	 * @param options = {color/colors,color2/colors2,pattern,adj,desc}
	 */
	public function SkinFur(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
		return new SimpleTransformation("Fur Skin",
				// apply effect
				function (doOutput: Boolean): void {
					options = skinFormatOptions(options, Skin.FUR);

					const color: String = options.color;

					var desc: String = "";

					// Coverage
					if (player.hasCoatOfType(Skin.FUR)) {
						if (coverage > player.skin.coverage) {
							desc += "You suddenly feel a familiar itch on parts of your skin uncovered by fur. You're not surprised when <b>even more [fur color] fur sprouts, covering more of your body.</b>";
						} else if (coverage < player.skin.coverage) {
							desc += "What used to be a dense coat of fur begins to fall in patches on the ground leaving you with just enough [fur color] fur to cover some area of your body.";
						}

						if (coverage !== player.skin.coverage && color !== player.furColor) {
							desc += "\n\n";
						}

						if (color !== player.furColor) {
							desc += "You feel a strange sensation on your fur, and as soon as you glance at it, you're met with the sight of its hue slowly morphing from [fur color] to " + color + ". <b>Your fur is now " + color + ".</b>"
						}
					} else {
						switch (coverage) {
							case Skin.COVERAGE_LOW:
								if (!player.hasCoat()) desc += "Your skin itches intensely. You gaze down as more and more hairs break forth from your skin quickly transforming into a coat of " + color + " fur. <b>You are now partially covered in " + color + " fur.</b>";
								else if (player.isScaleCovered()) desc += "Your scales itch incessantly. You scratch, feeling them flake off to reveal a coat of " + color + " fur growing out from below!  <b>You are now partially covered in " + color + " fur.</b>";
								else desc += "Your skin itch incessantly. You scratch, feeling it current form shifting into a coat of " + color + " fur. <b>You are now partially covered in " + color + " fur.</b>";
								break;
							case Skin.COVERAGE_COMPLETE:
								if (player.skinType == Skin.SCALES) desc += "Your skin shifts and every scale stands on end, sending you into a mild panic. No matter how you tense, you can't seem to flatten them again. The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out. You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old. <b>Oh well, at least you won't need to sun yourself as much with your new " + color + " fur.</b>";
								else desc += "Your skin itches all over, the sudden intensity and uniformity making you too paranoid to scratch. As you hold still through an agony of tiny tingles and pinches, fine, luxuriant " + color + " fur sprouts from every bare inch of your skin! <b>You're now covered from head to toe in " + color + " fur.</b>";
								break;
							default:
								desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF FUR COVERAGE DOES NOT EXIST"
						}
					}

					// Patterns
					if (options.pattern && options.pattern !== player.skin.base.pattern) {
						const pattern: int = options.pattern;

						if (!options.color2 && options.colors2) {
							options.color2 = randomChoice(options.colors2);
							options.colors2 = undefined;
						}

						switch (pattern) {
							case Skin.PATTERN_SPOTTED:
								if (!options.color2) options.color2 = "black";
								desc += "\n\nA ripple spreads through your fur as some patches darken and others lighten. After a few moments you're left with a " + options.color2 + " and " + color + " spotted pattern that goes the whole way up to the hair on your head! <b>You've got spotted fur!</b>";
								break;
							case Skin.PATTERN_RED_PANDA_UNDERBODY:
								if (!options.color2) options.color2 = "black";
								desc += "\n\nA ripple spreads through your fur as your underside changes colors, becoming " + options.color2 + " rather than " + color + ". <b>Now your underside fur is " + options.color2 + ".</b>";
								break;
						}
					}

					player.skinDesc = "skin";
					player.skin.growCoat(Skin.FUR, options, coverage);
					if (doOutput) outputText(desc);
					Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.FUR));
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.FUR);

					return player.hasCoatOfType(Skin.FUR) && InCollection(player.furColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}
	public function SkinFurGradual(coverage:int = Skin.COVERAGE_COMPLETE, options:* = null):Transformation {
		var tfs:Array = [];
		for (var c:int = Skin.COVERAGE_LOW; c <= coverage; c++) {
			tfs.push(SkinFur(c, deepCopy(options)));
		}
		return new GradualTransformation("SkinFurGradualTo"+coverage, tfs);
	}

	public function SkinScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
		return new SimpleTransformation("Scales Skin",
				// apply effect
				function (doOutput: Boolean): void {
					options = skinFormatOptions(options, Skin.SCALES);

					const color: String = options.color;

					var desc: String = "";

					// Coverage
					if (player.hasCoatOfType(Skin.SCALES)) {
						if (coverage > player.skin.coverage) {
							desc += "You suddenly feel a familiar itch on parts of your skin uncovered by scales. You're not surprised when <b>even more [scales color] scales sprout, covering more of your body.</b>";
						} else if (coverage < player.skin.coverage) {
							desc += "Sections of your [scales color] scales itch incessantly, and as you scratch yourself, they start falling off wholesale. <b>You still have [scales color] scales on your body, but now they cover less of your skin.</b>";
						}

						if (coverage !== player.skin.coverage && color !== player.scaleColor) {
							desc += "\n\n";
						}

						if (color !== player.scaleColor) {
							desc += "You feel a strange sensation on your scales, and as soon as you glance at them, you're met with the sight of their hue slowly morphing from [scale color] to " + color + ". <b>Your scales are now " + color + ".</b>"
						}
					} else {
						switch (coverage) {
							case Skin.COVERAGE_LOW:
								if (player.isFurCovered()) {
									desc += "You scratch yourself, and come away with a large clump of [fur color] fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed. You feel your skin shift as " + color + " scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you. The rest of the fur is easy to remove. <b>Your body is now partially covered with small patches of scales!</b>";
								} else {
									desc += "You feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you. <b>Your body is now partially covered with small patches of " + color + " scales.</b>";
								}
								break;
							case Skin.COVERAGE_COMPLETE:
								if (player.isFurCovered()) {
									desc += "You scratch yourself, and come away with a large clump of [fur color] fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed. Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + color + " scales covering most of your body. The rest of the fur is easy to remove. <b>You're now covered in scales from head to toe.</b>";
								} else {
									desc += "You idly reach back to scratch yourself and nearly jump out of your [armor] when you hit something hard. A quick glance down reveals that scales are growing out of your [color] skin with alarming speed. As you watch, the surface of your skin is covered in smooth scales. They interlink together so well that they may as well be seamless.  You peel back your [armor] and the transformation has already finished on the rest of your body. <b>You're covered from head to toe in shiny " + color + " scales.</b>";
								}
								break;
							default:
								desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF SCALES COVERAGE DOES NOT EXIST"
						}
					}

					player.skinDesc = "skin";
					player.skin.growCoat(Skin.SCALES, options, coverage);
					if (doOutput) outputText(desc);
					Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.SCALES));
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.SCALES);

					return player.hasCoatOfType(Skin.SCALES) && InCollection(player.scaleColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}
	public function SkinScalesGradual(coverage:int = Skin.COVERAGE_COMPLETE, options:* = null):Transformation {
		var tfs:Array = [];
		for (var c:int = Skin.COVERAGE_LOW; c <= coverage; c++) {
			tfs.push(SkinScales(c, deepCopy(options)));
		}
		return new GradualTransformation("SkinScalesGradualTo"+coverage, tfs);
	}

	public function SkinDragonScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
		return new SimpleTransformation("Dragon Scales Skin",
				// apply effect
				function (doOutput: Boolean): void {
					options = skinFormatOptions(options, Skin.DRAGON_SCALES);

					const color: String = options.color;

					var desc: String = "";

					// Coverage
					if (player.hasCoatOfType(Skin.DRAGON_SCALES)) {
						if (coverage > player.skin.coverage) {
							desc += "You suddenly feel a familiar itch on parts of your skin uncovered by dragon scales. You're not surprised when <b>even more [scales color] dragon scales sprout, covering more of your body.</b>";
						} else if (coverage < player.skin.coverage) {
							desc += "Sections of your [scales color] dragon scales itch incessantly, and as you scratch yourself, they start falling off wholesale. <b>You still have [scales color] dragon scales on your body, but now they cover less of your skin.</b>";
						}

						if (coverage !== player.skin.coverage && color !== player.scaleColor) {
							desc += "\n\n";
						}

						if (color !== player.scaleColor) {
							desc += "You feel a strange sensation on your dragon scales, and as soon as you glance at them, you're met with the sight of their hue slowly morphing from " + player.scaleColor + " to " + color + ". <b>Your dragon scales are now " + color + ".</b>"
						}
					} else {
						switch (coverage) {
							case Skin.COVERAGE_LOW:
								desc += "Prickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + player.skinFurScales() + " hanging from your fingers.  Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + player.skinFurScales() + ". It doesn’t cover your skin entirely but should provide excellent protection regardless.  They are smooth and look nearly as tough as iron. <b>Your body is now partially covered in " + color + " shield-shaped dragon scales.</b>";
								break;
							case Skin.COVERAGE_COMPLETE:
								desc += "Prickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles. You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + player.skinFurScales() + " hanging from your fingers. Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + player.skinFurScales() + ". They are smooth and look nearly as tough as iron. <b>Your body is now fully covered in " + color + " shield-shaped dragon scales.</b>";
								break;
							default:
								desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF DRAGON SCALES COVERAGE DOES NOT EXIST"
						}
					}

					player.skinDesc = "skin";
					player.skin.growCoat(Skin.DRAGON_SCALES, options, coverage);
					if (doOutput) outputText(desc);
					Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.DRAGON_SCALES));
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.DRAGON_SCALES);

					return player.hasCoatOfType(Skin.DRAGON_SCALES) && InCollection(player.scaleColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}

	public function SkinChitin(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
		return new SimpleTransformation("Chitin Skin",
				// apply effect
				function (doOutput: Boolean): void {
					options = skinFormatOptions(options, Skin.CHITIN);

					const color: String = options.color;

					var desc: String = "";

					// Coverage
					if (player.hasCoatOfType(Skin.CHITIN)) {
						if (coverage > player.skin.coverage) {
							desc += "You suddenly feel a familiar itch on parts of your skin uncovered by chitin. When you scratch yourself, your skin starts to harden, becoming chitin in the same color as what was already on your body. <b>Even more " + player.chitinColor + " chitin is covering your body now.</b>";
						} else if (coverage < player.skin.coverage) {
							desc += "Sections of your " + player.chitinColor + " chitin itch incessantly, and as you scratch yourself, you feel it softening and becoming normal skin again. <b>You still have " + player.chitinColor + " chitin on your body, but now it covers less.</b>";
						}

						if (coverage !== player.skin.coverage && color !== player.chitinColor) {
							desc += "\n\n";
						}

						if (color !== player.chitinColor) {
							desc += "You feel a strange sensation on the chitin covering your skin, and as soon as you glance at it, you're met with the sight of its hue slowly morphing from " + player.chitinColor + " to " + color + ". <b>Your chitin is now " + color + ".</b>"
						}
					} else {
						switch (coverage) {
							case Skin.COVERAGE_LOW:
								if (player.hasCoat()) {
									desc += "A slowly-building itch spreads over parts of your body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, " + color + " chitin underneath.";
								} else {
									desc += "A slowly-building itch spreads over parts of your body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.";
								}
								desc += " <b>You now have " + color + " chitin exoskeleton covering parts of your body.</b>";

								break;
							case Skin.COVERAGE_COMPLETE:
								if (player.hasCoat()) {
									desc += "A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, " + color + " chitin underneath.";
								} else {
									desc += "A slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.";
								}
								desc += " <b>You now have " + color + " chitin exoskeleton covering your body.</b>";
								break;
							default:
								desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF FUR COVERAGE DOES NOT EXIST"
						}
					}

					player.skinDesc = "skin";
					player.skin.growCoat(Skin.CHITIN, options, coverage);
					if (doOutput) outputText(desc);
					Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.CHITIN));
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.CHITIN);

					return player.hasCoatOfType(Skin.CHITIN) && InCollection(player.chitinColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}

	public function SkinAquaScales(coverage: int = Skin.COVERAGE_HIGH, options: * = null): Transformation {
		return new SimpleTransformation("Aqua Scales Skin",
				// apply effect
				function (doOutput: Boolean): void {
					options = skinFormatOptions(options, Skin.AQUA_SCALES);

					const color: String = options.color;
					var desc: String = "";

					// Coverage
					if (player.hasCoatOfType(Skin.AQUA_SCALES)) {
						if (coverage > player.skin.coverage) {
							desc += "You suddenly feel a familiar itch on parts of your skin uncovered by scales. You're not surprised when <b>even more " + player.scaleColor + " scales sprout, covering more of your body.</b>";
						} else if (coverage < player.skin.coverage) {
							desc += "Sections of your " + player.scaleColor + " scales itch incessantly, and as you scratch yourself, they start falling off wholesale. <b>You still have " + player.scaleColor + " scales on your body, but now they cover less of your skin.</b>";
						}

						if (coverage !== player.skin.coverage && color !== player.scaleColor) {
							desc += "\n\n";
						}

						if (color !== player.scaleColor) {
							desc += "You feel a strange sensation on your scales, and as soon as you glance at them, you're met with the sight of their hue slowly morphing from " + player.scaleColor + " to " + color + ". <b>Your scales are now " + color + ".</b>"
						}
					} else {
						switch (coverage) {
								/*case Skin.COVERAGE_LOW:
                                    if (player.isFurCovered()) {
                                        desc += "You scratch yourself, and come away with a large clump of [fur color] fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed. You feel your skin shift as " + color + " scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you. The rest of the fur is easy to remove. <b>Your body is now partially covered with small patches of scales!</b>";
                                    } else {
                                        desc += "You feel your skin shift as scales grow in various place over your body. It doesn’t cover your skin entirely but should provide excellent protection regardless. Funnily it doesn’t look half bad on you. <b>Your body is now partially covered with small patches of " + color + " scales.</b>";
                                    }
                                    break;*/
							case Skin.COVERAGE_HIGH:
								if (player.isFurCovered()) desc += "You scratch yourself, and come away with a large clump of [fur color] fur. Panicked, you look down and realize that your fur is falling out in huge clumps. It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed. Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + color + " scales covering most of your body. The rest of the fur is easy to remove.  ";
								else if (player.isGooSkin()) desc += "Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. Your skin feels incredibly smooth.  ";
								else if (player.isScaleCovered()) desc += "Your [scales color] scales itch incessantly, and as you scratch yourself, they start falling off wholesale.  ";
								else if (player.hasCoat()) desc += "Your skin itches and tingles, starting to shed your [skin coat].  ";
								else desc += "You idly reach back to scratch yourself and nearly jump out of your [armor] when you hit something hard. A quick glance down reveals that scales are growing out of your [color] skin with alarming speed. As you watch, the surface of your skin is covered in smooth scales. They interlink together so well that they may as well be seamless.  You peel back your [armor] and the transformation has already finished on the rest of your body. ";
								desc += "<b>You're covered from head to toe in shiny " + color + " aqua scales.</b>"
								break;
							default:
								desc += "ERROR: DESCRIPTION FOR THIS LEVEL OF SCALES COVERAGE DOES NOT EXIST"
						}
					}

					player.skinDesc = "skin";
					player.skin.growCoat(Skin.AQUA_SCALES, options, coverage);
					//player.scaleColor = options.color;
					if (doOutput) outputText(desc);
					Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.AQUA_SCALES));
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.AQUA_SCALES);

					return player.hasCoatOfType(Skin.AQUA_SCALES) && InCollection(player.scaleColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}

	public function SkinGoo(coverage: int = Skin.COVERAGE_COMPLETE, type: int = 0, options: * = null): Transformation {
		return new SimpleTransformation("Goo Skin",
				//'type' refers to the variety of slime TF's.
				//0 == normal slime
				//1 == magma slime
				//2 == dark slime
				// apply effect
				function (doOutput: Boolean): void {
					//var desc: String = "";
					if (player.hasPlainSkinOnly()) outputText("[pg]You sigh, feeling your [armor] sink into you as your skin becomes less solid, gooey even.  You realize your entire body has become semi-solid and partly liquid!");
					else if (player.isFurCovered()) outputText("[pg]You sigh, suddenly feeling your fur become hot and wet.  You look down as your [armor] sinks partway into you.  With a start you realize your fur has melted away, melding into the slime-like coating that now serves as your skin.  You've become partly liquid and incredibly gooey!");
					else if (player.isScaleCovered()) outputText("[pg]You sigh, feeling slippery wetness over your scales.  You reach to scratch it and come away with a slippery wet coating.  Your scales have transformed into a slimy goop!  Looking closer, you realize your entire body has become far more liquid in nature, and is semi-solid.  Your [armor] has even sunk partway into you.");
					else if (player.skin.base.type != Skin.GOO) outputText("[pg]You sigh, feeling your [armor] sink into you as your [skin] becomes less solid, gooey even.  You realize your entire body has become semi-solid and partly liquid!");
					player.skin.setBaseOnly({type: Skin.GOO, adj: "slimy", pattern: Skin.PATTERN_NONE});
					if (!InCollection(player.skinColor, SlimeRace.SlimeSkinColors) && type == 0) {
						player.skinColor = randomChoice(SlimeRace.SlimeSkinColors);
						outputText("  Stranger still, your skin tone changes to [skin color]!");
					}
					if (!InCollection(player.skinColor, MagmaSlimeRace.MagmaSlimeSkinColors) && type == 1) {
						player.skinColor = randomChoice(MagmaSlimeRace.MagmaSlimeSkinColors);
						outputText("  Stranger still, your skin tone changes to [skin color]!");
					}
					if (!InCollection(player.skinColor, DarkSlimeRace.DarkSlimeSkinColors) && type == 2) {
						player.skinColor = randomChoice(DarkSlimeRace.DarkSlimeSkinColors);
						outputText("  Stranger still, your skin tone changes to [skin color]!");
					}
					//if (doOutput) outputText(desc);
					switch (type) {
						case 0: Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.SLIME));
							break;
						case 1: Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.MAGMA_SLIME));
							break;
						case 2: Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.DARK_SLIME));
							break;
					}
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.GOO);

					return player.skin.base.type == Skin.GOO && InCollection(player.skinColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}

	public function SkinBark(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation {
		return new SimpleTransformation("Bark Skin",
				function (doOutput: Boolean): void {
					var desc: String = "";
					desc += "Your [skin] burns, and you look down, your [skin] blackening, beginning to flake off. Crying out in shock, you scratch your arm. This only speeds up the process, your [skin] sloughing off in thin strips. The pain is intense, and your arms curl, ignoring your commands as your shoulders spasm. For a moment, you can see beneath your skin, muscles visible, before a brown-black coating pushes through, up from your bones. A sense of relief fills you, and after a few minutes, you regain control, bringing your hands to your face.";
					desc += "Thick bark, not unlike that of the world tree’s, now covers your entire body. The iron-hard, rough wood is surprisingly flexible, but you notice that you can’t feel as much through this new, natural armour. <b>You are now covered by [skin color] bark from head to toe.</b>";
					player.skin.setBaseOnly({type: Skin.BARK, adj: "bark-like", pattern: Skin.PATTERN_NONE});
					if (doOutput) outputText(desc);
					Metamorph.unlockMetamorph(SkinMem.getMemory(SkinMem.BARK));
				},
				// is present
				function (): Boolean {
					options = skinFormatOptions(options, Skin.BARK);

					return player.skin.base.type == Skin.BARK && InCollection(player.skinColor, options.colors) && player.skin.coverage == coverage;
				}
		)
	}

	private function skinFormatOptions(options: *, type:int): * {
		if (!options) options = {};
		if (!options.adj) options.adj = "";
		if (!options.pattern) options.pattern = "";
		if (!options.colors) options.colors = BodyMaterial.Types[Skin.SkinTypes[type].material].defaultColors;
		if (!options.color && options.colors)
			options.color = randomChoice(options.colors);
		return options;
	}
	/*
  */

	/*
    *    ███████ ██   ██ ██ ███    ██ 			███████   █████  ████████ ████████ ███████ ██████  ███    ██
    *    ██      ██  ██  ██ ████   ██ 			██   ██  ██   ██    ██       ██    ██      ██   ██ ████   ██
    *    ███████ █████   ██ ██ ██  ██ 			███████  ███████    ██       ██    █████   ██████  ██ ██  ██
    *         ██ ██  ██  ██ ██  ██ ██ 			██		 ██   ██    ██       ██    ██      ██   ██ ██  ██ ██
    *    ███████ ██   ██ ██ ██   ████ 			██		 ██   ██    ██       ██    ███████ ██   ██ ██   ████
    */

	/*
      */
	public const SkinPatternNone: Transformation = new SimpleTransformation("No Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your skin patterns itche incessantly, and as you scratch, they shift and change, becoming less and less visible till they are gone. <b>Your skin is without any skin patterns!</b>";
				player.skin.base.adj = "";
				player.skin.base.pattern = Skin.PATTERN_NONE;
				player.skin.coat.pattern = Skin.PATTERN_NONE;

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.skin.pattern === Skin.PATTERN_NONE;
			}
	);

	public const SkinPatternOrc: Transformation = new SimpleTransformation("Orc Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You double over suddenly as a harsh, stabbing pain runs across your skin, tattoos in the shape of scars forming on various parts of your body. Considering how you look now, you might as well proudly display your <b>Orc scar tattooed skin.</b>";
				player.skinColor2    = "black";
				player.skin.base.adj = "scar shaped tattooed";
				player.skin.base.pattern = Skin.PATTERN_SCAR_SHAPED_TATTOO;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.SCAR_SHAPED));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_SCAR_SHAPED_TATTOO;
			}
	);

	public const SkinPatternRaiju: Transformation = new SimpleTransformation("Raiju Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly feel a rush of electricity on your skin as glowing tattoos in the shape of lightning bolts form in various place across your body. Well, how shocking. <b>Your skin is now inscribed with some lightning shaped tattoos.</b>";
				player.skin.base.adj = "tattooed";
				player.skin.base.pattern = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.LIGHTNING_SHAPED));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
			}
	);

	public const SkinPatternOni: Transformation = new SimpleTransformation("Oni Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "As you thought your skin couldn't handle more tattoo a few localised skin burns reveal a new set of drawing along your skin, some decorating your chest. Well, you might as well proudly display your <b>Oni tattooed skin.</b>";
				player.skin.base.adj = "tattooed";
				player.skin.base.pattern = Skin.PATTERN_BATTLE_TATTOO;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.BATTLE));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_BATTLE_TATTOO;
			}
	);

	public const SkinPatternKitsune: Transformation = new SimpleTransformation("Kitsune Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face. You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing magical tattoos adorns your [skin]. The glow gradually fades, but the distinctive ";
				if (rand(2) == 0) desc += "angular";
				else desc += "curved";
				desc += " markings remain, as if etched into your skin. <b>You now have Kitsune tattoos on your skin.</b>";
				player.skinColor2    = "black";
				player.skin.base.adj = "tattooed";
				player.skin.base.pattern = Skin.PATTERN_MAGICAL_TATTOO;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.MAGICAL));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_MAGICAL_TATTOO;
			}
	);

	public const SkinPatternVenomousMarkings: Transformation = new SimpleTransformation("Venomous Markings Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You feel an unusual warmth in your chest. You look down to see a purple blot form on your chest and then begin to spread out across your skin like brushstrokes. It doesn't stop until your skin is covered in intricate purple designs. You can feel your venom pumping through them. <b>Your skin is covered in venomous body markings.</b>";

				player.skin.base.pattern = Skin.PATTERN_VENOMOUS_MARKINGS;
				player.skin.base.adj = "venomous markings-covered";
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.PATTERN_VENOMOUS_MARKINGS));

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_VENOMOUS_MARKINGS;
			}
	);

	public const SkinPatternWhiteBlackVeins: Transformation = new SimpleTransformation("White Black Veins Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your skin tingles and itches faintly. You look down to see ";
				if (player.skinColor1 == "sable") desc += "white";
				if (player.skinColor1 == "white") desc += "black";
				desc += " veins etching deep into your skin across the entirety of your body. <b>You now have ";
				if (player.skinColor1 == "sable") desc += "white";
				if (player.skinColor1 == "white") desc += "black";
				desc += " veins.</b>";
				if (player.skinColor1 == "sable") player.skinColor2 = "white";
				if (player.skinColor1 == "white") player.skinColor2 = "black";

				player.skin.base.pattern = Skin.PATTERN_WHITE_BLACK_VEINS;
				player.skin.base.adj = "veined";

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.BLACK_WHITE_VEINS));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_WHITE_BLACK_VEINS;
			}
	);

	public const SkinPatternOil: Transformation = new SimpleTransformation("Oil Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "The black tar like substance begins to drip everywhere around your body now, from your ass, your shoulders and even your chest. Soon your torso looks like it bathed into tar some of it dripping down your body. The fluids however are regularly produced like sweat from your skin so you never run out. <b>Your body now drips black fluids.</b>";

				player.skin.base.pattern = Skin.PATTERN_OIL;
				player.skin.base.adj = "oily skin";

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.OIL));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_OIL;
			}
	);

	public const SkinPatternScarWindswept: Transformation = new SimpleTransformation("Scar Windswept Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You scream in pain as your aura flares again, leaving clean cuts all over your body. The cuts glows green for an instant before taking back on a more ordinary brown tone, closing into what looks like innocuous scars at first glance. <b>Clearly those new windswept scars of yours actually improves your wind control, marking you as a full Kamaitachi.</b>";

				player.skin.base.pattern = Skin.PATTERN_SCAR_WINDSWEPT;
				player.skin.base.adj = "windswept scars";
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.SCAR_WINDSWEPT));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_SCAR_WINDSWEPT;
			}
	);

	public const SkinPatternUshiOniTattoo: Transformation = new SimpleTransformation("Ushi-Oni Tattoo Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Your chest burns as strange marks appear on it, burning your skin until it creates a <b>black spider glyph in your chest</b>. You feel like something is coming up throughout your skin and upon taking your [armor] off, strokes of coarse fur travelling from your abdomen, all the way up to your breasts. Conveniently ending around the nipples, covering them, <b>you know have a Ushi-Oni torso pattern.</b>";

				player.skin.base.pattern = Skin.PATTERN_USHI_ONI_TATTOO;
				player.skin.base.adj = "black spider glyph-tattooed";

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_USHI_ONI_TATTOO;
			}
	);

	public const SkinPatternBeeStripes:Transformation = new SimpleTransformation("Bee Stripes Skin Pattern",
			// apply effect
			function (doOutput:Boolean):void {
				TransformationUtils.applyTFIfNotPresent(transformations.SkinChitin(Skin.COVERAGE_LOW, { color: "yellow" }), doOutput);
				var desc:String = "A ripple spreads through your chitin as some patches change in color. After a few moments you're left with a yellow and black striped pattern, like a bee's! <b>You've got striped chitin!</b>";
				player.skin.coat.pattern = Skin.PATTERN_BEE_STRIPES;
				if (!InCollection(player.chitinColor2, "black", "ebony"))
					player.chitinColor2 = randomChoice("black", "ebony");
				if (player.chitinColor1 != "yellow")
					player.chitinColor1 = "yellow";
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.BEE_STRIPES));
			},
			// is present
			function ():Boolean {
				return transformations.SkinChitin(Skin.COVERAGE_LOW).isPresent() && player.skin.coat.pattern === Skin.PATTERN_BEE_STRIPES;
			}
	);

	public const SkinPatternTigerSharkStripes:Transformation = new SimpleTransformation("Shark Stripes Skin Pattern",
			// apply effect
			function (doOutput:Boolean):void {
				TransformationUtils.applyTFIfNotPresent(transformations.SkinAquaScales(Skin.COVERAGE_HIGH, {color: "orange", color2: "black", pattern: Skin.PATTERN_TIGER_STRIPES}), doOutput);
				var desc:String = "\nYour scales begins to tingle and itch, before rapidly shifting to a shiny orange color, marked by random black scales looking like tiger stripes. You take a quick look in a nearby pool of water, to see your skin has morphed in appearance and texture to become more like a Tiger Shark!";
				//player.scaleColor = "orange";
				//player.scaleColor2 = "black";
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.SHARK_STRIPES));
			},
			// is present
			function ():Boolean {
				return transformations.SkinAquaScales(Skin.COVERAGE_HIGH).isPresent() && player.skin.pattern === Skin.PATTERN_TIGER_STRIPES;
			}
	);

	public const SkinPatternOrca:Transformation = new SimpleTransformation("Orca Skin Pattern",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				if (player.isFurCovered()) desc += "You suddenly start sweating abundantly as your [skin.type] fall off leaving bare the smooth skin underneath.  ";
				if (player.isGooSkin()) desc += "Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. Then you start sweating abundantly. ";
				if (player.isScaleCovered()) desc += "You suddenly start sweating abundantly as your scales fall off leaving bare the smooth skin underneath.  ";
				desc += "Your skin starts to change, turning darker and darker until it is pitch black. Your underbelly, on the other hand , turns pure white. Just as you thought it was over, your skin takes on a glossy shine similar to that of a whale. <b>Your body is now black with a white underbelly running on the underside of your limbs and up to your mouth in a color pattern similar to an orca’s.</b>";
				player.skin.setBaseOnly({
					type: Skin.PLAIN,
					adj: "glossy",
					pattern: Skin.PATTERN_ORCA_UNDERBODY,
					color: "black",
					color2: "pure white"
				});
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.ORCA_UNDERBODY));
			},
			// is present
			function ():Boolean {
				return player.skin.pattern === Skin.PATTERN_ORCA_UNDERBODY;
			}
	);

	public const SkinPatternSeaDragon:Transformation = new SimpleTransformation("Sea dragon Skin Pattern",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				var ColorList:Array = [
					{color: 'aphotic blue-black', underbellycolor: 'pure white'},
					{color: 'aphotic blue-black', underbellycolor: 'snow white'},
					{color: 'aphotic blue-black', underbellycolor: 'light blue'},
					{color: 'silky', underbellycolor: 'pure white'},
					{color: 'silky', underbellycolor: 'snow white'},
					{color: 'silky', underbellycolor: 'light blue'},
					{color: 'aqua', underbellycolor: 'snow white'},
					{color: 'aqua', underbellycolor: 'light blue'},
					{color: 'turquoise', underbellycolor: 'snow white'},
					{color: 'turquoise', underbellycolor: 'light blue'},
					{color: 'pink', underbellycolor: 'pure white'},
					{color: 'pink', underbellycolor: 'snow white'},
					{color: 'pink', underbellycolor: 'light blue'},
					{color: 'pink', underbellycolor: 'crimson platinum'},
					{color: 'dark blue', underbellycolor: 'pure white'},
					{color: 'dark blue', underbellycolor: 'snow white'},
					{color: 'dark blue', underbellycolor: 'light blue'}
				];
				var colorPair:Number = rand(ColorList.length-1);
				var underBellyColor:String = ColorList[colorPair].underbellycolor;
				var bodyColor:String = ColorList[colorPair].color;
				player.skinColor1 = bodyColor;
				player.skinColor2 = underBellyColor;
				if (player.isFurCovered()) desc += "You suddenly start sweating abundantly as your [skin.type] fall off leaving bare the smooth skin underneath.  ";
				if (player.isGooSkin()) desc += "Your gooey skin solidifies, thickening up as your body starts to solidify into a more normal form. Then you start sweating abundantly. ";
				if (player.isScaleCovered()) desc += "You suddenly start sweating abundantly as your scales fall off leaving bare the smooth skin underneath.  ";
				desc += "Your skin starts to change, turning [skin color1]. Your underbelly, on the other hand, turns [skin color2]. Just as you thought it was over, your skin takes on a glossy shine. When you thought it was finally over, specks of light start to form underneath your arms, spreading to your underbelly. The bioluminescence gives you an appearance akin to those of a deep-sea creature. <b>Your body is now [skin color] with a [skin color2] underbelly running on the underside of your limbs and up to your mouth, with bioluminescent patterns on the belly just like those of a sea dragon.</b>";
				player.skin.setBaseOnly({type: Skin.PLAIN, adj: "glossy", pattern: Skin.PATTERN_SEA_DRAGON_UNDERBODY});
				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.SEA_DRAGON_UNDERBODY));
			},
			// is present
			function ():Boolean {
				return player.skin.pattern === Skin.PATTERN_SEA_DRAGON_UNDERBODY;
			}
	);

	public const SkinPatternArchImp: Transformation = new SimpleTransformation("Arch-Imp Runic Tattoo Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";


				desc += "You feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face. You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing magical tattoos adorns your [skin]. The glow gradually dulls, but the distinctive angular markings remain, as if etched into your skin. <b>You now have Arch-Imp tattoos on your skin.</b>";

				player.skin.base.pattern = Skin.PATTERN_ARCH_IMP_RUNIC_TATTOO;
				player.skin.base.adj = "tattooed";

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_ARCH_IMP_RUNIC_TATTOO;
			}
	);

	public const SkinPatternAnubis: Transformation = new SimpleTransformation("Anubis Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "You suddenly feel a searing warmth all over your skin as white patterns not unlike those of the desert anubis appear as if branded onto your flesh. Well, you might as well proudly display your <b>Anubis glyph like tattoo.</b>";
				player.skin.base.adj = "tattooed";
				player.skin.base.pattern = Skin.PATTERN_GLYPH_TATTOO;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.GLYPH));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_GLYPH_TATTOO;
			}
	);

	public const SkinPatternBioluminescence: Transformation = new SimpleTransformation("Bioluminescence Skin Pattern",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "";

				desc += "Specks of light forms underneath your arms, spreading to your underbelly and your legs all along the length of your body. The bioluminescence gives you an appearance akin to those of a deep-sea creature. <b>You have gained bioluminescent patterns like those of a deep sea creature!</b>";
				player.skin.base.pattern = Skin.PATTERN_BIOLUMINESCENCE;

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SkinPatternMem.getMemory(SkinPatternMem.BIOLUMINESCENCE));
			},
			// is present
			function (): Boolean {
				return player.skin.base.pattern === Skin.PATTERN_BIOLUMINESCENCE;
			}
	);
	/*
  */
}
}
