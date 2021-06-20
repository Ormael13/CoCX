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
		base += 2 * host.perkv1(PerkLib.AscensionTranshumanism);
		switch (statName) {
			case 'str.core':
				base += 16 * host.perkv1(PerkLib.AscensionTranshumanismStr);
				base += host.perkv1(PerkLib.BodyTempering);
				if (host.hasPerk(PerkLib.AsuraStrength)) base *= 1.1;
				base = Math.round(base);
				break;
			case 'tou.core':
				base += 16 * host.perkv1(PerkLib.AscensionTranshumanismTou);
				base += host.perkv1(PerkLib.BodyTempering);
				if (host.hasPerk(PerkLib.AsuraToughness)) base *= 1.1;
				if (host.hasPerk(PerkLib.BloodDemonToughness)) base *= 1.1;
				base = Math.round(base);
				break;
			case 'spe.core':
				base += 16 * host.perkv1(PerkLib.AscensionTranshumanismSpe);
				base += host.perkv1(PerkLib.BodyTempering);
				if (host.hasPerk(PerkLib.AsuraSpeed)) base *= 1.1;
				base = Math.round(base);
				break;
			case 'int.core':
				base += 16 * host.perkv1(PerkLib.AscensionTranshumanismInt);
				base += host.perkv1(PerkLib.SoulTempering);
				if (host.hasPerk(PerkLib.BloodDemonIntelligence)) base *= 1.1;
				base = Math.round(base);
				break;
			case 'wis.core':
				base += 16 * host.perkv1(PerkLib.AscensionTranshumanismWis);
				base += host.perkv1(PerkLib.SoulTempering);
				if (host.hasPerk(PerkLib.BloodDemonWisdom)) base *= 1.1;
				base = Math.round(base);
				break;
			case 'lib.core':
				base += 16 * host.perkv1(PerkLib.AscensionTranshumanismLib);
				base += host.perkv1(PerkLib.SoulTempering);
				break;
		}
		return base;
	}
}
}
