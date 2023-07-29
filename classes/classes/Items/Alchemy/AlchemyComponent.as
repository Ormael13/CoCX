package classes.Items.Alchemy {
public class AlchemyComponent {
    private static const Dicts:/*Object*/Array = [{},{},{},{},{}];
    
    /**
     * AlchemyLib.CT_XXXX
     */
    public var type:int;
    public var intValue:int;
    public var stringValue:String;
    
	public function AlchemyComponent(type:int, intValue:int, stringValue:String) {
        this.type = type;
        this.intValue = intValue;
        this.stringValue = stringValue;
	}
    
    public function name():String {
        switch (type) {
            case AlchemyLib.CT_SUBSTANCE:
                return AlchemyLib.Substances[intValue].name+" substance";
            case AlchemyLib.CT_ESSENCE:
                return AlchemyLib.Essences[intValue].name+" essence";
            case AlchemyLib.CT_RESIDUE:
                return AlchemyLib.Residues[intValue].name+" residue";
            case AlchemyLib.CT_PIGMENT:
                return stringValue+" pigment";
        }
        return "ERROR "+type+"/"+intValue+"/"+stringValue;
    }
    
    private static function getAC(key:*, type:int, intValue:int, stringValue:String):AlchemyComponent {
        var dict:Object= Dicts[type];
        if(key in dict) return dict[key] as AlchemyComponent;
        return (dict[key] = new AlchemyComponent(type,intValue,stringValue));
    }
    public static function substance(substanceId:int):AlchemyComponent {
        return getAC(substanceId, AlchemyLib.CT_SUBSTANCE, substanceId, null);
    }
    public static function essence(essenceId:int):AlchemyComponent {
        return getAC(essenceId, AlchemyLib.CT_ESSENCE, essenceId, null);
    }
    public static function residue(residueId:int):AlchemyComponent {
        return getAC(residueId, AlchemyLib.CT_RESIDUE, residueId, null);
    }
    public static function pigment(pigmentColor:String):AlchemyComponent {
        return getAC(pigmentColor, AlchemyLib.CT_PIGMENT, 0, pigmentColor);
    }
}
}
