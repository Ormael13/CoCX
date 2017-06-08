/**
 * Created by aimozg on 27.03.2017.
 */
package classes.internals {
import classes.GlobalFlags.kCOUNTERS;

/**
 * A superclass for CountersStorage wrappers
 */
public class CountersAPI extends kCOUNTERS{
	public var _storage:CountersStorage;
	public function CountersAPI(_storage:CountersStorage) {
		this._storage = _storage;
	}
}
}
