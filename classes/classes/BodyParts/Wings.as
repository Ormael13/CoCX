package classes.BodyParts {
import classes.internals.EnumValue;

public class Wings extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (1, 4)
	 * - id: name of the constant ("BEE_LIKE_SMALL", "HARPY")
	 * - name: short human-readable default name, ("small bee-like", "harpy")
	 * - wingSlap:
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE:int                 = 0;
	EnumValue.add(Types, NONE, "NONE", {name:"non-existant"});
	public static const BEE_LIKE_SMALL:int       = 1;
	EnumValue.add(Types, BEE_LIKE_SMALL, "BEE_LIKE_SMALL", {name:"small bee-like"});
	public static const BEE_LIKE_LARGE:int       = 2;
	EnumValue.add(Types, BEE_LIKE_LARGE, "BEE_LIKE_LARGE", {name:"large bee-like",canFly: true});
	//unused yet nr 3 wing type
	public static const HARPY:int                = 4;
	EnumValue.add(Types, HARPY, "HARPY", {name:"harpy", wingSlap: true,canFly: true});
	public static const IMP:int                  = 5;//not used for PC - can change it with some new wing type
	EnumValue.add(Types, IMP, "IMP", {name:"imp"});
	public static const BAT_LIKE_TINY:int        = 6;
	EnumValue.add(Types, BAT_LIKE_TINY, "BAT_LIKE_TINY", {name:"tiny bat-like"});
	public static const BAT_LIKE_LARGE:int       = 7;
	EnumValue.add(Types, BAT_LIKE_LARGE, "BAT_LIKE_LARGE", {name:"large bat-like", wingSlap: true,canFly: true});
	public static const SHARK_FIN:int            = 8;//not longer used so not count
	EnumValue.add(Types, SHARK_FIN, "SHARK_FIN", {name:"shark fin"});
	public static const FEATHERED_LARGE:int      = 9;
	EnumValue.add(Types, FEATHERED_LARGE, "FEATHERED_LARGE", {name:"large feathered", wingSlap: true,canFly: true});
	public static const DRACONIC_SMALL:int       = 10;
	EnumValue.add(Types, DRACONIC_SMALL, "DRACONIC_SMALL", {name:"small draconic"});
	public static const DRACONIC_LARGE:int       = 11;
	EnumValue.add(Types, DRACONIC_LARGE, "DRACONIC_LARGE", {name:"large draconic", wingSlap: true,canFly: true});
	public static const GIANT_DRAGONFLY:int      = 12;
	EnumValue.add(Types, GIANT_DRAGONFLY, "GIANT_DRAGONFLY", {name:"giant dragonfly",canFly: true});
	public static const BAT_LIKE_LARGE_2:int     = 13;
	EnumValue.add(Types, BAT_LIKE_LARGE_2, "BAT_LIKE_LARGE_2", {name:"two large pairs of bat-like", wingSlap: true,canFly: true});
	public static const DRACONIC_HUGE:int        = 14;
	EnumValue.add(Types, DRACONIC_HUGE, "DRACONIC_HUGE", {name:"large majestic draconic", wingSlap: true,canFly: true});
	public static const FEATHERED_PHOENIX:int    = 15;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, FEATHERED_PHOENIX, "FEATHERED_PHOENIX", {name:"phoenix", wingSlap: true,canFly: true});
	public static const FEATHERED_ALICORN:int    = 16;
	EnumValue.add(Types, FEATHERED_ALICORN, "FEATHERED_ALICORN", {name:"alicorn", wingSlap: true,canFly: true});
	public static const MANTIS_LIKE_SMALL:int    = 17;
	EnumValue.add(Types, MANTIS_LIKE_SMALL, "MANTIS_LIKE_SMALL", {name:"small mantis-like"});
	public static const MANTIS_LIKE_LARGE:int    = 18;
	EnumValue.add(Types, MANTIS_LIKE_LARGE, "MANTIS_LIKE_LARGE", {name:"large mantis-like",canFly: true});
	public static const MANTIS_LIKE_LARGE_2:int  = 19;
	EnumValue.add(Types, MANTIS_LIKE_LARGE_2, "MANTIS_LIKE_LARGE_2", {name:"two large pairs of mantis-like",canFly: true});
	public static const GARGOYLE_LIKE_LARGE:int  = 20;
	EnumValue.add(Types, GARGOYLE_LIKE_LARGE, "GARGOYLE_LIKE_LARGE", {name:"large stony", wingSlap: true,canFly: true});
	public static const PLANT:int                = 21;
	EnumValue.add(Types, PLANT, "PLANT", {name:"three pairs of cockvines"});
	public static const MANTICORE_LIKE_SMALL:int = 22;
	EnumValue.add(Types, MANTICORE_LIKE_SMALL, "MANTICORE_LIKE_SMALL", {name:"small manticore-like"});
	public static const MANTICORE_LIKE_LARGE:int = 23;
	EnumValue.add(Types, MANTICORE_LIKE_LARGE, "MANTICORE_LIKE_LARGE", {name:"large manticore-like", wingSlap: true,canFly: true});
	// Deprecated, became an Arms body part
	public static const BAT_ARM:int              = 24;
	EnumValue.add(Types, BAT_ARM, "BAT_ARM", {name:"bat", wingSlap: true,canFly: true});
	public static const VAMPIRE:int              = 25;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {name:"large bat", wingSlap: true,canFly: true});
	public static const FEY_DRAGON_WINGS:int     = 26;
	EnumValue.add(Types, FEY_DRAGON_WINGS, "FEY_DRAGON_WINGS", {name:"large majestic fey draconic", wingSlap: true,canFly: true});
	public static const FEATHERED_AVIAN:int      = 27;
	EnumValue.add(Types, FEATHERED_AVIAN, "FEATHERED_AVIAN", {name:"avian", wingSlap: true,canFly: true});
	public static const NIGHTMARE:int    		 = 28;
	EnumValue.add(Types, NIGHTMARE, "NIGHTMARE", {name:"leathery", wingSlap: true,canFly: true});
	public static const FEATHERED_SPHINX:int     = 29;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, FEATHERED_SPHINX, "FEATHERED_SPHINX", {name:"sphinx", wingSlap: true,canFly: true});
	public static const ETHEREAL_WINGS:int    	 = 30;
	EnumValue.add(Types, ETHEREAL_WINGS, "ETHEREAL_WINGS", {name:"ethereal tendrils",canFly: true});
	public static const THUNDEROUS_AURA:int    	 = 31;
	EnumValue.add(Types, THUNDEROUS_AURA, "THUNDEROUS_AURA", {name:"thunderous aura",canFly: true});
	public static const LEVITATION:int    		 = 32;
	EnumValue.add(Types, LEVITATION, "LEVITATION", {name:"non-existant",canFly: true});
	public static const DEVILFEATHER:int       	 = 33;
	EnumValue.add(Types, DEVILFEATHER, "DEVILFEATHER", {name:"devil",canFly: true});
	public static const FAIRY:int     			 = 34;
	EnumValue.add(Types, FAIRY, "FAIRY", {name:"fairy",canFly: true});
	public static const WINDY_AURA:int    	 	 = 35;
	EnumValue.add(Types, WINDY_AURA, "WINDY_AURA", {name:"windy aura",canFly: true});
	public static const SEADRAGON:int        = 36;
	EnumValue.add(Types, SEADRAGON, "SEADRAGON", {name:"large majestic aquatic", wingSlap: true,canFly: true});
	//public static const :int    	 	 	 = 36;
	//EnumValue.add(Types, , "", {name:"",canFly: true});

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
}
}
