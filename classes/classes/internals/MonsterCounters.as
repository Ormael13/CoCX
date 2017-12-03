/**
 * Created by aimozg on 27.03.2017.
 */
package classes.internals {
import classes.GlobalFlags.kCOUNTERS;
import classes.CoC;

public class MonsterCounters extends kCOUNTERS{
	public function get encountered():int { return storage[index][_MONSTER_ENCOUNTERED]||0}
	public function set encountered(value:int): void {
		setValue(_MONSTER_ENCOUNTERED,value);
	}
	public function get battled():int { return storage[index][_MONSTER_BATTLED]||0}
	public function set battled(value:int): void {
		setValue(_MONSTER_BATTLED, value);
	}
	public function get won_total():int { return storage[index][_MONSTER_WON_TOTAL]||0}
	public function set won_total(value:int): void {
		setValue(_MONSTER_WON_TOTAL, value);
	}
	public function get won_lust():int { return storage[index][_MONSTER_WON_LUST]||0}
	public function set won_lust(value:int): void {
		setValue(_MONSTER_WON_LUST, value);
	}
	public function get won_hp():int { return storage[index][_MONSTER_WON_HP]||0}
	public function set won_hp(value:int): void {
		setValue(_MONSTER_WON_HP, value);
	}
	public function get lost_total():int { return storage[index][_MONSTER_LOST_TOTAL]||0}
	public function set lost_total(value:int): void {
		setValue(_MONSTER_LOST_TOTAL, value);
	}
	public function get lost_lust():int { return storage[index][_MONSTER_LOST_LUST]||0}
	public function set lost_lust(value:int): void {
		setValue(_MONSTER_LOST_LUST, value);
	}
	public function get lost_hp():int { return storage[index][_MONSTER_LOST_HP]||0}
	public function set lost_hp(value:int): void {
		setValue(_MONSTER_LOST_HP, value);
	}
	public function get ranfrom():int { return storage[index][_MONSTER_RANFROM]||0}
	public function set ranfrom(value:int): void {
		setValue(_MONSTER_RANFROM, value);
	}
	public function get sex_total():int { return storage[index][_MONSTER_SEX_TOTAL]||0}
	public function set sex_total(value:int): void {
		setValue(_MONSTER_SEX_TOTAL, value);
	}
	public function get sex_when_won():int { return storage[index][_MONSTER_SEX_WHEN_WON] || 0}
	public function set sex_when_won(value:int): void {
		setValue(_MONSTER_SEX_WHEN_WON, value);
	}
	public function get sex_when_lost():int { return storage[index][_MONSTER_SEX_WHEN_LOST] || 0}
	public function set sex_when_lost(value:int): void {
		setValue(_MONSTER_SEX_WHEN_LOST, value);
	}
	public function get sex_nobattle():int { return storage[index][_MONSTER_SEX_NO_BATTLE] || 0}
	public function set sex_nobattle(value:int): void {
		setValue(_MONSTER_SEX_NO_BATTLE, value);
	}

	public function setValue(subindex:int,value:int):void {
		modValue(subindex,value - storage[index][subindex]);
	}
	public function modValue(subindex:int,delta:int):void {
		storage[index][subindex] += delta;
		if (group != null) group.modValue(subindex,delta);
	}
	private function get storage():CountersStorage {
		return CoC.instance.counters._storage;
	}
	public function get group():MonsterCounters {
		if (_group_index<0) return null;
		return Library[_group_index];
	}
	public function get group_index():int {
		return _group_index;
	}

	private var index:int;
	private var _group_index:int;
	public function MonsterCounters(index:int,group:int) {
		this.index = index;
		this._group_index = group;
		Library[index] = this;
	}
	public static const Library:Object = {}; // index:int -> MonsterObject
}
}
