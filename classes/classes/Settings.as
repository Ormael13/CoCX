package classes {
import classes.GlobalFlags.kFLAGS;
import classes.internals.SaveableState;
import classes.internals.Utils;

public class Settings extends Utils implements SaveableState {

	// Gameplay & QoL
	public var autoLevel: int = 0; // 1 if automatic leveling is enabled.
	public var lvlUpFast: int = 0; //Bulk/Manual Incremental/Singular Levelling
	public var mutationsSpoiler: int = 0; //Mutations Help.
	public var daysPerYear: int = 0;
	// UI
	public var backgroundStyle: int = 0; // Background theme.
	public var buttonIconsDisabled: int = 0;
	public var charviewArmorHidden: int = 0;
	public var charviewEnabled: int = 0;
	public var charviewModel: int = 0; //0 is old charviewer model, 1 is new one
	public var charviewStyle: int = 0; // 0 for in text, 1 for sidebar, 2 for sidebar always visible
	public var customFontSize: int = 0;
	public var exploreMenuStyle: int = 0;
	public var hpStatbarPercentage: int = 0; //HP bars show a percentage rather than the core number
	public var imagepackOff: int = 0; // 1 if imagepack is disabled.
	public var imdbDetails: int = 0; // Internal mutation display switch
	public var invtMgmgType: int = 0; //Toggles Inventory Management type between existing and new.
	public var lustStatbarPercentage: int = 0; //Lust bars show a percentage rather than the core number
	public var newPerksDisplay: int = 0; //Perks Display cleanup
	public var spritesOff: Boolean = false; // Sprites off? toggle
	public var spriteStyle: int = 0; // 1 if old sprites are used.
	public var statbarAnimations: int = 0;
	public var use12hours: int = 0; // 0 for 24-hour format, 1 for 12-hour format.
	public var useMetrics: int = 0; // No longer used. Previously: 0 for imperial, 1 for metric.
	public var useOldFont: int = 0;
	public var ussDisplayStyle: int = 0;
	public var wrathStatbarPercentage: int = 0;  //Wrath bars show a percentage rather than the core number

	public function Settings() {
		// do not register - it is manually saved & loaded in Saves.as
//		Saves.registerSaveableState(this);
	}

	public function copyFrom(s:Settings):void {
		loadFromObject(s.saveToObject(), true);
	}

	public function stateObjectName():String {
		return "Settings";
	}

	public function resetState():void {
		autoLevel = 0;
		lvlUpFast = 0;
		mutationsSpoiler = 0;
		daysPerYear = 0;
		backgroundStyle = 0;
		buttonIconsDisabled = 0;
		charviewArmorHidden = 0;
		charviewEnabled = 0;
		charviewModel = 0;
		charviewStyle = 0;
		customFontSize = 0;
		exploreMenuStyle = 0;
		hpStatbarPercentage = 0;
		imagepackOff = 0;
		imdbDetails = 0;
		invtMgmgType = 0;
		lustStatbarPercentage = 0;
		newPerksDisplay = 0;
		spritesOff = false;
		spriteStyle = 0;
		statbarAnimations = 0;
		use12hours = 0;
		useMetrics = 0;
		useOldFont = 0;
		ussDisplayStyle = 0;
		wrathStatbarPercentage = 0;
	}

	public function saveToObject():Object {
		// Do not reorder. Add new options to the end
		// Order must match loadFromObject
		return {
			options: [
				autoLevel,
				lvlUpFast,
				mutationsSpoiler,
				daysPerYear,
				backgroundStyle,
				buttonIconsDisabled,
				charviewArmorHidden,
				charviewEnabled,
				charviewModel,
				charviewStyle,
				customFontSize,
				exploreMenuStyle,
				hpStatbarPercentage,
				imagepackOff,
				imdbDetails,
				invtMgmgType,
				lustStatbarPercentage,
				newPerksDisplay,
				spritesOff,
				spriteStyle,
				statbarAnimations,
				use12hours,
				useMetrics,
				useOldFont,
				ussDisplayStyle,
				wrathStatbarPercentage
			]
		};
	}
	public function importFromFlags(flags:DefaultDict):void {
		autoLevel = flags[kFLAGS.AUTO_LEVEL];
		lvlUpFast = flags[kFLAGS.LVL_UP_FAST];
		mutationsSpoiler = flags[kFLAGS.MUTATIONS_SPOILERS];
		daysPerYear = flags[kFLAGS.DAYS_PER_YEAR];
		backgroundStyle = flags[kFLAGS.BACKGROUND_STYLE];
		buttonIconsDisabled = flags[kFLAGS.BUTTON_ICONS_DISABLED];
		charviewArmorHidden = flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN];
		charviewEnabled = flags[kFLAGS.CHARVIEWER_ENABLED];
		charviewModel = flags[kFLAGS.CHARVIEWER_MODEL];
		charviewStyle = flags[kFLAGS.CHARVIEW_STYLE];
		customFontSize = flags[kFLAGS.CUSTOM_FONT_SIZE];
		exploreMenuStyle = flags[kFLAGS.EXPLORE_MENU_STYLE];
		hpStatbarPercentage = flags[kFLAGS.HP_STATBAR_PERCENTAGE];
		imagepackOff = flags[kFLAGS.IMAGEPACK_OFF];
		imdbDetails = flags[kFLAGS.IMDB_DETAILS];
		invtMgmgType = flags[kFLAGS.INVT_MGMT_TYPE];
		lustStatbarPercentage = flags[kFLAGS.LUST_STATBAR_PERCENTAGE];
		newPerksDisplay = flags[kFLAGS.NEWPERKSDISPLAY];
		spritesOff = flags[kFLAGS.SHOW_SPRITES_FLAG];
		spriteStyle = flags[kFLAGS.SPRITE_STYLE];
		statbarAnimations = flags[kFLAGS.STATBAR_ANIMATIONS];
		use12hours = flags[kFLAGS.USE_12_HOURS];
		useMetrics = flags[kFLAGS.USE_METRICS];
		useOldFont = flags[kFLAGS.USE_OLD_FONT];
		ussDisplayStyle = flags[kFLAGS.USSDISPLAY_STYLE];
		wrathStatbarPercentage = flags[kFLAGS.WRATH_STATBAR_PERCENTAGE];
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (!o || !(o.options is Array)) {
			resetState();
			importFromFlags(CoC.instance.flags);
			return;
		}
		var options:Array = o.options;
		var i:int = 0;
		// Do not reorder. Add new options to the end.
		// Order must match saveToObject
		autoLevel = valueOr(options[i++], 0);
		lvlUpFast = valueOr(options[i++], 0);
		mutationsSpoiler = valueOr(options[i++], 0);
		daysPerYear = valueOr(options[i++], 0);
		backgroundStyle = valueOr(options[i++], 0);
		buttonIconsDisabled = valueOr(options[i++], 0);
		charviewArmorHidden = valueOr(options[i++], 0);
		charviewEnabled = valueOr(options[i++], 0);
		charviewModel = valueOr(options[i++], 0);
		charviewStyle = valueOr(options[i++], 0);
		customFontSize = valueOr(options[i++], 0);
		exploreMenuStyle = valueOr(options[i++], 0);
		hpStatbarPercentage = valueOr(options[i++], 0);
		imagepackOff = valueOr(options[i++], 0);
		imdbDetails = valueOr(options[i++], 0);
		invtMgmgType = valueOr(options[i++], 0);
		lustStatbarPercentage = valueOr(options[i++], 0);
		newPerksDisplay = valueOr(options[i++], 0);
		spritesOff = valueOr(options[i++], false);
		spriteStyle = valueOr(options[i++], 0);
		statbarAnimations = valueOr(options[i++], 0);
		use12hours = valueOr(options[i++], 0);
		useMetrics = valueOr(options[i++], 0);
		useOldFont = valueOr(options[i++], 0);
		ussDisplayStyle = valueOr(options[i++], 0);
		wrathStatbarPercentage = valueOr(options[i++], 0);
	}
}
}
