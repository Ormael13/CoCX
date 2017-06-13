/**
 * Created by aimozg on 27.03.2017.
 */
package classes.internals {
import classes.internals.MonsterCounters;
import classes.internals.MonsterCounters;
import classes.internals.MonsterCounters;

public class RootCounters extends CountersAPI {
	public function RootCounters(_storage:CountersStorage) {
		super(_storage);
	}
	public const mCumWitch:MonsterCounters = new MonsterCounters(MONSTER_CUMWITCH,MONGROUP_HUMAN);
	public const mGoblin:MonsterCounters = new MonsterCounters(MONSTER_GOBLIN,MONGROUP_GOBLINOID);
	public const mGoblinAssassin:MonsterCounters = new MonsterCounters(MONSTER_GOBLINASSASSIN,MONGROUP_GOBLINOID);
	public const mGoblinElder:MonsterCounters = new MonsterCounters(MONSTER_GOBLINELDER,MONGROUP_GOBLINOID);
	public const mGoblinMatron:MonsterCounters = new MonsterCounters(MONSTER_GOBLINMATRON,MONGROUP_GOBLINOID);
	public const mGoblinShaman:MonsterCounters = new MonsterCounters(MONSTER_GOBLINSHAMAN,MONGROUP_GOBLINOID);
	public const mGoblinWarrior:MonsterCounters = new MonsterCounters(MONSTER_GOBLINWARRIOR,MONGROUP_GOBLINOID);
	public const mImp:MonsterCounters = new MonsterCounters(MONSTER_IMP,MONGROUP_DEMON);
	public const mImplord:MonsterCounters = new MonsterCounters(MONSTER_IMPLORD,MONGROUP_DEMON);
	public const mNaga:MonsterCounters = new MonsterCounters(MONSTER_NAGA,MONGROUP_REPTILIAN);
	public const mSandtrap:MonsterCounters = new MonsterCounters(MONSTER_SANDTRAP,MONGROUP_INSECT);
	public const mSandWitch:MonsterCounters = new MonsterCounters(MONSTER_SANDWITCH,MONGROUP_HUMAN);
	public const mTentacleBeast:MonsterCounters = new MonsterCounters(MONSTER_TENTACLEBEAST,-1);

	public const mgGoblinoids:MonsterCounters = new MonsterCounters(MONGROUP_GOBLINOID,-1);
}
}
