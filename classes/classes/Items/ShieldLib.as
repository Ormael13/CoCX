package classes.Items
{
	/**
	 * ...
	 * @author Kitteh6660
	 */

import classes.Items.Dynamic.DynamicShield;
import classes.Items.Shields.*;
import classes.PerkLib;
import classes.Races;

public final class ShieldLib extends ItemConstants
	{
		public function Legendary():Array {
			return legendaryPure().concat(LegendaryCorrupt());
		}
		public function legendaryPure():Array {
			return [
				SANCTYL
			];
		}
		public function LegendaryCorrupt():Array {
			return [
				SANCTYD
			];
		}

		public static const DEFAULT_VALUE:Number = 6;	//cena dla tarcz bazowa to 50 gems a nie 40 gems
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const AETHERS:AetherS = new AetherS();
		public const ANC_CON:AncientConduit = new AncientConduit();
		public const BATTNET:Shield = new Shield("BattNet", "BattleNet", "Battle Net", "a Battle Net", 0, 100, "A battle net used in the off hand to impair the opponent's movement. Also very good for fishing.");
		public const BSHIELD:BeautifulShield = new BeautifulShield();
		public const BLASPHE:Shield = new Shield("Blasphe", "Blasphemy", "Blasphemy", "a Blasphemy", 1, 200, "Metal prayer beads, engraved with holy symbols of dead gods.", "Obsession").withPerk(PerkLib.Obsession, 0.2, 0.15, 0, 0) as Shield;
		public const BUCKLER:Shield = new Shield("Buckler", "Buckler", "buckler", "a buckler", 5, 250, "A simple wooden rounded shield.");
		public const DRGNSHL:DragonShellShield = new DragonShellShield();
		public const GREATSH:GreatShield = new GreatShield();
		public const IMPTOME:DynamicShield = ItemTemplateLib.instance.createShield("tome", ItemConstants.RARITY_MAGICAL, 0, ItemConstants.CS_HIDDEN_CURSED, [EnchantmentLib.RaceSpellPowerDoubled.spawn2(true, 1, Races.IMP)]);
		public const NEKONOM:Shield = new Shield("Nekonomicon", "Nekonomicon", "Nekonomicon", "a Nekonomicon", 0, 500,
				"A copy of the unholy texts of the Hellcat sect. Rumor has it their blasphemous lord Abraxas wrote it himself. (+100% power to fire and dark spell)") as Shield;
		public const KITE_SH:Shield = new Shield("Kite Sh", "KiteShield", "kite shield", "a kite shield", 14, 700, "An average-sized kite shield.");
		public const MABRACE:Shield = new Shield("MaBrace", "ManaBracer", "mana bracer", "a mana bracer", 2, 200,
				"Runed bracers such as this are popular amongst mages that can afford them. This silver bracer augments a mage’s spell power while leaving the hand open to make gestures used in spellcasting.",
				"Magic").withBuff('spellpower', +0.5) as Shield;
		public const NECROSH:NecroShield = new NecroShield();
		public const SPI_FOC:SpiritFocus = new SpiritFocus();
		public const TRASBUC:Shield = new Shield("TraSBuc", "TrainSBuckler", "training soul buckler", "a training soul buckler", 3, 300, "A simple rounded shield made of soulmetal used to train soulforce by soul cultivator novices.");
		public const TOWERSH:Shield = new TowerShield();
		public const SANCTYN:SanctuaryN = new SanctuaryN();
		public const SANCTYL:Sanctuary = new Sanctuary();
		public const SANCTYD:DarkAegis = new DarkAegis();
		public const SPIH_SH:SpikedHeavyShield = new SpikedHeavyShield();
		public const SPIL_SH:Shield = new Shield("SpiL Sh", "SpikeLShield", "spiked light shield", "a spiked light shield", 10, 750, "An average-sized shield with spikes.");
		public const SPIM_SH:SpikedMassiveShield = new SpikedMassiveShield();
		public const Y_U_PAN:Shield = new Shield("Y.U.Pan", "Y.U.Panel", "Yogi Uh Panel", "an Yogi Uh Panel", 0, 200, "This strange shield helps Summoners and Golemancers store their pets inside an extra dimensional space when out of battle. The shield can then release them through a system of Calling Cards. Apparently it was a widely used tool for summoner battles back in the days which they called duels.");
		
		/*private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Shield(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}*/
		
		public function ShieldLib()
		{
		}
	}
}
