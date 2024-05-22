package classes.Items.Dynamic.Effects {
import classes.EngineCore;
import classes.ItemType;
import classes.Items.Armor;
import classes.Items.Effects.RaceTfItemEffect;
import classes.Items.Enchantment;
import classes.Items.EnchantmentLib;
import classes.Items.EnchantmentType;
import classes.Items.Equipable;
import classes.Items.IDynamicItem;
import classes.Items.IELib;
import classes.Items.Shield;
import classes.Items.Weapon;
import classes.Items.WeaponRange;
import classes.Player;
import classes.Race;
import classes.Races;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.Transformations.PossibleEffect;
import classes.Transformations.TransformationUtils;

public class RaceTfEnchantmentType extends EnchantmentType {
	
	/**
	 * Player has been TF'd into race. Remove enchantment and curse status
	 */
	public static function disenchant(race:Race):void {
		trace("RaceTf disencnant");
		EngineCore.outputText("\n\n<b>Your transformation into " + race.nameFor(game.player.bodyData()))
		if (game.player.raceObject() == race) {
			EngineCore.outputText(" is complete, and the curse is lifted!</b>")
		} else {
			// main race is different, but player is tier1 at least
			EngineCore.outputText(" has advanced enough to lift the curse!</b>")
		}
		for each (var i:ItemType in game.player.allEquipment()) {
			var e:SimpleRaceEnchantment = i.enchantmentOfType(EnchantmentLib.RaceTf) as SimpleRaceEnchantment;
			if (!e) continue;
			if (e.race == race) {
				var e2:Enchantment;
				if (i is Weapon || i is WeaponRange) {
					e2 = EnchantmentLib.RaceAttackBonus.spawn2(true, e.power, e.race);
				} else if (i is Armor || i is Shield) {
					e2 = EnchantmentLib.RaceDefenseBonus.spawn2(true, e.power, e.race);
				} else {
					e2 = EnchantmentLib.RaceSpellPowerBonus.spawn2(true, e.power, e.race);
				}
				var i2:ItemType = i;
				i2              = (i2 as IDynamicItem).copyWithoutEnchantment(e);
				i2              = (i2 as IDynamicItem).uncursedCopy();
				i2              = (i2 as IDynamicItem).copyWithEnchantment(e2);
				game.player.replaceEquipment(i as Equipable, i2 as Equipable);
				EngineCore.outputText(" Your " + i.longName + " turns into " + i2.longName + "!");
			}
		}
	}
	
	public function RaceTfEnchantmentType(
			id:int,
			name:String,
			rarity:int,
			minLevel:int
	) {
		var curse:Boolean      = true;
		var descPattern:String = "Every {30-6*power} hours transforms you into {race.name}.";
		super(id, name, curse, descPattern, rarity, minLevel);
		negative = true;
	}
	
	
	override public function hideDescription(enchantment:Enchantment):Boolean {
		return true;
	}
	
	override protected function doDecode(identified:Boolean, paramsOnly:Array):Enchantment {
		var power:Number            = paramsOnly[0];
		var race:Race               = Race.byId(paramsOnly[1]);
		var valueAddBase:int        = 0;
		var valueAddPerPower:int    = 250;
		var valueMulBase:Number     = 1.0;
		var valueMulPerPower:Number = 0.0;
		var valueAdd:Number         = valueAddBase + valueAddPerPower * power;
		var valueMul:Number         = valueMulBase + valueMulPerPower * power;
		var prefix:String           = "{race.name;C} nature ";
		var suffix:String           = " of {race.name;C} nature ";
		var shortSuffix:String      = "RTF";
		return new SimpleRaceEnchantment(
				identified,
				this,
				prefix,
				suffix,
				shortSuffix,
				power,
				race,
				paramsOnly,
				valueAdd,
				valueMul
		)
	}
	
	public function spawn(identified:Boolean, power:int, race:Race, permEffect:Boolean=false):SimpleRaceEnchantment {
		return doDecode(identified, [power, race.id, permEffect]) as SimpleRaceEnchantment;
	}
	
	override public function generateRandom(options:Object = null):Enchantment {
		var minPower:int = 1;
		var maxPower:int = 4;
		var power:int    = randIntIn(minPower, maxPower);
		var race:Race    = weightedRandomBy(RaceTfItemEffect.RaceGen, "chance", "race");
		return doDecode(valueOr(options.identified, false), [power, race.id]);
	}
	
	override public function onAdd(enchantment:Enchantment, item:Equipable):void {
		item.withEffect(IELib.RaceTf, 30-enchantment.power*3, (enchantment as SimpleRaceEnchantment).race);
	}
}
}
