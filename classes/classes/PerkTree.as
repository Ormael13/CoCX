/**
 * Created by aimozg on 22.05.2017.
 */
package classes {
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.GlobalFlags.kGAMECLASS;

import flash.utils.Dictionary;

public class PerkTree extends BaseContent {
	private var pdata:Dictionary = new Dictionary();

	public function PerkTree() {
		var library:Dictionary = PerkType.getPerkLibrary();
		var perk:PerkType;
		for each(perk in library) {
			//var perk:PerkType = library[k];
			pdata[perk.id] = {
				perk   : perk,
				ctxt   : perk.allRequirementDesc(),
				unlocks: []
			};
		}
		for each(perk in library) {
			for each (var c:Object in perk.requirements) {
				switch (c.type) {
					case "perk":
						var p2:PerkType = c.perk;
						pdata[p2.id].unlocks.push(perk);
						break;
					case "anyperk":
						var ps:Array = c.perks;
						for each(p2 in ps) pdata[p2.id].unlocks.push(perk);
						break;
				}
			}
		}
		/*for each(var pd:Object in pdata) {
			var s:Array = [];
			for each (perk in pd.unlocks) s.push(perk.name);
			if (s.length>0 || pd.ctxt) trace("Perk " + pd.perk.name + (pd.ctxt ? "; requires " + pd.ctxt : "") + (s.length > 0 ? "; unlocks " + s.join(", ") : ""));
		}*/
	}
	/**
	 * Returns Array of PerkType
	 */
	public function listUnlocks(p:PerkType):Array {
		return pdata[p.id].unlocks;
	}
	/**
	 * Returns Array of PerkType
	 */
	public static function obtainablePerks():Array {
		var rslt:Array=[];
		for each(var perk:PerkType in PerkType.getPerkLibrary()) {
			if (perk.requirements.length > 0) {
				rslt.push(perk);
			}
		}
		return rslt.sortOn("name");
	}
	/**
	 * Returns Array of PerkType
	 */
	public static function availablePerks(player:Player):Array {
		return obtainablePerks().filter(
				function (perk:PerkType,idx:int,array:Array):Boolean {
					return !player.hasPerk(perk) && perk.available(player);
				});
	}
}
}
