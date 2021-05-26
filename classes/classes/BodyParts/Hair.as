package classes.BodyParts {
import classes.Creature;
import classes.BodyParts.*;
import classes.internals.EnumValue;
import classes.StatusEffects;
import classes.internals.Utils;

public class Hair extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "FEATHER")
	 * - name: human-readable default name, ("normal", "feather")
	 *
	 * - shortDesc: simple description of the hair
	 * - shortDescFunc: function that returns a shortDesc value (shortDesc is ignored if this exists)
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - beardDesc: description of the beard linked to the hair type
	 *
	 * - ignoresStyle: hair's unique appearance ignores normal hairstyles (plain, wild, etc.)
	 *
	 * - metamorphFlag: which status effect defines whether the metamorph was unlocked (if there's none, it can't be unlocked)
	 * - metamorphCost: how much SF it costs to metamorph this part (defaults to 100)
	 * - metamorphTitle: name displayed on the metamorph button
	 * - tfDesc: TF scene for the part
	 * - tfDescFunc: function that returns a tfDesc string value (tfDesc is ignored if this exists)
	 * - tfFunc: effects of the TF on the creature
	 */

	public static var Types:/*EnumValue*/Array = [];

	public static const NORMAL:int = 0;
	EnumValue.add(Types, NORMAL, "NORMAL", {
		name:"normal",
		metamorphFlag: StatusEffects.UnlockedHumanHair,
		metamorphCost: 500,
		metamorphTitle: "Human",
		appearanceDesc: "Although not particularly remarkable, your {hairInfo} looks good on you, accentuating your features well.",
		tfDescFunc: function(creature: *): String {
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

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.hairType = Hair.NORMAL;
		}
	});

	public static const FEATHER:int = 1;
	EnumValue.add(Types, FEATHER, "FEATHER", {
		name:"feather",
		shortDesc: "feather-{hair}",
		appearanceDesc: "Your {hairInfo} is made completely out of feathers rather than actual strands.",
		ignoresStyle: true,
		metamorphFlag: StatusEffects.UnlockedHarpyHair,
		metamorphCost: 100,
		metamorphTitle: "Harpy",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "A tingling starts in your scalp, getting worse and worse until you're itching like mad. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. <b>You have feathers for hair, just like a harpy!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.hairType = Hair.FEATHER;
		}
	});

	public static const GHOST:int = 2;
	EnumValue.add(Types, GHOST, "GHOST", {
		name:"ghost",
		shortDesc: "transparent {hair}",
		appearanceDesc: "Although your {hairInfo} technically has the features of normal human hair, it is also completely transparent.",
		beardDesc: "transparent ",
		metamorphFlag: StatusEffects.UnlockedHarpyHair,
		metamorphCost: 100,
		metamorphTitle: "Harpy",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "A tingling starts in your scalp, getting worse and worse until you're itching like mad. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. <b>You have feathers for hair, just like a harpy!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.hairType = Hair.FEATHER;
		}
	});

	public static const GOO:int = 3;
	EnumValue.add(Types, GOO, "GOO", {
		name:"goopy",
		shortDesc: "goo-{hair}",
		appearanceDesc: "Atop your head is a gooey {hairInfo}, more like an amorphous blob imitating the familiar shape than the real deal.",
		beardDesc: "gooey "
	});

	public static const ANEMONE:int = 4;
	EnumValue.add(Types, ANEMONE, "ANEMONE", {
		name:"tentacle",
		shortDesc: "tentacle-{hair}",
		appearanceDesc: "Your {hairInfo} is in truth made out of anemone tentacles, only vaguely resembling the real deal.",
		beardDesc: "tentacley ",
		ignoresStyle: true
	});

	public static const QUILL:int = 5;
	EnumValue.add(Types, QUILL, "QUILL", {
		name:"quill",
		shortDesc: "quill-{hair}",
		appearanceDesc: "Your {hairInfo} is made completely out of quills rather than actual strands.",
		ignoresStyle: true
	});

	public static const GORGON:int = 6;
	EnumValue.add(Types, GORGON, "GORGON", {
		name:"snake-like",
		shortDesc: "snakes-{hair}",
		appearanceDesc: "Atop your head is technically {hairInfo}, if one were to ignore that it is made of snakes rather than actual hair.",
		ignoresStyle: true,
		metamorphFlag: StatusEffects.UnlockedGorgonHair,
		metamorphCost: 100,
		metamorphTitle: "Gorgon",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Nothing seems to be happening, until you feel a tingling sensation atop your head.";

			if (creature.hairLength == 0) {
				desc += " You run your fingers over it and feel small nubs growing quickly, becoming something akin to small ropes. After a moment, the growth stops and the nubs are gradually covered by scales.";
			} else {
				desc += "You run your fingers through your [hair], noticing a change in the texture. The strands are fusing together, becoming as thick as small ropes whilst being slowly covered by scales.";

				if (creature.hairLength < 6) desc += " Additionaly, its length seems to grow longer than what it was before.";
			}
			desc += "\n\nBut that's not all. At the end of each oversized strand, something is taking shape. Bringing one to your face, you watch as the rope-like strand covered in scales morphs into a somewhat cute snake, and you can somehow feel as the same happens to the other strands, now more than just hair. <b>Your hair has turned into snakes!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			if (creature.hairLength < 6) creature.hairLength = 6;
			creature.hairType = Hair.GORGON;
		}
	});

	public static const LEAF:int = 7;
	EnumValue.add(Types, LEAF, "LEAF", {
		name:"leaf",
		shortDesc: "leaf-{hair}",
		appearanceDesc: "Considering how your {hairInfo} is made completely out of leaves, you seem to have some sort of connection to nature.",
		beardDesc: "moss "
	});

	public static const FLUFFY:int = 8;
	EnumValue.add(Types, FLUFFY, "FLUFFY", {
		name:"fluffy",
		shortDesc: "fluffy {hair}",
		appearanceDesc: "You have a white pillowy {hair}, very much wooly to the touch and constantly trying to lull you to sleep anytime you lie against a surface.",
		ignoresStyle: true
	});

	public static const GRASS:int = 9;
	EnumValue.add(Types, GRASS, "GRASS", {
		name:"grass",
		shortDesc: "grass-{hair}",
		appearanceDesc: "Rather than normal strands, your {hairInfo} is actually made entirely of grass, like some sort of nature spirit's."
	});

	public static const SILKEN:int = 10;
	EnumValue.add(Types, SILKEN, "SILKEN", {
		name:"silky",
		shortDesc: "elven {hair}",
		appearanceDesc: "Your {hairInfo} is extremely glossy and smooth, its elvish features so perfect by human standards to the point of feeling unnatural.",
		metamorphFlag: StatusEffects.UnlockedElfHair,
		metamorphCost: 100,
		metamorphTitle: "Elf",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Something changes in your scalp, prompting you to pass a hand through it. To your surprise, your hair's texture is turning silky, far more than years of proper care would manage. The touch is so agreeable you can’t help but idly stroke your strands for a few more moments. <b>Your hair has taken on an unbelievably silky texture, just like that of an elf!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.hairType = Hair.SILKEN;
		}
	});

	public static const STORM:int = 11;
	EnumValue.add(Types, STORM, "STORM", {
		name:"glowing lightning-shaped",
		shortDesc: "lightning {hair}",
		appearanceDesc: "Your wild {hairInfo}'s tips end in glowing lightning-shaped locks, cackling with electricity whenever you will them to.",
		ignoresStyle: true,
		metamorphFlag: StatusEffects.UnlockedRaijuHair,
		metamorphCost: 100,
		metamorphTitle: "Raiju",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "A strange zapping sound is the only warning you receive before a weak shock runs through the back of your head. Irritated and confused, you bring a hand to the spot and rub it, only for a sudden electical noise to make itself known at the contact.\n\nKnowing for a fact that your hair shouldn't sound like that, or like anything at all for that matter, you bring both your hands to explore it and make note of several glowing strands shaped like stylized lightning bolts. There's even a single strand that floats just off the side of your face, refusing to stay down no matter how many times you try to reposition it. With a sigh, you give up on it, deciding that it's not really important to defeat your own hair. <b>You now have electrical raiju hair!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.hairType = Hair.STORM;
		}
	});

	public static const BURNING:int = 12;
	EnumValue.add(Types, BURNING, "BURNING", {
		name:"burning",
		shortDesc: "burning hair",
		appearanceDesc: "Your wild {hair} has had its tips overtaken by a magic flame, burning anything you wish it to and nothing more.",
		ignoresStyle: true,
		metamorphFlag: StatusEffects.UnlockedHellcatBurningHair,
		metamorphCost: 100,
		metamorphTitle: "Hellcat",
		tfDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.hairType != Hair.NORMAL) {
				desc += Hair.Types[Hair.NORMAL].tfDescFunc(creature);
				Hair.Types[Hair.NORMAL].tfFunc(creature);
				desc += "\n\n";
			}

			desc += "Your head is suddenly attacked by warmth, as though it were right next to a campfire. Before you can wonder what's going on, your {hair} is set ablaze in an spectacular explosion. You very nearly have a panic attack before realizing you're not being harmed by the flames, which instead fade until they only cover your {hair}'s tips.\n\nA few tests later, and you confirm that the flames don't seem to actually burn anything unless you will them to. You find that great, as the alternative would force you to give up on normal beds for the foreseeable future. <b>You now have burning hellcat hair!</b>";

			return desc;
		},
		tfFunc: function(creature: *): void {
			creature.hairType = Hair.BURNING;
		}
	});

	public static const SNOWY:int = 13;
	EnumValue.add(Types, SNOWY, "SNOWY", {
		name:"snowy",
		shortDesc: "snowy {hair}",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "Your {hairInfo} is human in appearance, but cold to the touch and regularly used as a nest by snow flurries";

			if (creature.rearBody.type == RearBody.GLACIAL_AURA) {
				desc += ", an effect amplified by your bone-chilling aura";
			}

			desc += "."

			return desc;
		}
	});

	public static const FAIRY:int = 14;
	EnumValue.add(Types, FAIRY, "FAIRY", {
		name:"otherworldly silky and almost translucent",
		shortDesc: "silky fairy {hair}",
		appearanceDesc: "Despite looking almost human, your {hairInfo} is otherworldly smooth and almost translucent, its fairy traits easy to notice if not identify."
	});

	public static const CRAZY:int = 15;
	EnumValue.add(Types, CRAZY, "CRAZY", {
		name:"crazy",
		shortDesc: "crazy {hair}",
		appearanceDesc: "Your wild {hairInfo} is positively crazy, with spiked tips pointing outwards to your sides.",
		ignoresStyle: true
	});

	public static const WINDSWEPT:int = 16;
	EnumValue.add(Types, WINDSWEPT, "WINDSWEPT", {
		name:"windswept",
		appearanceDesc: "Your {hairInfo} is quite aerodynamic, shaped as to avoid encumbering you even in a windstorm."
	});

	public static const RATATOSKR:int = 17;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
		name:"stripped",
		shortDesc: "stripped {hair}",
		appearanceDesc: "Though your {hairInfo} could almost pass for human, it's stripped at the center with light tips not unlike the head of a chipmunk."
	});

	// Additional modifiers for hair descriptions
	public static var Styles:/*EnumValue*/Array = [];

	public static const PLAIN:int  = 0;
	EnumValue.add(Styles, PLAIN, "PLAIN", {
		adjective: "plain"
	});

	public static const WILD:int = 1;
	EnumValue.add(Styles, WILD, "WILD", {
		adjective: "wild"
	});

	public static const PONYTAIL:int  = 2;
	EnumValue.add(Styles, PONYTAIL, "PONYTAIL", {
		adjective: "ponytailed"
	});

	public static const LONGTRESSES:int  = 3;
	EnumValue.add(Styles, LONGTRESSES, "LONGTRESSES", {
		adjective: "low ponytailed"
	});

	public static const TWINPIGTAIL:int  = 4;
	EnumValue.add(Styles, TWINPIGTAIL, "TWINPIGTAIL", {
		adjective: "twintailed"
	});

	public static const DWARVEN:int  = 5;
	EnumValue.add(Styles, DWARVEN, "DWARVEN", {
		adjective: "twintailed"
	});

	public var color:String = "no";
	public var length:Number = 0.0;

	public function Hair() {
		super(null, null);
	}

	public override function restore(keepColor:Boolean = true):void {
		super.restore();
		color = "no";
		length = 0.0;
	}

	public static function getDescription(creature: *): String {
		if (creature.hairLength == 0) {
			if(creature.skinType == Skin.FUR)
				return "furry head";
			else {
				return getHairLength(creature) + " head";
			}
		}

		const id: int = creature.hairType;
		const idStyle: int = creature.hairStyle;

		return (Types[id].ignoresStyle ? "" : Styles[idStyle].adjective + " ") + getHairLength(creature) + " " +  creature.hairColor + " " + formatDescription(Types[id].shortDesc || "{hair}", creature);
	}

	public static function getShortDescription(creature: *): String {
		if (creature.hairLength == 0) {
			if(creature.skinType == Skin.FUR)
				return "furry head";
			else {
				return getHairLength(creature) + " head";
			}
		}

		const id: int = creature.hairType;

		return formatDescription(Types[id].shortDesc || "{hair}", creature);
	}

	public static function getAppearanceDescription(creature: *): String {
		if (creature.hairLength == 0) {
			if(creature.skinType == Skin.FUR)
				return "You have no hair, only a thin layer of fur atop of your head.";
			else {
				return "You have a completely " + getHairLength(creature) + " head, showing only shiny [skintone] [skin.type].";
			}
		}

		const id: int = creature.hairType;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	public static function getTFDescription(creature: *, bodyPart: *):String {
		return formatDescription((bodyPart.tfDescFunc ? bodyPart.tfDescFunc(creature) : bodyPart.tfDesc) || "", creature);
	}

	private static function formatDescription(desc: String, creature: *): String {

		const id: int = creature.hairType;
		const idStyle: int = creature.hairStyle;

		var hair:String = "hair";

		//If furry and longish hair sometimes call it a mane (50%)
		if (creature.hasFur() == 1 && creature.hairLength > 3 && rand(2) == 0) {
			hair = "mane";
		}

		const hairPattern:RegExp = /{hair}/g;
		const hairInfoPattern:RegExp = /{hairInfo}/g;

		return desc
			.replace(hairPattern, hair)
			.replace(hairInfoPattern, (Types[id].ignoresStyle ? "" : Styles[idStyle].adjective + " ") + getHairLength(creature) + " " +  creature.hairColor + " " +  hair);
	}

	public static function getHairLength (creature: *): String {
		var options:Array;
		var hairscale:Number;

		hairscale = int((creature.hairLength/creature.tallness)*100)/100
		if (hairscale == 0) {
			options = ["shaved", "bald", "smooth", "hairless", "glabrous"];
			return randomChoice(options);
		} else if (hairscale <= 0.05){
			options = ["close-cropped", "trim",	"very short"];
			return randomChoice(options);
		}	else if (hairscale > 0.05 && hairscale <= 0.1){
			return "short";
		}	else if (hairscale > 0.1 && hairscale <= 0.14){
			return "shaggy";
		}	else if (hairscale > 0.14 && hairscale <= 0.17){
			return "moderately long";
		}	else if (hairscale > 0.17 && hairscale <= 0.2){
			if (rand(2) == 0) return "long";
			else return "shoulder-length";
		}	else if (hairscale > 0.2 && hairscale <= 0.25){
			return "very long";
		}	else if (hairscale > 0.25 && hairscale <= 0.4){
			return "back-covering";
		}	else if (hairscale > 0.4 && hairscale <= 0.5){
			return "ass-length";
		}	else if (hairscale > 0.5 && hairscale <= 1){
			return "obscenely long, "
		}	else if (hairscale > 1 ){
			return "floor-length";
		}

		return "";
	}

	public static function ignoresStyle (creature: *): Boolean {
		const id: int = creature.hairType;

		return Types[id].ignoresStyle || false;
	}
}
}
