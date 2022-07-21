package classes.Stats {
import classes.Creature;

public class TrainingStat extends RawStat {
	public function TrainingStat(host:Creature, name:String) {
		super(host, name, {min:1, value: 0, max: 100});
	}
}
}
