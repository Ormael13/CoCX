/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.CoC;
import classes.DefaultDict;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Alchemy.AlchemyReagent;
import classes.Player;
import classes.Scenes.Camp;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

/**
	 * An item, that is consumed by player, and disappears after use. Direct subclasses should override "doEffect" method
	 * and NOT "useItem" method.
	 */
	public class Consumable extends Useable
	{

    protected function get mutations():Mutations { return CoC.instance.mutations; }
		protected function get changes():int { return mutations.changes; }
		protected function set changes(val:int):void { mutations.changes = val; }
		protected function get changeLimit():int { return mutations.changeLimit; }
		protected function set changeLimit(val:int):void { mutations.changeLimit = val; }

		protected function get player():Player { return CoC.instance.player; }
		protected function get flags():DefaultDict { return CoC.instance.flags; }
		protected function get camp():Camp { return SceneLib.camp; }
		protected function doNext(func:Function, ...args):void {
			EngineCore.doNext.apply(null, [func].concat(args));
		}
		protected function rand(n:Number):int { return Utils.rand(n); }

		override public function get category():String {
			return CATEGORY_CONSUMABLE;
		}

		public function Consumable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
		}

		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Consumable ";
			if (shortName == "Wingstick" || shortName == "MiniBangB") desc += "(Thrown)";
			if (shortName == "S.Hummus") desc += "(Cheat Item)";
			if (shortName == "BroBrew" || shortName == "BimboLq" || shortName == "P.Pearl") desc += "(Rare Item)";
			if (longName.indexOf("dye") >= 0) desc += "(Dye)";
			if (longName.indexOf("egg") >= 0) desc += "(Egg)";
			if (longName.indexOf("book") >= 0) desc += "(Magic Book)";
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}

		/**
		 * Delegate function for legacy 'Mutations.as' code.
		 * @param	... args stat change parameters
		 */
		protected function dynStats(... args):void {
			game.player.dynStats.apply(game.player, args);
		}

		// Random drop table: [weight:number, essence:int][];
		public var essences: /*Number[]*/Array = null;
		// Random drop table: [weight:number, essence:int][];
		public var substances: /*Number[]*/Array = null;
		// Random drop table: [weight:number, essence:int][];
		public var residues: /*Number[]*/Array = null;
		// Random drop table: [weight:number, pigment:String][];
		public var pigments: /*Array*/Array = null;

		public function getRefineReagents(type:int):/*AlchemyReagent*/Array {
			var result:/*AlchemyReagent*/Array = [];
			var source:/*Array*/Array;
			switch (type) {
				case AlchemyLib.RT_ESSENCE: source = essences; break;
				case AlchemyLib.RT_SUBSTANCE: source = substances; break;
				case AlchemyLib.RT_RESIDUE: source = residues; break;
				case AlchemyLib.RT_PIGMENT: source = pigments; break;
			}
			for each (var k:Array in source) {
				result.push(AlchemyReagent.getReagent(type, k[1]));
			}
			return result;
		}
		public function getAllRefineReagents():/*AlchemyReagent*/Array {
			return concat(
					getRefineReagents(AlchemyLib.RT_ESSENCE),
					getRefineReagents(AlchemyLib.RT_RESIDUE),
					getRefineReagents(AlchemyLib.RT_PIGMENT),
					getRefineReagents(AlchemyLib.RT_SUBSTANCE)
			)
		}

		public function get isRefinable():Boolean {
			return essences || substances || residues || pigments;
		}
		/**
		 * Configure essences extractable with alchemy
		 * @param substances Essence drop table - array of pairs [weight, essence]
		 * @param essences Substance drop table - array of pairs [weight, substance]
		 * @param residues Residue drop table - array of pairs [weight, residue]
		 * @param pigments Pigment drop table - array of pairs [weight, pigment] or array of colors
		 * @return this
		 */
		public function refineableInto(
				substances:/*Number[]*/Array,
				essences:/*Number[]*/Array,
				residues:/*Number[]*/Array = null,
				pigments:Array = null
		):Consumable {
			var i:int;
			if (substances && substances.length > 0) {
				if (!this.substances) this.substances = [];
				for each (i in substances) {
					if (!AlchemyLib.Substances[i]) throw new Error("Ingredient "+id+" has invalid refineableInto substance "+i);
				}
				pushAll(this.substances, substances);
			}
			if (essences && essences.length > 0) {
				if (!this.essences) this.essences = [];
				for each (i in essences) {
					if (!AlchemyLib.Essences[i]) throw new Error("Ingredient "+id+" has invalid refineableInto essence "+i);
				}
				pushAll(this.essences, essences);
			}
			if (residues && residues.length > 0) {
				if (!this.residues) this.residues = [];
				for each (i in residues) {
					if (!AlchemyLib.Residues[i]) throw new Error("Ingredient "+id+" has invalid refineableInto residue "+i);
				}
				pushAll(this.residues, residues);
			}
			if (pigments && pigments.length > 0) {
				if (!this.pigments) this.pigments = [];
				for each (var p:* in pigments) {
					var w:int = 1;
					var color:String;
					if (p is Array) {
						w = p[0];
						color = p[1];
					} else {
						color = String(p);
					}
					if (color.indexOf(" and ") >= 0) {
						this.pigments.push([w/2, color.substring(0, color.indexOf(" and "))]);
						this.pigments.push([w/2, color.substring(color.indexOf(" and ")+5)]);
					} else {
						this.pigments.push([w, color]);
					}
				}
				// merge duplicates
				for (i=0; i < this.pigments.length; i++) {
					for (var j:int = this.pigments.length-1; j > i; j--) {
						if (this.pigments[i][1] == this.pigments[j][1]) {
							this.pigments[i][0] += this.pigments[j][0];
							this.pigments[j] = this.pigments[this.pigments.length-1];
							this.pigments.pop();
						}
					}
				}
			}
			return this;
		}
		public function refine(chances:/*Number*/Array):AlchemyReagent {
			var sum:Number = chances[0];
			if (substances) sum += chances[1];
			if (essences) sum += chances[2];
			if (residues) sum += chances[3];
			if (pigments) sum += chances[4];
			if (sum <= 0) return null;
			var x:Number = Math.random()*sum;
			x -= chances[1];
			if (x <= 0) return AlchemyReagent.substance(weightedRandom(substances));
			x -= chances[2];
			if (x <= 0) return AlchemyReagent.essence(weightedRandom(essences));
			x -= chances[3];
			if (x <= 0) return AlchemyReagent.residue(weightedRandom(residues));
			x -= chances[4];
			if (x <= 0) return AlchemyReagent.pigment(weightedRandom(pigments));
			return null;
		}
	}
}
