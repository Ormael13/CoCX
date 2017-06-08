/**
 * Created by aimozg on 27.03.2017.
 */
package classes.internals {
import classes.GlobalFlags.kCOUNTERS;

import flash.utils.Proxy;
import flash.utils.flash_proxy;

public class CountersStorage extends ArrayWithDefault {


	public function CountersStorage() {
		super();
	}

	override protected function cast(o:*):* {
		if (o is CounterGroup) return o;
		if (o is Array) return new CounterGroup(o);
		return defaultValue();
	}

	override protected function defaultValue():* {
		return new CounterGroup([]);
	}
}
}
