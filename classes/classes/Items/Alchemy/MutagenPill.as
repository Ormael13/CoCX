package classes.Items.Alchemy {
import classes.Items.Consumable;
import classes.Transformations.PossibleEffect;
import classes.internals.EnumValue;

public class MutagenPill extends Consumable {
	public var pillEffect:PossibleEffect;
	public var power:int;
	
	public function MutagenPill(id:String, params:Object) {
		var tfId:String = String(params.tf);
		var power:int = params.p;
		pillEffect = PossibleEffect.findEffect(tfId);
		this.power = power;
		
		var shortName:String;
		var longName:String;
		var description:String;
		var value:Number = 6;
		
		if (pillEffect) {
			var powerMeta:EnumValue = AlchemyLib.PillPowerTiers[power];
			
			shortName   = pillEffect.alchemyShortName + powerMeta.short;
			longName    = powerMeta.name + " "+pillEffect.alchemyLongName + " pill";
			description = "This pill will apply " + pillEffect.alchemyLongName + " transformation with " + powerMeta.chance + "% chance.";
		} else {
			shortName = "ERROR Pill";
			longName = "ERROR Pill "+tfId;
			description = "ERROR: Malformed item "+id;
		}
		
		super(id, shortName, longName, Math.round(value), description);
	}
	
	override public function get ownIconId():String {
		return "I_"+templateId()+"_"+power;
	}
	override public function canUse():Boolean {
		if (player.blockingBodyTransformations()){
			outputText("Your body is immune to any and all transformations.");
			return false;
		}
		return true;
	}
	
	override public function useItem():Boolean {
		clearOutput();
		outputText("You swallow the "+longNameBase+". You feel warmth spreading from your stomach...\n\n");
		if (pillEffect && (Math.random()*100 < AlchemyLib.PillPowerTiers[power].chance)) {
			pillEffect.applyEffect(true);
		} else {
			outputText("However, it quickly fades away. ");
		}
		return false;
	}
}
}
