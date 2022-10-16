package classes.GeneticMemories {
	import classes.BaseContent;
import classes.Enum;
import classes.StatusEffects;
	import classes.BodyParts.*;
	import classes.BodyParts.Horns;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;
	import classes.Races.*;
	import classes.GeneticMemories.*;

	public class RaceMem extends BaseContent {
	/**
	 * Entry properties:
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - name: how the Metamorph is referred to in displayed texts
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - unlockText: additional text displayed when Metamorph is unlocked
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button
	 * - lockedInfo: additional text to be shown on *locked* Metamorphs when hovering over a button
	 * - permCost: how many Ascension Perk Points it costs to permanentize this Metamorph, defaults to 5 if not added
	 * - permReq: the ID of another Metamorph which must be permanentized first before the current one can be bought

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			id: [Name Saved in GeneticStorage],
			name: [Name Displayed in Texts],
			cost: [Cost Here],
			title: [Race Here],
			unlockText: [Text Displayed On Unlocking Metamorph Here],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */
	//TODO: Khovel - This lets them show up in the Metamorph Menu
		public static var Memories:/*EnumValue*/ Array = [];
		private static var _partid:int = 0;
		private static var metamorphCost:int = 5000;
		private static var permMetaCost:int = 50;

		// this
		public static function appendEnumVal(name:String, transform:Transformation):int{
			var id:String =  name + " Complete";
			var newRace:int = _partid++;
			var metaCost:int = metamorphCost;
			var permCost:int = permMetaCost;
			if(name == "Human"){
				metaCost *= 2;
				id = "Unlocked Metamorph";
                permCost = 0;
            }
			EnumValue.add(Memories, newRace, name, {
				id: id,
				name: name,
				cost: metaCost,
				title: name,
                permCost:permCost,
				transformation:function(): Transformation{
					return transform;
				}
			});

			return newRace;
		}

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
