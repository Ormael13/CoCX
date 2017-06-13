/**
 * Created by aimozg on 02.04.2017.
 */
package classes.internals {
public class CounterGroup extends ArrayWithDefault {
	public function CounterGroup(array:Array) {
		super(array);
	}

	override protected function defaultValue():* {
		return 0;
	}
}
}
