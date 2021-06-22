package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Hair;
import classes.internals.EnumValue;

  public class HairMem extends BaseContent {
	/**
	 * Entry properties:
	 * - metamorphCost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - metamorphFunc: the scene of the metamorph
	 * - isUnlockedFunc: function that returns whether the player unlocked this metamorph
	 * - partsInUseFunc: function that returns whether the player is already using all the metamorph's target parts, disables button if true

	 * Template:

		public static const [NAME HERE]:int = IDHERE;
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			metamorphCost: [Cost Here],
			metamorphTitle: "[Race Here]",
			metamorphFunc: function(creature: *): void {
				var desc: String = "";

				outputText(formatDescription(desc, creature));
				creature.part = Part.[NAME HERE];
			},
			isUnlockedFunc: function(creature: *): Boolean {
  			return [CHECK IF UNLOCKED HERE];
  		},
			partsInUseFunc: function(creature: *): Boolean {
				return creature.part == Part.[NAME HERE];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];

		public static const NORMAL:int = 0;
		EnumValue.add(Memories, NORMAL, "NORMAL", {
			metamorphCost: 500,
			metamorphTitle: "Human",
			metamorphFunc: function(creature: *): void {
  			var desc: String = "";

  			if (creature.hairType == Hair.FEATHER || creature.hairType == Hair.QUILL) {
  				var word1:String;
  				if (creature.hairType == Hair.FEATHER) {
  					word1 = "feather";
  				}	else {
  					word1 = "quill";
  				}
  				if (creature.hairLength >= 6) {
  					desc += "A lock of your downy-soft " + word1 + "-hair droops over your eye. Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself. It continues to curl inward until all that remains is a normal strand of hair. <b>Your hair is no longer " + word1 + "-like!</b>";
  				} else {
  					desc += "You run your fingers through your downy-soft " + word1 + "-hair while you await the effects of the item you just ingested. While your hand is up there, it detects a change in the texture of your " + word1 + "s. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer " + word1 + "-like!</b>";
  				}
  			} else if (creature.hairType == Hair.ANEMONE) {
  				desc += "You feel something strange going in on your head. You reach your hands up to feel your tentacle-hair, only to find out that the tentacles have vanished and replaced with normal hair. <b>Your hair is normal again!</b>";
  			} else if (creature.hairType == Hair.GOO) {
  				desc += "Your gooey hair begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>";
  			} else if (creature.hairType == Hair.GORGON) {
  				creature.hairLength = 1;
  				desc += "As you finish the root, the scaled critters on your head shake wildly in displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of your spicy meal make themselves notorious, as the writhing mess of snakes start hissing uncontrollably. Many of them go rigid, any kind of life that they could had taken away by the root effects. Soon all the snakes that made your hair are limp and lifeless.";
  				desc += "Their dead bodies are separated from you head by a scorching sensation, and start falling to the ground, turning to dust in a matter of seconds. Examining your head on the stream, you realize that you have a normal, healthy scalp, though devoid of any kind of hair.";
  				desc += "The effects don’t end here, though as the familiar sensation of hair returns to your head a moment later. After looking yourself on the stream again, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.";
  			} else if (creature.hairType == Hair.GHOST) {
  				desc += "A sensation of weight assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming heavier in your grasp. Plucking a strand, you hold it up before you, surprised to see... it's no longer transparent! You have normal hair!";
  			} else if (creature.hairType == Hair.LEAF) {
  				if (creature.hairLength >= 6) {
  					desc += "A lock of your leaf-hair droops over your eye. Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair. <b>Your hair is no longer leaf-like!</b>";
  				} else {
  					desc += "You run your fingers through your leaf-hair while you await the effects of the item you just ingested. While your hand is up there, it detects a change in the texture of your leafs. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer leaf-like!</b>";
  				}
  			} else if (creature.hairType == Hair.FLUFFY) {
  				desc += "You feel something strange going in on your head. You reach your hands up to feel your fluffy hair, only to find out that they have vanished and replaced with normal hair. <b>Your hair is normal again!</b>";
  			} else if (creature.hairType == Hair.GRASS) {
  				desc += "You feel something strange going in on your head. You reach your hands up to feel your grass-hair, only to find out that the long, soft and leafy blades have vanished and replaced with normal hair. <b>Your hair is normal again!</b>";
  			} else if (creature.hairType == Hair.SILKEN) {
  				desc += "You feel something strange going in on your head. You reach your hands up to feel your silken-hair, only to find out that they have changed back to normal hair. <b>Your hair is normal again!</b>";
  			} else if (creature.hairType == Hair.BURNING) {
  				desc += "Your head begins to cool down until the flames entirely disapear, leaving you with ordinary hair. <b>Your hair is normal again!</b>";
  			} else {
  				desc += "You feel a strange sensation on your head. Passing a hand on it, you realize it feels completely human. <b>Your hair is normal again!</b>";
  			}

  			outputText(formatDescription(desc, creature));
  			creature.hairType = Hair.NORMAL;
  		},
			isUnlockedFunc: function(creature: *): Boolean {
  			return creature.hasStatusEffect(StatusEffects.UnlockedHumanHair);
  		},
			partsInUseFunc: function(creature: *): Boolean {
        return creature.hairType == Hair.NORMAL;
      }
		});

		public static const FEATHER:int = 1;
		EnumValue.add(Memories, FEATHER, "FEATHER", {
			metamorphCost: 100,
			metamorphTitle: "Harpy",
			metamorphFunc: function(creature: *): void {
  			var desc: String = "";

				desc += "A tingling starts in your scalp, getting worse and worse until you're itching like mad. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. <b>You have feathers for hair, just like a harpy!</b>";

  			outputText(formatDescription(desc, creature));
  			creature.hairType = Hair.FEATHER;
  		},
			isUnlockedFunc: function(creature: *): Boolean {
  			return creature.hasStatusEffect(StatusEffects.UnlockedHarpyHair);
  		},
			partsInUseFunc: function(creature: *): Boolean {
        return creature.hairType == Hair.FEATHER;
      }
		});

		public static const GORGON:int = 2;
		EnumValue.add(Memories, GORGON, "GORGON", {
			metamorphCost: 100,
			metamorphTitle: "Gorgon",
			metamorphFunc: function(creature: *): void {
				var desc: String = "Nothing seems to be happening, until you feel a tingling sensation atop your head.";

				if (creature.hairLength == 0) {
					desc += " You run your fingers over it and feel small nubs growing quickly, becoming something akin to small ropes. After a moment, the growth stops and the nubs are gradually covered by scales.";
				} else {
					desc += "You run your fingers through your [hair], noticing a change in the texture. The strands are fusing together, becoming as thick as small ropes whilst being slowly covered by scales.";

					if (creature.hairLength < 6) desc += " Additionaly, its length seems to grow.";
				}

				desc += "\n\nBut that's not all. At the end of each oversized strand, something is taking shape. Bringing one to your face, you watch as the rope-like strand covered in scales morphs into a somewhat cute snake, and you can somehow feel as the same happens to the other strands, now more than just hair. <b>Your hair has turned into snakes!</b>";

				outputText(formatDescription(desc, creature));
				if (creature.hairLength < 6) creature.hairLength = 6;
				creature.hairType = Hair.GORGON;
			},
			isUnlockedFunc: function(creature: *): Boolean {
  			return creature.hasStatusEffect(StatusEffects.UnlockedGorgonHair);
  		},
			partsInUseFunc: function(creature: *): Boolean {
				return creature.hairType == Hair.GORGON;
			}
		});

		public static const ELF:int = 3;
		EnumValue.add(Memories, ELF, "ELF", {
			metamorphCost: 100,
			metamorphTitle: "Elf",
			metamorphFunc: function(creature: *): void {
				var desc: String = "Something changes in your scalp, prompting you to pass a hand through it. To your surprise, your hair's texture is turning silky, far more than years of proper care would manage. The touch is so agreeable you can’t help but idly stroke your strands for a few more moments. <b>Your hair has taken on an unbelievably silky texture, just like that of an elf!</b>";

				outputText(formatDescription(desc, creature));
				creature.hairType = Hair.SILKEN;
			},
			isUnlockedFunc: function(creature: *): Boolean {
  			return creature.hasStatusEffect(StatusEffects.UnlockedElfHair);
  		},
			partsInUseFunc: function(creature: *): Boolean {
				return creature.hairType == Hair.SILKEN;
			}
		});

		public static const RAIJU:int = 4;
		EnumValue.add(Memories, RAIJU, "RAIJU", {
			metamorphCost: 100,
			metamorphTitle: "Raiju",
			metamorphFunc: function(creature: *): void {
				var desc: String = "A strange zapping sound is the only warning you receive before a weak shock runs through the back of your head. Irritated and confused, you bring a hand to the spot and rub it, only for a sudden electical noise to make itself known at the contact.\n\nKnowing for a fact that your hair shouldn't sound like that, or like anything at all for that matter, you bring both your hands to explore it and make note of several glowing strands shaped like stylized lightning bolts. There's even a single strand that floats just off the side of your face, refusing to stay down no matter how many times you try to reposition it. With a sigh, you give up on it, deciding that it's not really important to defeat your own hair. <b>You now have electrical raiju hair!</b>";

				outputText(formatDescription(desc, creature));
				creature.hairType = Hair.STORM;
			},
			isUnlockedFunc: function(creature: *): Boolean {
  			return creature.hasStatusEffect(StatusEffects.UnlockedRaijuHair);
  		},
			partsInUseFunc: function(creature: *): Boolean {
				return creature.hairType == Hair.STORM;
			}
		});

		public static const HELLCAT:int = 5;
		EnumValue.add(Memories, HELLCAT, "HELLCAT", {
			metamorphCost: 100,
			metamorphTitle: "Hellcat",
			metamorphFunc: function(creature: *): void {
				var desc: String = "";

				if (creature.hairType != Hair.NORMAL) {
					HairMem.Memories[HairMem.NORMAL].metamorphFunc;
					desc += "\n\n";
				}

				desc += "Your head is suddenly attacked by warmth, as though it were right next to a campfire. Before you can wonder what's going on, your {hair} is set ablaze in an spectacular explosion. You very nearly have a panic attack before realizing you're not being harmed by the flames, which instead fade until they only cover your {hair}'s tips.\n\nA few tests later, and you confirm that the flames don't seem to actually burn anything unless you will them to. You find that great, as the alternative would force you to give up on normal beds for the foreseeable future. <b>You now have burning hellcat hair!</b>";

				outputText(formatDescription(desc, creature));
				creature.hairType = Hair.BURNING;
			},
			isUnlockedFunc: function(creature: *): Boolean {
  			return creature.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair);
  		},
			partsInUseFunc: function(creature: *): Boolean {
				return creature.hairType == Hair.BURNING;
			}
		});

		// Used for local tags in descriptions to be replaced with creature data
	  private static function formatDescription(desc: String, creature: *): String {
			var hair:String = "hair";

			//If furry and longish hair sometimes call it a mane (50%)
			if (creature.hasFur() == 1 && creature.hairLength > 3 && rand(2) == 0) {
				hair = "mane";
			}

			const hairPattern:RegExp = /{hair}/g;
			const hairInfoPattern:RegExp = /{hairInfo}/g;

			return desc
				.replace(hairPattern, hair);
		}
  }
}
