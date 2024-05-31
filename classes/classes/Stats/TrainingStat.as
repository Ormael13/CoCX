package classes.Stats {
import classes.Creature;
import classes.PerkLib;
import classes.IMutations.IMutationsLib;

public class TrainingStat extends RawStat {
	public function TrainingStat(host:Creature, name:String) {
		super(host, name, {min:1, value: 0, max: 100});
	}
	
	override public function get max():Number {
		var train:Number = 100;
		//train += 2 * host.perkv1(PerkLib.AscensionTranshumanism);
		if (host.hasPerk(PerkLib.MunchkinAtBioLab)) train += 10;
		switch (statName) {
			case 'str.train':
				var str:Number = 1;
				if (host.perkv1(IMutationsLib.HumanBonesIM) >= 3) str += 0.2;
				if (host.perkv1(IMutationsLib.HumanBonesIM) >= 4) str += 0.1;
				train *= str;
				train = Math.round(train);
				break;
			case 'tou.train':
				var tou:Number = 1;
				if (host.perkv1(IMutationsLib.HumanBonesIM) >= 3) tou += 0.2;
				if (host.perkv1(IMutationsLib.HumanBonesIM) >= 4) tou += 0.1;
				train *= tou;
				train = Math.round(train);
				break;
			case 'spe.train':
				var spe:Number = 1;
				if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3) spe += 0.2;
				if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4) spe += 0.1;
				train *= spe;
				train = Math.round(train);
				break;
			case 'int.train':
				var inte:Number = 1;
				if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 3) inte += 0.2;
				if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 4) inte += 0.1;
				train *= inte;
				train = Math.round(train);
				break;
			case 'wis.train':
				//train += 16 * host.perkv1(PerkLib.AscensionTranshumanismWis);
				//train += host.perkv1(PerkLib.SoulTempering);
				var wis:Number = 1;
				if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 3) wis += 0.2;
				if (host.perkv1(IMutationsLib.HumanSmartsIM) >= 4) wis += 0.1;
				train *= wis;
				train = Math.round(train);
				break;
			case 'lib.train':
				var lib:Number = 1;
				if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3) lib += 0.2;
				if (host.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4) lib += 0.1;
				train *= lib;
				train = Math.round(train);
				break;
		}
		return train;
	}
}
}
