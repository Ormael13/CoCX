/**
 * Created by aimozg on 26.01.14.
 * Adapted for use for Mutations by Jtecx on 15.05.22.
 */
package classes
{
import classes.GlobalFlags.kFLAGS;
import classes.Stats.StatUtils;

import flash.utils.Dictionary;

public class IMutationPerkType extends PerkType
	{
		private var _maxLvl:int;
		private var _pBuffs:Object;

		public function IMutationPerkType(id:String, name:String, desc:String, longDesc:String = null, keepOnAscension:Boolean = false) {
			super(id, name, desc, longDesc, keepOnAscension);
		}

		public function get maxLvl():int{
			return _maxLvl;
		}

		public function set maxLvl(Lvl:int):void{
			_maxLvl = Lvl;
		}

		public function pReqs(target:* = null):void{
		}

		public function pBuffs(target:* = null):Object{
			return _pBuffs;
		}

	}
}