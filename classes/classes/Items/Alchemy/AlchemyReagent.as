package classes.Items.Alchemy {
public class AlchemyReagent {
    private static const Dicts:/*Object*/Array = [{},{},{},{},{}];
    
    /**
     * AlchemyLib.CT_XXXX
     */
    public var type:int;
    public var intValue:int;
    public var stringValue:String;
    
	public function AlchemyReagent(type:int, intValue:int, stringValue:String) {
        this.type = type;
        this.intValue = intValue;
        this.stringValue = stringValue;
	}
    
    public function name():String {
        switch (type) {
            case AlchemyLib.RT_SUBSTANCE:
                return AlchemyLib.Substances[intValue].name+" substance";
            case AlchemyLib.RT_ESSENCE:
                return AlchemyLib.Essences[intValue].name+" essence";
            case AlchemyLib.RT_RESIDUE:
                return AlchemyLib.Residues[intValue].name+" residue";
            case AlchemyLib.RT_PIGMENT:
                return stringValue+" pigment";
        }
        return "ERROR "+type+"/"+intValue+"/"+stringValue;
    }
    
    private static function getAC(key:*, type:int, intValue:int, stringValue:String):AlchemyReagent {
        var dict:Object= Dicts[type];
        if(key in dict) return dict[key] as AlchemyReagent;
        return (dict[key] = new AlchemyReagent(type,intValue,stringValue));
    }
    public static function substance(substanceId:int):AlchemyReagent {
        return getAC(substanceId, AlchemyLib.RT_SUBSTANCE, substanceId, null);
    }
    public static function essence(essenceId:int):AlchemyReagent {
        return getAC(essenceId, AlchemyLib.RT_ESSENCE, essenceId, null);
    }
    public static function residue(residueId:int):AlchemyReagent {
        return getAC(residueId, AlchemyLib.RT_RESIDUE, residueId, null);
    }
    public static function pigment(pigmentColor:String):AlchemyReagent {
        return getAC(pigmentColor, AlchemyLib.RT_PIGMENT, 0, pigmentColor);
    }
}
}
