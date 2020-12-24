package classes.Stats {
import classes.Creature;
import classes.PerkLib;
import classes.Monster;

public class CoreStat extends RawStat{
	public function CoreStat(host:Creature, name:String) {
		super(host, name, {min:1, value:1, max: 100});
	}
	
	override public function get max():Number {
		if (this is Monster) return Infinity;
		var base:Number = 100;
		base += host.perkv1(PerkLib.AscensionTranshumanism);
		switch (statName) {
			case 'str.core':
				base += 8 * host.perkv1(PerkLib.AscensionTranshumanismStr);
				break;
			case 'tou.core':
				base += 8 * host.perkv1(PerkLib.AscensionTranshumanismTou);
				break;
			case 'spe.core':
				base += 8 * host.perkv1(PerkLib.AscensionTranshumanismSpe);
				break;
			case 'int.core':
				base += 8 * host.perkv1(PerkLib.AscensionTranshumanismInt);
				break;
			case 'wis.core':
				base += 8 * host.perkv1(PerkLib.AscensionTranshumanismWis);
				break;
			case 'lib.core':
				base += 8 * host.perkv1(PerkLib.AscensionTranshumanismLib);
				break;
		}
		return base;
	}
}
}
