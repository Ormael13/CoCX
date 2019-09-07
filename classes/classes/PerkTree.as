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

	private static function treeHints():* {
		return {
			roots: [
				PerkLib.JobArcaneArcher,
				PerkLib.JobBarbarian,
				PerkLib.JobBeastWarrior,
				PerkLib.JobBrawler,
				PerkLib.JobCourtesan,
				PerkLib.JobDervish,
				PerkLib.JobElementalConjurer,
				PerkLib.JobEnchanter,
				PerkLib.JobEromancer,
				PerkLib.JobKnight,
				PerkLib.JobMonk,
				PerkLib.JobGolemancer,
				PerkLib.JobGuardian,
				PerkLib.JobRanger,
				PerkLib.JobSeducer,
				PerkLib.JobSorcerer,
				PerkLib.JobSoulCultivator,
				PerkLib.JobSwordsman,
				PerkLib.JobWarlord,
				PerkLib.JobWarrior,
				PerkLib.PrestigeJobArcaneArcher,
				PerkLib.PrestigeJobBerserker,
				PerkLib.PrestigeJobNecromancer,
				PerkLib.PrestigeJobSeer,
				PerkLib.PrestigeJobSentinel,
				PerkLib.PrestigeJobSoulArcher,
				PerkLib.PrestigeJobSoulArtMaster,
				PerkLib.PrestigeJobTempest,
			],
			stops: [
				// PerkLib.JobAllRounder
			]
		}
	}

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
				switch (c.type) {
					case "perk":
						var p2:PerkType = c.perk;
						(pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
					case "anyperk":
						var ps:Array = c.perks;
						for each(p2 in ps) (pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
				}
			}
		}
		// Build tiers
		var hints:* = treeHints();
		var q:/*PerkTreeEntry*/Array = []; //< processing queue
		for each(perk in hints.roots) {
			entry       = pdata[perk.id];
			entry.depth = 0;
			entry.tiers = [[]];
			entry.roots = [entry];
			q.push(entry);
		}
		// 2. Calculate depth, tier, and roots
		while (q.length>0) {
			var parent:PerkTreeEntry = q.shift();
			var root:PerkTreeEntry = pdata[parent.roots[0].perk.id];
			for each(var child:PerkTreeEntry in parent.unlocks) {
				if (child.depth == 0
					&& hints.roots.indexOf(child.perk) < 0
					&& hints.stops.indexOf(child.perk) < 0) {
					q.push(child);
				}
				child.depth = Math.max(child.depth,parent.depth + 1);
				child.tier = perkTier(child,parent);
				if (root!=child) child.roots.push(root);
			}
		}
		// 3. Put tiers in their roots' arrays
		for each(entry in pdata) {
			if (entry.roots.length == 0) continue;
			for each(root in entry.roots) {
				while (!(root.tiers[entry.tier])) root.tiers.push([]);
				if (root.tiers[entry.tier].indexOf(entry)<0) root.tiers[entry.tier].push(entry);
			}
		}
		for each(perk in hints.roots) {
			entry = pdata[perk.id];
			var ss:/*String*/Array = [];
			for each (root in entry.roots) if (root!=entry) ss.push(root.perk.name);
			if (ss.length>0) {
				trace('Tree for '+entry.perk.name+ ' (Tier '+entry.tier+' '+ss.join(', ')+' perk)');
			} else {
				trace('Tree for '+entry.perk.name);
			}
			for (var i:int = 1; i < entry.tiers.length; i++) {
				ss = [];
				for each(child in entry.tiers[i]) {
					ss.push(child.perk.name);
				}
				if (ss.length>0) trace('  Tier ' + i + ' perks: '+ss.join(', '));
			}
		}
		/*for each(var pd:Object in pdata) {
			var s:Array = [];
			for each (perk in pd.unlocks) s.push(perk.name);
			if (s.length>0 || pd.ctxt) trace("Perk " + pd.perk.name + (pd.ctxt ? "; requires " + pd.ctxt : "") + (s.length > 0 ? "; unlocks " + s.join(", ") : ""));
		}*/
	}
	private static function perkTier(child:PerkTreeEntry, parent:PerkTreeEntry):int {
		var minlevel:int=1;
		var ngplus:int=0;
		for each (var rq:* in child.perk.requirements) {
			if (rq.type == 'level') minlevel = rq.value;
			else if(rq.type == 'ng+') ngplus = rq.value;
		}
		return Math.floor(Math.max(
				1,
				child.tier,
				parent.tier,
				child.depth / 6,
				minlevel / 6 + ngplus
		));
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
	public var ctxt:String;
	public var unlocks:/*PerkTreeEntry*/Array =[];
	public var depth:int                      =0;
	public var tier:int                       =0;
	public var tiers:/*PerkTreeEntry[]*/Array =[];
	public var roots:/*PerkTreeEntry*/Array   = [];

	public function PerkTreeEntry(perk:PerkType) {
		this.perk = perk;
		this.ctxt = perk.allRequirementDesc();
	}
}