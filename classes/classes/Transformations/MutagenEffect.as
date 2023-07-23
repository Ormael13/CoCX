package classes.Transformations {
public class MutagenEffect extends PossibleEffect {
	public var statName:String;
	public var buffAmount:Number;
	public var text:String;
	private var isPossibleFn:Function;
	
	public function MutagenEffect(
			effectName:String,
			statName:String,
			buffAmount:Number,
			text:String,
			isPossibleFn:Function = null
	) {
		super(effectName);
		this.statName   = statName;
		this.buffAmount = buffAmount;
		this.text       = text;
		this.isPossibleFn = isPossibleFn;
	}
	
	
	override public function isPossible():Boolean {
		return (isPossibleFn != null) ? isPossibleFn() && MutagenBonus(statName, buffAmount, false) : MutagenBonus(statName, buffAmount, false);
	}
	
	override public function applyEffect(doOutput:Boolean = true):void {
		if (doOutput) {
			outputText(text);
		}
		MutagenBonus(statName, buffAmount);
	}
}
}
