package classes.Stats {
import classes.Stats.BuffableStat;
import classes.internals.Utils;

public class BuffBuilder {
	
	private var store: StatStore;
	private var tag: String;
	private var options: Object = {};
	
	public function BuffBuilder(store: StatStore, tag: String) {
		this.store = store;
		this.tag = tag;
	}
	
	// Utility functions
	
	public function isPresent(): Boolean {
		return store.hasBuff(tag);
	}
	public function findAllBuffObjects(): /*Buff*/Array {
		return store.buffObjects(tag);
	}
	public function findBuffObjectOfStat(statName:String): Buff {
		var stat:BuffableStat = store.findBuffableStat(statName);
		return stat.findBuff(tag);
	}
	public function getRemainingTicks():int {
		var buff:Buff = store.buffObjects(tag)[0];
		if (buff) return buff.tick;
		return 0;
	}
	public function getValueOfStatBuff(statName:String): Number {
		var stat:BuffableStat = store.findBuffableStat(statName);
		return stat.valueOfBuff(tag);
	}
	
	// Builder functions
	
	public function remove(): BuffBuilder {
		store.removeBuffs(tag);
		return this;
	}
	public function removeFromStat(statName: String): BuffBuilder {
		store.findBuffableStat(statName).removeBuff(tag);
		return this;
	}
	public function addStat(statName: String, value: Number,
							min: Number = Number.NEGATIVE_INFINITY,
							max: Number = Number.POSITIVE_INFINITY): BuffBuilder {
		var stat:BuffableStat = store.findBuffableStat(statName);
		var oldValue: Number = stat.valueOfBuff(tag);
		var newValue: Number = Utils.boundFloat(min, oldValue + value, max);
		if (newValue == 0) {
			stat.removeBuff(tag);
		} else {
			stat.addOrReplaceBuff(tag, newValue, options);
		}
		return this;
	}
	public function subtractStat(statName: String, value: Number,
							min: Number = Number.NEGATIVE_INFINITY,
							max: Number = Number.POSITIVE_INFINITY): BuffBuilder {
		addStat(statName, -value, min, max);
		return this;
	}
	public function setStat(statName: String, value: Number): BuffBuilder {
		store.findBuffableStat(statName).addOrReplaceBuff(tag, value, options);
		return this;
	}
	public function addStats(buffObject: Object): BuffBuilder {
		store.addBuffObject(buffObject, tag, options);
		return this;
	}
	public function subtractStats(buffObject: Object): BuffBuilder {
		store.addBuffObject(StatUtils.inverseBuffObject(buffObject), tag, options);
		return this;
	}
	public function setStats(buffObject: Object): BuffBuilder {
		store.replaceBuffObject(buffObject, tag, options);
		return this;
	}
	public function withOptions(options:*): BuffBuilder {
		Utils.extend(this.options, options);
		store.setBuffOptions(tag, options);
		return this;
	}
	public function withText(text: String): BuffBuilder {
		return withOptions({text:text});
	}
	public function permanent(): BuffBuilder {
		return withOptions({rate:Buff.RATE_PERMANENT, tick:0});
	}
	public function forHours(hours:int): BuffBuilder {
		return withOptions({rate:Buff.RATE_HOURS, tick:hours});
	}
	public function forDays(days:int): BuffBuilder {
		return withOptions({rate:Buff.RATE_DAYS, tick:days});
	}
	public function combatTemporary(rounds:int): BuffBuilder {
		return withOptions({rate:Buff.RATE_ROUNDS, tick:rounds});
	}
	public function combatPermanent(): BuffBuilder {
		return withOptions({rate:Buff.RATE_ROUNDS, tick:9999});
	}
	public function addDuration(tick:int): BuffBuilder {
		store.addTicksToBuffs(tag, tick);
		return this;
	}
	
	// Utility functions for particular stats go here
	
	public function addStr(value: Number): BuffBuilder {
		return addStat("str", value);
	}
	public function addStrMult(value: Number): BuffBuilder {
		return addStat("str.mult", value);
	}
	public function addTou(value: Number): BuffBuilder {
		return addStat("tou", value);
	}
	public function addTouMult(value: Number): BuffBuilder {
		return addStat("tou.mult", value);
	}
	public function addSpe(value: Number): BuffBuilder {
		return addStat("spe", value);
	}
	public function addSpeMult(value: Number): BuffBuilder {
		return addStat("spe.mult", value);
	}
	public function addInt(value: Number): BuffBuilder {
		return addStat("int", value);
	}
	public function addIntMult(value: Number): BuffBuilder {
		return addStat("int.mult", value);
	}
	public function addWis(value: Number): BuffBuilder {
		return addStat("wis", value);
	}
	public function addWisMult(value: Number): BuffBuilder {
		return addStat("wis.mult", value);
	}
	public function addLib(value: Number): BuffBuilder {
		return addStat("lib", value);
	}
	public function addLibMult(value: Number): BuffBuilder {
		return addStat("lib.mult", value);
	}
	public function addSens(value: Number): BuffBuilder {
		return addStat("sens", value);
	}
	
}
}
