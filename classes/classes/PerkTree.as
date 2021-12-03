/**
 * Created by aimozg on 22.05.2017.
 */
package classes {

import flash.utils.Dictionary;

public class PerkTree extends BaseContent {
	/*
	 perk.id => PerkTreeEntry
	 */
	private var pdata:Dictionary = new Dictionary();
	
	public function PerkTree() {
		var library:Dictionary = PerkType.getPerkLibrary();
		var perk:PerkType;
		// 0. Initialize PerkTreeEntries
		for each(perk in library) {
			//var perk:PerkType = library[k];
			pdata[perk.id] = new PerkTreeEntry(perk);
		}
		// 1. Build PerkTreeEntry.unlocks array - for every perk i, for every requirement j, add i to j.unlocks
		for each(perk in library) {
			var entry:PerkTreeEntry = pdata[perk.id];
			for each (var c:Object in perk.requirements) {
				var p2:PerkType;
				switch (c.type) {
					case "perk":
						p2 = c.perk;
						(pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
					case "anyperk":
						var ps:Array = c.perks;
						for each(p2 in ps) (pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
					case "allperks":
						var aps:Array = c.perks;
						for each(p2 in aps) (pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
				}
			}
		}
	}
	
	/**
	 * Returns Array of PerkType
	 */
	public function listUnlocks(p:PerkType):Array {
		return pdata[p.id].unlocks.map(function(entry:PerkTreeEntry,idx:int,array:/*PerkTreeEntry*/Array):PerkType {
			return entry.perk;
		});
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
	public static function availablePerks(player:Player):/*PerkType*/Array {
		return obtainablePerks().filter(
				function (perk:PerkType,idx:int,array:/*PerkType*/Array):Boolean {
					return !player.hasPerk(perk) && perk.available(player);
				});
	}
}
}

import classes.PerkType;

class PerkTreeEntry {
	public var perk:PerkType;
	public var unlocks:/*PerkTreeEntry*/Array =[];

	public function PerkTreeEntry(perk:PerkType) {
		this.perk = perk;
	}
}
