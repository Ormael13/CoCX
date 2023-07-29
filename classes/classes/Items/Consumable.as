/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.CoC;
import classes.DefaultDict;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyComponent;
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
			if (substances && substances.length > 0) {
				if (!this.substances) this.substances = [];
				pushAll(this.substances, substances);
			}
			if (essences && essences.length > 0) {
				if (!this.essences) this.essences = [];
				pushAll(this.essences, essences);
			}
			if (residues && residues.length > 0) {
				if (!this.residues) this.residues = [];
				pushAll(this.residues, residues);
			}
			if (pigments && pigments.length > 0) {
				if (!this.pigments) this.pigments = [];
				if (pigments[0] is Array) {
					pushAll(this.pigments, pigments);
				} else {
					for each (var pigment:String in pigments) {
						this.pigments.push([1, pigment]);
					}
				}
			}
			return this;
		}
		public function refine(chances:/*Number*/Array):AlchemyComponent {
			var sum:Number = chances[0];
			if (substances) sum += chances[1];
			if (essences) sum += chances[2];
			if (residues) sum += chances[3];
			if (pigments) sum += chances[4];
			if (sum <= 0) return null;
			var x:Number = Math.random()*sum;
			x -= chances[1];
			if (x <= 0) return AlchemyComponent.substance(weightedRandom(substances));
			x -= chances[2];
			if (x <= 0) return AlchemyComponent.essence(weightedRandom(essences));
			x -= chances[3];
			if (x <= 0) return AlchemyComponent.residue(weightedRandom(residues));
			x -= chances[4];
			if (x <= 0) return AlchemyComponent.pigment(weightedRandom(pigments));
			return null;
		}
	}
}
