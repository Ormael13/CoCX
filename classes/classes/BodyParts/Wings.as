package classes.BodyParts {
import classes.internals.EnumValue;
import classes.CoC;
import classes.Scenes.NPCs.Forgefather;
import classes.GlobalFlags.kFLAGS;

public class Wings extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (1, 4)
	 * - id: name of the constant ("BEE_SMALL", "HARPY")
	 * - name: short human-readable default name, ("small bee-like", "harpy")
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 *
	 * - wingSlap: enables use of arms for wing slap
	 * - canFly: special arms type that enables flying even without wings
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE: int = 0;
	EnumValue.add(Types, NONE, "NONE", {
		name:"non-existant"
	});

	public static const BEE_SMALL: int = 1;
	EnumValue.add(Types, BEE_SMALL, "BEE_SMALL", {
		name:"small bee-like",
		appearanceDesc: "A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly."
	});

	public static const BEE_LARGE: int = 2;
	EnumValue.add(Types, BEE_LARGE, "BEE_LARGE", {
		name:"large bee-like",
		appearanceDesc: "A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.",
		canFly: true
	});

	public static const HARPY: int = 4;
	EnumValue.add(Types, HARPY, "HARPY", {
		name:"harpy",
		wingSlap: true,
		canFly: true
	});
	public static const IMP: int = 5;//not used for PC - can change it with some new wing type
	EnumValue.add(Types, IMP, "IMP", {
		name:"imp"
	});
	public static const BAT_LIKE_TINY: int = 6;
	EnumValue.add(Types, BAT_LIKE_TINY, "BAT_LIKE_TINY", {
		name:"tiny bat-like",
		appearanceDesc: "A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use."
	});
	public static const BAT_LIKE_LARGE: int = 7;
	EnumValue.add(Types, BAT_LIKE_LARGE, "BAT_LIKE_LARGE", {
		name:"large bat-like",
		appearanceDesc: "A pair of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.",
		wingSlap: true,
		canFly: true
	});
	public static const SHARK_FIN: int = 8;//not longer used so not count
	EnumValue.add(Types, SHARK_FIN, "SHARK_FIN", {
		name:"shark fin"
	});
	public static const FEATHERED_LARGE: int = 9;
	EnumValue.add(Types, FEATHERED_LARGE, "FEATHERED_LARGE", {
		name:"large feathered",
		appearanceDesc: "A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.",
		wingSlap: true,
		canFly: true
	});
	public static const DRACONIC_SMALL: int = 10;
	EnumValue.add(Types, DRACONIC_SMALL, "DRACONIC_SMALL", {
		name:"small draconic",
		appearanceDesc: "Small, vestigial wings sprout from your shoulders. They might look like bat's wings, but the membranes are covered in fine, delicate scales."
	});
	public static const DRACONIC_LARGE: int = 11;
	EnumValue.add(Types, DRACONIC_LARGE, "DRACONIC_LARGE", {
		name:"large draconic",
		appearanceDesc: "Large wings sprout from your shoulders. When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.",
		wingSlap: true,
		canFly: true
	});
	public static const GIANT_DRAGONFLY: int = 12;
	EnumValue.add(Types, GIANT_DRAGONFLY, "GIANT_DRAGONFLY", {
		name:"giant dragonfly",
		appearanceDesc: "Giant dragonfly wings hang from your shoulders. At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.",
		canFly: true
	});
	public static const BAT_LIKE_LARGE_2: int = 13;
	EnumValue.add(Types, BAT_LIKE_LARGE_2, "BAT_LIKE_LARGE_2", {
		name:"two large pairs of bat-like",
		appearanceDesc: "Two pairs of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.",
		wingSlap: true,
		canFly: true
	});
	public static const DRACONIC_HUGE: int = 14;
	EnumValue.add(Types, DRACONIC_HUGE, "DRACONIC_HUGE", {
		name:"large majestic draconic",
		appearanceDesc: "Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.",
		wingSlap: true,
		canFly: true
	});
	public static const FEATHERED_PHOENIX: int = 15;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, FEATHERED_PHOENIX, "FEATHERED_PHOENIX", {
		name:"phoenix",
		appearanceDesc: "A pair of large, feathery wings sprout from your back. Though you usually keep the crimson-colored wings folded close, they can unfurl to allow you to soar as gracefully as a phoenix.",
		wingSlap: true,
		canFly: true
	});
	public static const FEATHERED_ALICORN: int = 16;
	EnumValue.add(Types, FEATHERED_ALICORN, "FEATHERED_ALICORN", {
		name:"alicorn",
		appearanceDesc: "A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as an alicorn.",
		wingSlap: true,
		canFly: true
	});
	public static const MANTIS_SMALL: int = 17;
	EnumValue.add(Types, MANTIS_SMALL, "MANTIS_SMALL", {
		name:"small mantis-like",
		appearanceDesc: "A pair of tiny mantis-wings sprout from your back, too small to allow you to fly."
	});
	public static const MANTIS_LARGE: int = 18;
	EnumValue.add(Types, MANTIS_LARGE, "MANTIS_LARGE", {
		name:"large mantis-like",
		appearanceDesc: "A pair of large mantis-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.",
		canFly: true
	});
	public static const MANTIS_LARGE_2: int = 19;
	EnumValue.add(Types, MANTIS_LARGE_2, "MANTIS_LARGE_2", {
		name:"two large pairs of mantis-like",
		canFly: true
	});
	public static const GARGOYLE_LIKE_LARGE: int = 20;
	EnumValue.add(Types, GARGOYLE_LIKE_LARGE, "GARGOYLE_LIKE_LARGE", {
		name:"large stony",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";
			desc += " Large ";
			desc += Forgefather.material;
			desc += " wings sprout from your shoulders. When unfurled they stretch wider than your arm span and a single beat of them is all you need to set out toward the sky. They look a bit like ";
			if (Forgefather.wings == 1) desc += "bird";
			if (Forgefather.wings == 2) desc += "bat";
			desc += " wings and, although they were made of stone, they allow you to fly around with excellent aerial agility.";
			return desc;
		},
		wingSlap: true,
		canFly: true
	});
	public static const PLANT: int = 21;
	EnumValue.add(Types, PLANT, "PLANT", {
		name:"three pairs of cockvines",
		appearanceDesc: "Three pairs of oily, prehensile phalluses sprout from your shoulders and back. From afar, they may look like innocent vines, but up close, each tentacle contain a bulbous head with a leaking cum-slit, perfect for mass breeding."
	});
	public static const MANTICORE_SMALL: int = 22;
	EnumValue.add(Types, MANTICORE_SMALL, "MANTICORE_SMALL", {
		name:"small manticore-like",
		appearanceDesc: "A pair of small leathery wings covered with [skin coat.color] fur rest on your back. Despite being too small to allow flight they at least look cute on you."
	});
	public static const MANTICORE_LARGE: int = 23;
	EnumValue.add(Types, MANTICORE_LARGE, "MANTICORE_LARGE", {
		name:"large manticore-like",
		appearanceDesc: "A pair of large ominous leathery wings covered with [skin coat.color] fur expand from your back. You can open them wide to soar high in search of your next prey.",
		wingSlap: true,
		canFly: true
	});
	// Deprecated, became an Arms body part
	public static const BAT_ARM: int = 24;
	EnumValue.add(Types, BAT_ARM, "BAT_ARM", {
		name:"bat",
		wingSlap: true,
		canFly: true
	});
	public static const VAMPIRE: int = 25;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
		name:"large bat",
		appearanceDesc: "Between your shoulder blades rest a pair of large, ominous black wings reminiscent of a bat’s. They can unfurl up to twice your arm’s length, allowing you to gracefully dance in the night sky.",
		wingSlap: true,
		canFly: true
	});
	public static const FEY_DRAGON: int = 26;
	EnumValue.add(Types, FEY_DRAGON, "FEY_DRAGON", {
		name:"large majestic fey draconic",
		appearanceDesc: "Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone. While draconic in appearance the delicate frame of your fey like dragon wings allows for even better speed and maneuverability.",
		wingSlap: true,
		canFly: true
	});
	public static const FEATHERED_AVIAN: int = 27;
	EnumValue.add(Types, FEATHERED_AVIAN, "FEATHERED_AVIAN", {
		name:"avian",
		appearanceDesc: "A pair of large, feathery wings sprout from your back. Though you usually keep the [skin coat.color] wings folded close, they can unfurl to allow you to soar as gracefully as a bird.",
		wingSlap: true,
		canFly: true
	});
	public static const NIGHTMARE: int = 28;
	EnumValue.add(Types, NIGHTMARE, "NIGHTMARE", {
		name:"leathery",
		appearanceDesc: "A pair of large ominous black leathery wings expand from your back. You can open them wide to soar high in the sky.",
		wingSlap: true,
		canFly: true
	});
	public static const FEATHERED_SPHINX: int = 29;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, FEATHERED_SPHINX, "FEATHERED_SPHINX", {
		name:"sphinx",
		appearanceDesc: "A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a sphinx.",
		wingSlap: true,
		canFly: true
	});
	public static const ETHEREAL: int = 30;
	EnumValue.add(Types, ETHEREAL, "ETHEREAL", {
		name:"ethereal tendrils",
		appearanceDesc: "Three pairs of otherworldly tendrils grow out of your back. They have an ethereal glow around them and they gently sway against an invisible wind.",
		canFly: true
	});
	public static const THUNDEROUS_AURA: int = 31;
	EnumValue.add(Types, THUNDEROUS_AURA, "THUNDEROUS_AURA", {
		name:"thunderous aura",
		appearanceDesc: "You generate so much electricity that the sound of static and voltage follows you around, announcing your arrival.",
		canFly: true
	});
	public static const LEVITATION: int = 32;
	EnumValue.add(Types, LEVITATION, "LEVITATION", {
		name:"non-existant",
		appearanceDesc: "Although you don't have wings, you have the ability to levitate in the air should you wish to, though you usually prefer to stay at ground level.",
		canFly: true
	});
	public static const DEVILFEATHER: int = 33;
	EnumValue.add(Types, DEVILFEATHER, "DEVILFEATHER", {
		name:"devil",
		appearanceDesc: "A pair of large ominous black feathered wings expand from your back. You can open them wide to soar high in the sky.",
		canFly: true
	});
	public static const FAIRY: int = 34;
	EnumValue.add(Types, FAIRY, "FAIRY", {
		name:"fairy",
		appearanceDesc: "A large pair of colorful butterfly wings rest on your shoulder blades. Your fairy wings give you a regal appearance fit for fey royalty.",
		canFly: true
	});
	public static const WINDY_AURA: int = 35;
	EnumValue.add(Types, WINDY_AURA, "WINDY_AURA", {
		name:"windy aura",
		appearanceDesc: "An aura of strong wind constantly seems to accompany you wherever you go. You can use it to create tornados and even take flight riding on a dust devil should you need to.",
		canFly: true
	});
	public static const SEA_DRAGON: int = 36;
	EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
		name:"large majestic aquatic",
		appearanceDesc: "Two large majestic webbed wings not unlike the aquatic flippers of a deep-sea creature unfurls from your back, the interior lined with bright color patterns and bioluminescent specks that change depending on your mood. These wings are as good to fly as they are to swim.",
		wingSlap: true,
		canFly: true
	});

	public var desc:String = "non-existant";
	public function Wings() {
		super(creature, "wings", []);
	}

	override protected function loadFromOldSave(savedata:Object):void {
		// For the Arms to be properly replaced, in the loadGameObject function of Saves.as, player.wings.loadFromSaveData must be called *before* saveFile.data.armType is checked
		// Otherwise, the new savedata.armType won't be checked as the arm's type was already extracted from the save file
		if (savedata.wingType === BAT_ARM) {
			savedata.wingType = NONE;
			savedata.armType = Arms.BAT;
		}

		type = intOr(savedata.wingType, NONE);
	}

	public static function getAppearanceDescription(player: *):String {
		const id: int = player.wings.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
