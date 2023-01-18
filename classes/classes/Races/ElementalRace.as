package classes.Races {
import classes.BodyData;
import classes.Creature;
import classes.PerkLib;
import classes.Race;
import classes.internals.Utils;

public class ElementalRace extends Race {
	public function ElementalRace(id:int) {
		super("Elemental Fusion", id, [""]);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	override public function setup():void {
		
		addScores().hasPerk(PerkLib.ElementalBody, +5)
				.givePerkV2(PerkLib.ElementalBody);
		
		buildTier(6, "lesser elemental")
				.customNamingFunction(nameFn)
				.require("Elemental Body (lesser)", function (body:BodyData):Boolean {
					return body.player.perkv1(PerkLib.ElementalBody) == 1
				})
				.withDynamicBuffs("Element-dependent bonuses", calcBuffs)
				.end();
		buildTier(7, "adept elemental")
				.customNamingFunction(nameFn)
				.require("Elemental Body (adept)", function (body:BodyData):Boolean {
					return body.player.perkv1(PerkLib.ElementalBody) == 2
				})
				.withDynamicBuffs("Element-dependent bonuses", calcBuffs)
				.end();
		buildTier(8, "greater elemental")
				.customNamingFunction(nameFn)
				.require("Elemental Body (greater)", function (body:BodyData):Boolean {
					return body.player.perkv1(PerkLib.ElementalBody) == 3
				})
				.withDynamicBuffs("Element-dependent bonuses", calcBuffs)
				.end();
		buildTier(9, "primordial elemental")
				.customNamingFunction(nameFn)
				.require("Elemental Body (primordial)", function (body:BodyData):Boolean {
					return body.player.perkv1(PerkLib.ElementalBody) == 4
				})
				.withDynamicBuffs("Element-dependent bonuses", calcBuffs)
				.end();
	}
	
	public static const TierNames:Array = ["", "lesser", "adept", "greater", "primordial"];
	public static const ElementNames:Array = ["", "sylph", "gnome", "ignis", "undine"];
	
	public static const TIER1_LESSER:int = 1;
	public static const TIER2_ADEPT:int = 2;
	public static const TIER3_GREATER:int = 3;
	public static const TIER4_PRIMORDIAL:int = 4;
	
	public static const ELEMENT_SYLPH:int = 1;
	public static const ELEMENT_GNOME:int = 2;
	public static const ELEMENT_IGNIS:int = 3;
	public static const ELEMENT_UNDINE:int = 4;
	
	public static const SYLPH_1:int = 11;
	public static const SYLPH_2:int = 12;
	public static const SYLPH_3:int = 13;
	public static const SYLPH_4:int = 14;
	public static const GNOME_1:int = 21;
	public static const GNOME_2:int = 22;
	public static const GNOME_3:int = 23;
	public static const GNOME_4:int = 24;
	public static const IGNIS_1:int = 31;
	public static const IGNIS_2:int = 32;
	public static const IGNIS_3:int = 33;
	public static const IGNIS_4:int = 34;
	public static const UNDINE_1:int = 41;
	public static const UNDINE_2:int = 42;
	public static const UNDINE_3:int = 43;
	public static const UNDINE_4:int = 44;
	
	public static const BuffsDb:Object = {
		11: { // SYLPH_1
			"spe.mult": +1.00,
			"int.mult": +0.75,
			"wis.mult": +0.50
		},
		12: { // SYLPH_2
			"spe.mult": +1.25,
			"int.mult": +1.00,
			"wis.mult": +0.75
		},
		13: { // SYLPH_3
			"spe.mult": +1.50,
			"int.mult": +1.25,
			"wis.mult": +1.00
		},
		14: { // SYLPH_4
			"spe.mult": +1.75,
			"int.mult": +1.50,
			"wis.mult": +1.25
		},
		21: { // GNOME_1
			"tou.mult": +1.00,
			"wis.mult": +0.75,
			"str.mult": +0.50,
			"def": +10,
			"mdef": +10
		},
		22: { // GNOME_2
			"tou.mult": +1.25,
			"wis.mult": +1.00,
			"str.mult": +0.75,
			"def": +20,
			"mdef": +20
		},
		23: { // GNOME_3
			"tou.mult": +1.50,
			"wis.mult": +1.25,
			"str.mult": +1.00,
			"def": +30,
			"mdef": +30
		},
		24: { // GNOME_4
			"tou.mult": +1.75,
			"wis.mult": +1.50,
			"str.mult": +1.25,
			"def": +40,
			"mdef": +40
		},
		31: { // IGNIS_1
			"spe.mult": +1.00,
			"str.mult": +0.75,
			"wis.mult": +0.50
		},
		32: { // IGNIS_2
			"spe.mult": +1.25,
			"str.mult": +1.00,
			"wis.mult": +0.75
		},
		33: { // IGNIS_3
			"spe.mult": +1.50,
			"str.mult": +1.25,
			"wis.mult": +1.00
		},
		34: { // IGNIS_4
			"spe.mult": +1.75,
			"str.mult": +1.50,
			"wis.mult": +1.25
		},
		41: { // UNDINE_1
			"wis.mult": +1.00,
			"str.mult": +0.75,
			"tou.mult": +0.50,
			"def": +5,
			"mdef": +5
		},
		42: { // UNDINE_2
			"wis.mult": +1.25,
			"str.mult": +1.00,
			"tou.mult": +0.75,
			"def": +10,
			"mdef": +10
		},
		43: { // UNDINE_3
			"wis.mult": +1.50,
			"str.mult": +1.25,
			"tou.mult": +1.00,
			"def": +15,
			"mdef": +15
		},
		44: { // UNDINE_4
			"wis.mult": +1.75,
			"str.mult": +1.50,
			"tou.mult": +1.25,
			"def": +20,
			"mdef": +20
		}
	};
	
	/**
	 * @return one of `ELEMENT_XXXX` constants
	 */
	public static function getElement(creature:Creature):int {
		return creature.perkv1(PerkLib.ElementalBody);
	}
	
	/**
	 * @return one of `TIERX_YYYY` constants
	 */
	public static function getElementalTier(creature:Creature):int {
		return creature.perkv2(PerkLib.ElementalBody);
	}
	
	/**
	 * @return one of `ELEMENT_TIER` constants (`SYLPH_1`)
	 */
	public static function getElementAndTier(creature:Creature):int {
		return getElement(creature)*10 + getElementalTier(creature);
	}
	
	private function nameFn(body:BodyData):String {
		return TierNames[getElementalTier(body.player)]+" "+ElementNames[getElement(body.player)];
	}
	private function calcBuffs(body:BodyData):Object {
		// we copy the object because it's modified in the calling function
		return Utils.extend({}, BuffsDb[getElementAndTier(body.player)]);
	}
}
}
