package classes.BodyParts {
import classes.internals.EnumValue;

public class RearBody extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "DRACONIC_MANE")
	 * - name: human-readable default name, ("none", "draconic hairy mane")
	 * - plural: true/false, is the name plural ("behemoth spikes") or not ("shark fin")
	 */
	public static var Types:/*EnumValue*/Array = [];
	
	public static const NONE:int				= 0;
	EnumValue.add(Types, NONE, "NONE", {name: "none"});
	public static const DRACONIC_MANE:int		= 1;
	EnumValue.add(Types, DRACONIC_MANE, "DRACONIC_MANE", {name: "draconic hairy mane"});
	public static const DRACONIC_SPIKES:int		= 2;
	EnumValue.add(Types, DRACONIC_SPIKES, "DRACONIC_SPIKES", {name: "draconic spiky mane"});
	public static const FENRIR_ICE_SPIKES:int	= 3;
	EnumValue.add(Types, FENRIR_ICE_SPIKES, "FENRIR_ICE_SPIKES", {name: "ice shards", plural: true});
	public static const LION_MANE:int			= 4;
	EnumValue.add(Types, LION_MANE, "LION_MANE", {name: "lion mane"});
	public static const BEHEMOTH:int			= 5;
	EnumValue.add(Types, BEHEMOTH, "BEHEMOTH", {name: "behemoth spikes", plural: true});
	public static const SHARK_FIN:int			= 6;
	EnumValue.add(Types, SHARK_FIN, "SHARK_FIN", {name: "shark fin"});
	public static const ORCA_BLOWHOLE:int		= 7;
	EnumValue.add(Types, ORCA_BLOWHOLE, "ORCA_BLOWHOLE", {name: "orca blowhole"});
	public static const RAIJU_MANE:int			= 8;
	EnumValue.add(Types, RAIJU_MANE, "RAIJU_MANE", {name: "raiju mane"});
	public static const BAT_COLLAR:int			= 9;
	EnumValue.add(Types, BAT_COLLAR, "BAT_COLLAR", {name: "bat collar"});
	public static const WOLF_COLLAR:int			= 10;
	EnumValue.add(Types, WOLF_COLLAR, "WOLF_COLLAR", {name: "wolf collar"});
	public static const DISPLACER_TENTACLES:int	= 11;
	EnumValue.add(Types, DISPLACER_TENTACLES, "DISPLACER_TENTACLES", {name: "displacer tentacles", plural: true});
	public static const SNAIL_SHELL:int			= 12;
	EnumValue.add(Types, SNAIL_SHELL, "SNAIL_SHELL", {name: "snail shell"});
	public static const METAMORPHIC_GOO:int		= 13;
	EnumValue.add(Types, METAMORPHIC_GOO, "METAMORPHIC_GOO", {name: "metamorphic goo"});
	//public static const thundermantisrearbody:int		= 14;//button 0 on 2nd page of metamorph
	public static const GHOSTLY_AURA:int		= 15;
	EnumValue.add(Types, GHOSTLY_AURA, "GHOSTLY_AURA", {name: "ghostly aura"});
	public static const YETI_FUR:int			= 16;
	EnumValue.add(Types, YETI_FUR, "YETI_FUR", {name: "yeti fur"});
	public static const GLACIAL_AURA:int		= 17;
	EnumValue.add(Types, GLACIAL_AURA, "GLACIAL_AURA", {name: "glacial aura"});
	public static const CENTIPEDE:int			= 18;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {name: "centipede rear"});
	public static const KRAKEN:int				= 19;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {name: "kraken rear"});
	public static const FROSTWYRM:int			= 20;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {name: "frostwyrm rear"});
	public static const FUR_COAT:int			= 21;
	EnumValue.add(Types, FUR_COAT, "FUR_COAT", {name: "fur coat"});
	public static const TENTACLE_EYESTALKS:int	= 22;
	EnumValue.add(Types, TENTACLE_EYESTALKS, "TENTACLE_EYESTALKS", {name: "tentacle eyestalks", plural: true});
	public static const ATLACH_NACHA:int		= 23;
	EnumValue.add(Types, ATLACH_NACHA, "ATLACH_NACHA", {name: "Atlach Nacha rear"});
	
	public function RearBody() {
		super(null, null);
	}
}
}
