package classes.Items.Alchemy {
import classes.Items.Useable;

public class AlembicCatalyst extends Useable {
	public var componentType:int;
	public var power:int;
	public var chanceFactor:Number;
	public function AlembicCatalyst(id:String, componentType:int, power:int) {
		this.componentType = componentType;
		this.power = power;
		var shortName:String;
		var longName:String;
		var compName:String;
		switch (componentType) {
			case AlchemyLib.CT_SUBSTANCE:
				shortName = "Sub.";
				longName  = "substantial";
				compName  = "substance";
				break;
			case AlchemyLib.CT_ESSENCE:
				shortName = "Ess."
				longName  = "essential";
				compName  = "essence";
				break;
			case AlchemyLib.CT_RESIDUE:
				shortName = "Res.";
				longName  = "residual";
				compName  = "residue";
				break;
			case AlchemyLib.CT_PIGMENT:
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
		var description:String = "This magical crystal, when placed inside alchemical alembic, " + powerName + " chances to extract " + compName + ". It is not consumed in the process and can be used muliple times."
		super(id, shortName, longName, value, description);
	}
	
	override public function useItem():Boolean {
		outputText(description);
		outputText("\n\n");
		outputText("<b>This item is used in 'Crafting - Extract' menu.</b>");
		return false;
	}
}
}
