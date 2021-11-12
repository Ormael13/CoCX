package classes.Scenes.Combat {
import coc.view.ButtonData;

public class CombatAbility extends BaseCombatContent {
	
	public static const TARGET_SELF:int = 0;
	public static const TARGET_ENEMY:int = 1;
	
	private var _name:String;
	private var _desc:String;
	private var _targetType:int;
	protected var _baseManaCost:Number;
	
	public function CombatAbility(name:String,desc:String,targetType:int) {
		this._name = name;
		this._desc = desc;
		this._targetType = targetType;
	}
	
	public function get name():String {
		return _name;
	}
	
	public function get description():String {
		return _desc
	}
	
	public function get targetType():int {
		return _targetType
	}
	
	public function get buttonName():String {
		return name;
	}
	
	public function createButton():ButtonData {
		const bd:ButtonData = new ButtonData(buttonName, buttonCallback);
		var fullDesc:String = description+"\n";
		// TODO disable if unusable, append costs
		
		if (_baseManaCost > 0) {
			fullDesc += "\nMana Cost: " + manaCost();
		}
		
		var ucheck:String = usabilityCheck();
		if (ucheck != "") {
			fullDesc = ucheck + "\n\n" + fullDesc;
			bd.disable()
		}
		
		bd.hint(fullDesc,name);
		return bd;
	}
	
	public function get isKnown():Boolean {
		return false;
	}
	
	public function get isUsable():Boolean {
		return usabilityCheck() == "";
	}
	
	public function buttonCallback():void {
		combat.callbackBeforeAbility(this);
		perform();
		combat.callbackAfterAbility(this);
	}
	
	public function perform():void {
		useResources();
		if (!monster.interceptPlayerAbility(this)) {
			doEffect();
			monster.postPlayerAbility(this);
		}
	}
	
	/**
	 * 1st part: use mana, set cooldown, increment counters etc.
	 */
	protected function useResources():void {
	
	}
	
	/**
	 * 2nd part: actual ability effect
	 */
	protected function doEffect():void {
		throw new Error("Method perform() not implemented for ability "+name);
	}
	
	public function get baseManaCost():Number {
		return _baseManaCost;
	}
	
	public function manaCost():Number {
		return _baseManaCost;
	}
	
	public function get currentCooldown():int {
		return 0
	}
	
	/**
	 * @return String "" is this ability is usable, otherwise reason why it's not
	 */
	protected function usabilityCheck():String {
		// Checks applicable to all abilities could go here
		if (currentCooldown > 0) {
			return "You need more time before you can use this ability again."
		}
		return ""
	}
	
}
}
