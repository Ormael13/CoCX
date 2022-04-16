package classes.BodyParts {
import classes.internals.EnumValue;
import classes.StatusEffects;
import classes.PerkLib;

public class RearBody extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "FENRIR_ICE_SPIKES")
	 * - name: human-readable default name, ("none", "draconic hairy mane")
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - plural: true/false, is the name plural ("behemoth spikes") or not ("shark fin")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE: int = 0;
	EnumValue.add(Types, NONE, "NONE", {
		name: "none"
	});
	public static const DRACONIC_MANE: int = 1;
	EnumValue.add(Types, DRACONIC_MANE, "DRACONIC_MANE", {
		name: "draconic hairy mane"
	});
	public static const DRACONIC_SPIKES: int = 2;
	EnumValue.add(Types, DRACONIC_SPIKES, "DRACONIC_SPIKES", {
		name: "draconic spiky mane"
	});
	public static const FENRIR_ICE_SPIKES: int = 3;
	EnumValue.add(Types, FENRIR_ICE_SPIKES, "FENRIR_ICE_SPIKES", {
		name: "ice shards",
		appearanceDesc: "Jagged ice shards grows out of your back, providing excellent defence and chilling the air around you.",
		plural: true
	});
	public static const LION_MANE: int = 4;
	EnumValue.add(Types, LION_MANE, "LION_MANE", {
		name: "lion mane",
		appearanceDesc: "Around your neck there is a thick mane of [skin coat.color] fur. It looks great on you."
	});
	public static const BEHEMOTH: int = 5;
	EnumValue.add(Types, BEHEMOTH, "BEHEMOTH", {
		name: "behemoth spikes",
		plural: true
	});
	public static const SHARK_FIN: int = 6;
	EnumValue.add(Types, SHARK_FIN, "SHARK_FIN", {
		name: "shark fin",
		appearanceDesc: "A large shark-like fin has sprouted between your shoulder blades. With it you have far more control over swimming underwater."
	});
	public static const ORCA_BLOWHOLE: int = 7;
	EnumValue.add(Types, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {
		name: "orca blowhole",
		appearanceDesc: "Between your shoulder blades is a blowhole that allows to breath in air from your back while swimming, just like an orca."
	});
	public static const RAIJU_MANE: int = 8;
	EnumValue.add(Types, RAIJU_MANE, "RAIJU_MANE", {
		name: "raiju mane",
		appearanceDesc: "A thick collar of fur grows around your neck. Multiple strands of fur are colored in a dark shade, making it look like a lightning bolt runs along the center of your fur collar."
	});
	public static const BAT_COLLAR: int = 9;
	EnumValue.add(Types, BAT_COLLAR, "BAT_COLLAR", {
		name: "bat collar",
		appearanceDesc: "Around your neck is a thick collar of fur reminiscent of a bat's."
	});
	public static const WOLF_COLLAR: int = 10;
	EnumValue.add(Types, WOLF_COLLAR, "WOLF_COLLAR", {
		name: "wolf collar",
		appearanceDesc: "Around your neck, there is a thick coat of [skin coat.color] fur. It looks great on you. That said, you can dismiss every one of your bestial features at any time should the need arise for you to appear human."
	});
	public static const DISPLACER_TENTACLES: int = 11;
	EnumValue.add(Types, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {
		name: "displacer tentacles",
		appearanceDesc: "On your back grows two tentacles with a pair of thick, heavy feelers. You use them to suck your victims dry of their milk loads as you pump them full of your lewd venom.",
		plural: true
	});
	public static const SNAIL_SHELL: int = 12;
	EnumValue.add(Types, SNAIL_SHELL, "SNAIL_SHELL", {
		name: "snail shell",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "On your back is a large spiralling shell which" + (player.hasPerk(PerkLib.FireAffinity)?" erupts regularly with magma and":"") + " protects your vital organs.";

			return desc;
		}
	});
	public static const METAMORPHIC_GOO: int = 13;
	EnumValue.add(Types, METAMORPHIC_GOO, "METAMORPHIC_GOO", {
		name: "metamorphic goo",
		appearanceDesc: "Since your body is made of malleable goo you can reshape your form however you want to gain tentacle or any limb or appendage whenever you need one either for combat or for fun."
	});
	//public static const thundermantisrearbody: int = 14;//button 0 on 2nd page of metamorph
	public static const GHOSTLY_AURA: int = 15;
	EnumValue.add(Types, GHOSTLY_AURA, "GHOSTLY_AURA", {
		name: "ghostly aura",
		appearanceDesc: "An eerie ghostly aura surrounds you. Your ominous presence is enough to disturb even the bravest of souls."
	});
	public static const YETI_FUR: int = 16;
	EnumValue.add(Types, YETI_FUR, "YETI_FUR", {
		name: "yeti fur",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "Covered with a natural "+(player.biggestTitSize() > 1 ? "fur bikini":"layer of fur")+", your "+(player.biggestTitSize() > 1 ? "chest and ":"")+"crotch is protected against the cold.";

			return desc;
		}
	});
	public static const GLACIAL_AURA: int = 17;
	EnumValue.add(Types, GLACIAL_AURA, "GLACIAL_AURA", {
		name: "glacial aura",
		appearanceDesc: "The air temperature around you naturally drops to water freezing levels, causing snow flurries to appear around you every now and then as moisture enters your personal space."
	});
	public static const CENTIPEDE: int = 18;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
		name: "centipede rear",
		appearanceDesc: "Around your neck sits a set of pincer like maxillipeds. You can use them to sting and hold onto your prey."
	});
	public static const KRAKEN: int = 19;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {
		name: "kraken rear",
		appearanceDesc: "Small glowing dots draw a trail all over the length of your body. They shine beautifully in both the deepest waters and the night giving you a somewhat ominous presence."
	});
	public static const FROSTWYRM: int = 20;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name: "frostwyrm rear",
		appearanceDesc: "Around your neck there is a thick collar of snowy white fur. It looks great on you and, best of all, shields you against the cold."
	});
	public static const FUR_COAT: int = 21;
	EnumValue.add(Types, FUR_COAT, "FUR_COAT", {
		name: "fur coat",
		appearanceDesc: "On your back you wear a thick fur coat, not unlike a mantle complete with a hood always worn over your head it has a pair of holes just to let a pair of horns or rather antlers juts through it."
	});
	public static const TENTACLE_EYESTALKS: int = 22;
	EnumValue.add(Types, TENTACLE_EYESTALKS, "TENTACLE_EYESTALKS", {
		name: "tentacle eyestalks",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A set of " + player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) + " tentacle eyestalks expand from your back giving you all around vision. Their gazes are charged with lethal magical powers.";

			return desc;
		},
		plural: true
	});
	public static const ATLACH_NACHA: int = 23;
	EnumValue.add(Types, ATLACH_NACHA, "ATLACH_NACHA", {
		name: "Atlach Nacha rear",
		appearanceDesc: "Two pairs of chitinous, black spider legs sprout from your shoulders and back. Red eyes blink and close at the tips."
	});
	public static const MINDBREAKER: int = 24;
	EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
		name: "Mindbreaker rear",
		appearanceDesc: "On your back spreads a webbed leather membrane, which from afar may look like a cape."
	});

	public static const COBRA_HOOD: int = 25;
	EnumValue.add(Types, COBRA_HOOD, "COBRA_HOOD", {
		name:"cobra hood",
		appearanceDescFunc: function(player: *): String {
			var desc: String = " Behind your hair is a large cobra hood decorated with intimating red triangular patterns.";
			if (player.faceType == Face.SNAKE_FANGS) desc += " Anyone can tell just from the vibrant colors that you are highly venomous.";
			return desc;
		}
	});

	public function RearBody() {
		super(null, null);
	}

	public static function getAppearanceDescription(player: *):String {
		const id: int = player.rearBody.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
	}


	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
