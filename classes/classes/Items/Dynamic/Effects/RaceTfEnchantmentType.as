package classes.Items.Dynamic.Effects {
import classes.EngineCore;
import classes.ItemType;
import classes.Items.Enchantment;
import classes.Items.EnchantmentLib;
import classes.Items.EnchantmentType;
import classes.Items.IDynamicItem;
import classes.Race;
import classes.Races;
import classes.StatusEffectClass;
import classes.Transformations.PossibleEffect;
import classes.Transformations.TransformationUtils;

public class RaceTfEnchantmentType extends EnchantmentType {
	
	/**
	 * Element properties:
	 * - chance:Number, spawn weight, default 1
	 * - race:Race
	 * - tfs:Transformation[]
	 */
	public const RaceGen:Array = [{
		chance: 0.5,
		race: Races.KITSUNE,
		tfs: Races.KITSUNE.TfListKitsune
	}, {
		chance: 1.0,
		race: Races.FOX,
		tfs: Races.FOX.TfList
	}];
	private static var instance:RaceTfEnchantmentType;
	
	public static function hoursBetweenTf(power:int):int {
		return Math.max(1, 30 - 6 * power);
	}
	
	public static function allEnchantedEquipment(race:Race):/*ItemType*/Array {
		return game.player.allEquipment().filter(varargify(function (it:ItemType):Boolean {
			var e:RaceTfEnchantment = it.enchantmentOfType(EnchantmentLib.RaceTf) as RaceTfEnchantment;
			return e && e.race == race;
		}));
	}
	
	/**
	 * Advance the TF from the status effect
	 * @param effect
	 * @return true if text was printed
	 */
	public static function advance(effect:StatusEffectClass):Boolean {
		if (game.player.blockingBodyTransformations()) return false;
		// v1: hours till next TF, v2: race id, v3: no. of equipped items of that race
		var race:Race = Race.byId(effect.value2);
		if (game.player.isRace(race)) {
			disenchant(race);
			return true;
		}
		effect.value1--;
		trace("RaceTf tick-->" + effect.value1);
		var textOutput:Boolean      = false;
		var items:/*ItemType*/Array = allEnchantedEquipment(race);
		if (effect.value1 == 0) {
			var entry:Object      = findByProp(instance.RaceGen, "race", Race.byId(effect.value2));
			var tfList:Array      = entry.tfs;
			var tf:PossibleEffect = TransformationUtils.randomPossibleEffect(tfList);
			if (tf) {
				trace("RaceTf tf");
				EngineCore.outputText("<b>Your " + items[0].longName + " twists your body...</b> ");
				tf.applyEffect(true);
				textOutput = true;
				if (game.player.isRace(race)) {
					disenchant(race);
				} else {
					var maxPower:int = 0;
					for each (var item:ItemType in items) {
						maxPower = Math.max(maxPower, item.enchantmentPower(EnchantmentLib.RaceTf));
					}
					effect.value1 = hoursBetweenTf(maxPower);
					trace("RaceTf tick reset to " + effect.value1);
				}
			}
		} else if (effect.value1 == 1) {
			EngineCore.outputText("<b>Your " + items[0].longName + " is almost charged...</b> ");
			textOutput = true;
		}
		return textOutput;
	}
	
	/**
	 * Player has been TF'd into race. Remove enchantment and curse status
	 */
	public static function disenchant(race:Race):void {
		trace("RaceTf disencnant");
		EngineCore.outputText("<b>Your transformation into " + race.nameFor(game.player.bodyData()))
		if (game.player.raceObject() == race) {
			EngineCore.outputText(" is complete, and the curse is lifted!</b>")
		} else {
			// main race is different, but player is tier1 at least
			EngineCore.outputText(" has advanced enough to lift the curse!</b>")
		}
		for each (var i:ItemType in game.player.allEquipment()) {
			var e:RaceTfEnchantment = i.enchantmentOfType(EnchantmentLib.RaceTf) as RaceTfEnchantment;
			if (!e) continue;
			if (e.race == race) {
				var i2:ItemType = i;
				i2              = (i2 as IDynamicItem).copyWithoutEnchantment(e);
				i2              = (i2 as IDynamicItem).uncursedCopy();
				// TODO replace with new enchantment
				game.player.replaceEquipment(i, i2);
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
		instance               = this;
		var curse:Boolean      = true;
		var descPattern:String = "Every {30-6*power} hours transforms you into {race.name}.";
		super(id, name, curse, descPattern, rarity, minLevel);
		negative = true;
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
		var prefix:String           = capitalizeFirstLetter(race.name) + " nature ";
		var suffix:String           = " of " + capitalizeFirstLetter(race.name) + " nature ";
		var shortSuffix:String      = "RTF";
		return new RaceTfEnchantment(
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
	
	public function spawn(identified:Boolean, power:int, race:Race):RaceTfEnchantment {
		return doDecode(identified, [power, race.id]) as RaceTfEnchantment;
	}
	
	override public function generateRandom(options:Object = null):Enchantment {
		var minPower:int = 1;
		var maxPower:int = 4;
		var power:int    = randIntIn(minPower, maxPower);
		var race:Race    = weightedRandomBy(RaceGen, "chance", "race");
		return doDecode(valueOr(options.identified, false), [power, race.id]);
	}
}
}
