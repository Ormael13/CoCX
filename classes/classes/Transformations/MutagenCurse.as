package classes.Transformations {
public class MutagenCurse extends PossibleEffect {
	public var statName:String;
	public var curseAmount:Number;
	public var text:String;
	private var isPossibleFn:Function;
	
	public function MutagenCurse(
			effectName:String,
			statName:String,
			curseAmount:Number,
			text:String,
			isPossibleFn:Function = null
	) {
		super(effectName);
		this.statName   = statName;
		this.curseAmount = curseAmount;
		this.text       = text;
		this.isPossibleFn = isPossibleFn;
	}
	
	
	override public function isPossible():Boolean {
		return (isPossibleFn != null) ? isPossibleFn() : true;
	}
	
	override public function applyEffect(doOutput:Boolean = true):void {
		if (doOutput) {
			outputText(text);
		}
		player.addCurse(statName, curseAmount, 1);
	}
}
}
