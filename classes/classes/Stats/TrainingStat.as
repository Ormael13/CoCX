package classes.Stats {
import classes.Creature;
import classes.PerkLib;
import classes.MutationsLib;

public class TrainingStat extends RawStat {
	public function TrainingStat(host:Creature, name:String) {
		super(host, name, {min:1, value: 0, max: 100});
	}
	/*
	override public function get max():Number {
		var train:Number = 100;
		//train += 2 * host.perkv1(PerkLib.AscensionTranshumanism);
		switch (statName) {
			case 'str.train':
				break;
			case 'tou.train':
				break;
			case 'spe.train':
				break;
			case 'int.train':
				break;
			case 'wis.train':
				//train += 16 * host.perkv1(PerkLib.AscensionTranshumanismWis);
				//train += host.perkv1(PerkLib.SoulTempering);
				//if (host.hasPerk(PerkLib.BloodDemonWisdom)) train *= 1.1;
				//train = Math.round(train);
				break;
			case 'lib.train':
				break;
		}
		return train;
	}*/
}
}
