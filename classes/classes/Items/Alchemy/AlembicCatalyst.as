package classes.Items.Alchemy {
import classes.Items.Useable;
import classes.Scenes.SceneLib;

public class AlembicCatalyst extends Useable {
	public var reagentType:int;
	public var power:int;
	public var chanceFactor:Number;
	public function AlembicCatalyst(id:String, reagentType:int, power:int) {
		this.reagentType = reagentType;
		this.power       = power;
		var shortName:String;
		var longName:String;
		var compName:String;
		switch (reagentType) {
			case AlchemyLib.RT_SUBSTANCE:
				shortName = "Sub.";
				longName  = "substantial";
				compName  = "substance";
				break;
			case AlchemyLib.RT_ESSENCE:
				shortName = "Ess."
				longName  = "essential";
				compName  = "essence";
				break;
			case AlchemyLib.RT_RESIDUE:
				shortName = "Res.";
				longName  = "residual";
				compName  = "residue";
				break;
			case AlchemyLib.RT_PIGMENT:
				shortName = "Pig.";
				longName  = "colorful";
				compName  = "pigment";
				break;
		}
		var value:Number;
		var powerName:String;
		switch (power) {
			case 1:
				shortName = "Min." + shortName;
				longName  = "minor " + longName + " catalyst";
				powerName = "slightly increases";
				value        = 1000;
				chanceFactor = 1.5;
				break;
			case 2:
				shortName = "Cmn." + shortName;
				longName  = "common " + longName + " catalyst";
				powerName = "increases";
				value        = 5000;
				chanceFactor = 2;
				break;
			case 3:
			default:
				shortName = "Maj." + shortName;
				longName  = "major " + longName + " catalyst";
				powerName = "greatly increases";
				value        = 10000;
				chanceFactor = 3;
				break;
		}
		shortName +="ACat";
		var description:String = "This magical crystal, when placed inside an alchemical alembic, " + powerName + " chances to extract " + compName + ". It is not consumed in the process and can be used mmultiple times."
		super(id, shortName, longName, value, description);
	}
	
	override public function useItem():Boolean {
		outputText(description);
		outputText("You examine the magical crystal.");
		outputText("\n\n");
		outputText("<i>This item is used in 'Crafting - Extract' menu.</i>");
		SceneLib.inventory.returnItemToInventory(this);
		return false;
	}
}
}
