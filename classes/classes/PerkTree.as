/**
 * Created by aimozg on 22.05.2017.
 */
package classes {

import flash.utils.Dictionary;

public class PerkTree extends BaseContent {
	/*
	 perk.id => PerkTreeEntry
	 */
	private static var pdata:Dictionary = new Dictionary();
	
	public function PerkTree() {
		var library:Dictionary = PerkType.getPerkLibrary();
		var perk:PerkType;
		var entry:PerkTreeEntry;
		var req:Object;
		// 0. Initialize PerkTreeEntries
		for each(perk in library) {
			//var perk:PerkType = library[k];
			entry = new PerkTreeEntry(perk);
			pdata[perk.id] = entry;
			if (perk.requirements.length > 0) perk.distance = PerkType.DISTANCE_STARTING;
			for each (req in perk.requirements) {
				// Starting perk distance
				if (req.distance is Number && !isNaN(req.distance)) perk.distance += req.distance;
			}
		}
		// 1. Build PerkTreeEntry.unlocks array - for every perk i, for every requirement j, add i to j.unlocks
		var processedIds:Object = {}; // processed perk ids
		var queue:/*PerkType*/Array = [];
		for each(perk in library) {
			entry = pdata[perk.id];
			var done:Boolean = true;
			for each (req in perk.requirements) {
				var p2:PerkType;
				switch (req.type) {
					case "perk":
						done = false;
						p2 = req.perk;
						(pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
					case "anyperk":
						done = false;
						var ps:Array = req.perks;
						for each(p2 in ps) (pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
					case "allperks":
						done = false;
						var aps:Array = req.allperks;
						for each(p2 in aps) (pdata[p2.id] as PerkTreeEntry).unlocks.push(entry);
						break;
				}
			}
			if (done) {
				processedIds[perk.id] = true;
				if (perk.requirements.length > 0) {
					perksByDistance.push(perk);
				}
			} else {
				queue.push(perk);
			}
		}
		// 2. Compute perk distance for perk/anyperk/allperks requirements
		while(queue.length > 0) {
			var oldSz:int = queue.length;
			for (var i:int = queue.length-1; i >= 0; i--) {
				perk = queue[i];
				entry = pdata[perk.id];
				done = true;
				for each (req in perk.requirements) {
					switch (req.type) {
						case "perk":
							p2 = req.perk;
							if (processedIds[p2.id]) {
								perk.distance = Math.max(perk.distance, p2.distance) + PerkType.DISTANCE_PER_PERK;
							} else {
								done = false;
							}
							break;
						case "anyperk":
							var mindist:Number = Infinity;
							for each(p2 in req.perks) {
								if (processedIds[p2.id]) {
									mindist = Math.min(mindist, p2.distance);
								} else {
									done = false;
									break;
								}
							}
							if (done && isFinite(mindist)) {
								perk.distance = Math.max(perk.distance, mindist) + PerkType.DISTANCE_PER_PERK;
							}
							break;
						case "allperks":
							var maxdist:Number = -Infinity;
							for each(p2 in req.allperks) {
								if (processedIds[p2.id]) {
									maxdist = Math.max(maxdist, p2.distance);
								} else {
									done = false;
									break;
								}
							}
							if (done && isFinite(maxdist)) {
								perk.distance = Math.max(perk.distance, maxdist) + PerkType.DISTANCE_PER_PERK * req.allperks.length;
							}
							break;
					}
				}
				if (done) {
					processedIds[perk.id] = true;
					perksByDistance.push(perk);
					// Remove i-th element: move last to i-th place and remove last
					queue[i] = queue[queue.length - 1];
					queue.pop();
				}
			}
			if (queue.length >= oldSz) {
				// Halt if queue was not changed
				trace("[ERROR] PerkTree distance calculation stuck in a loop: queue.length = "+queue.length);
				break;
			}
		}
		if (queue.length > 0) {
			trace("[ERROR] Failed to compute distance of perks:")
			for each (perk in queue) {
				trace("[ERROR]     "+perk.id);
			}
			trace("[ERROR]   (total "+queue.length+")");
		}
		queue = [];
		perksByDistance.sortOn(["distance","id"], Array.NUMERIC);
		/*
		if (CoC_Settings.debugBuild) {
			for each (perk in perksByDistance) {
				trace("" + perk.distance + " " + perk.id);
			}
		}
		 */
		// 3. Group perks by roots (jobs)
		var rootLists:/*PerkType*/Array = [
				PerkLib.PRESTIGE_JOBS,
				PerkLib.ADVANCED_JOBS,
				PerkLib.BASIC_JOBS
		];
		var job:PerkType;
		for (i = 0; i < rootLists.length; i++) {
			var jobTier:int = rootLists.length - i;
			for each (job in rootLists[i]) {
				if (listUnlocks(job).length == 0) {
					trace("WARNING: Perk "+job.id+" listed as job but has no unlocks");
					continue;
				}
				var unlocks:/*PerkType*/Array = [];
				queue = listUnlocks(job);
				while (queue.length > 0) {
					perk = queue.pop();
					if (perk is IMutationPerkType) continue;
					if (PerkLib.isJob(perk)) continue;
					entry = pdata[perk.id];
					if (!entry) continue;
					if (entry.jobTier > jobTier) continue;
					if (entry.hasJob(job)) continue;
					
					entry.addJob(job, jobTier);
					unlocks.push(perk);
					pushAll(queue, listUnlocks(perk));
				}
				
				unlocks.sortOn(["distance","id"], Array.NUMERIC);
				if (CoC_Settings.debugBuild) {
					trace(job.id+" perks ("+unlocks.length+")");
					/*
					for each (perk in unlocks) {
						trace("    "+perk.distance+" "+perk.id);
					}
					 */
				}
				rootUnlocks[job.id] = unlocks;
			}
		}
	}
	
	/** perk.id -> PerkType[] sorted by distance  */
	private static var rootUnlocks:Dictionary = new Dictionary();
	/**
	 * Return all perks associated with this job:
	 * - require (directly on indirectly) this job
	 * - not a job perks themselves
	 * - do not require higher-tier job
	 */
	public static function getJobUnlocks(job:PerkType):/*PerkType*/Array {
		return rootUnlocks[job.id] || [];
	}
	public static function getJobs(perk:PerkType):Array {
		var entry:PerkTreeEntry = pdata[perk.id];
		if (!entry) return null;
		if (entry.jobs && entry.jobs.length > 0) return entry.jobs;
		return null;
	}
	public static function hasJob(perk:PerkType, job:PerkType):Boolean {
		var entry:PerkTreeEntry = pdata[perk.id];
		if (!entry) return false;
		return entry.hasJob(job);
	}
	
	public var perksByDistance:/*PerkType*/Array = [];
	
	/**
	 * Returns Array of PerkType
	 */
	public function listUnlocks(p:PerkType):/*PerkType*/Array {
		if (!pdata[p.id]) return [];
		return pdata[p.id].unlocks.map(function(entry:PerkTreeEntry,idx:int,array:/*PerkTreeEntry*/Array):PerkType {
			return entry.perk;
		});
	}
	private static var obtanablePerksCached:/*PerkType*/Array = null;
	/**
	 * Returns Array of PerkType
	 */
	public static function obtainablePerks():/*PerkType*/Array {
		if (obtanablePerksCached) return obtanablePerksCached;
		var rslt:Array=[];
		for each(var perk:PerkType in PerkType.getPerkLibrary()) {
			if (perk.requirements.length > 0) {
				rslt.push(perk);
			}
		}
		obtanablePerksCached = rslt.sortOn("name");
		return obtanablePerksCached;
	}
	/**
	 * Returns Array of PerkType
	 */
	public static function availablePerks(player:Player, withMutations:Boolean):/*PerkType*/Array {
		return obtainablePerks().filter(
				function (perk:PerkType,idx:int,array:/*PerkType*/Array):Boolean {
					if (perk is IMutationPerkType && !withMutations) return false;
					return !player.hasPerk(perk) && perk.available(player);
				});
	}
}
}

import classes.PerkType;

class PerkTreeEntry {
	public var perk:PerkType;
	public var jobs:Array;
	public var jobTier:int = 0;
	public var unlocks:/*PerkTreeEntry*/Array =[];

	public function PerkTreeEntry(perk:PerkType) {
		this.perk = perk;
	}
	public function addJob(job:PerkType, tier:int):void {
		if (!jobs) jobs = [];
		jobs.push(job);
		jobTier = tier;
	}
	public function hasJob(job:PerkType):Boolean {
		return jobs && jobs.indexOf(job) >= 0;
	}
}
