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
        var n:String = name();
        if (n.indexOf("ERROR") == 0) throw new Error("Invalid AlchemyReagent "+n);
	}

    public function name():String {
        switch (type) {
            case AlchemyLib.RT_SUBSTANCE:
                return (AlchemyLib.Substances[intValue] || {name: "ERROR " + intValue})["name"]+" substance";
            case AlchemyLib.RT_ESSENCE:
                return (AlchemyLib.Essences[intValue] || {name: "ERROR " + intValue})["name"]+" essence";
            case AlchemyLib.RT_RESIDUE:
                return (AlchemyLib.Residues[intValue] || {name: "ERROR " + intValue})["name"]+" residue";
            case AlchemyLib.RT_PIGMENT:
                return stringValue+" pigment";
        }
        return "ERROR "+type+"/"+intValue+"/"+stringValue;
    }

    public function key():* {
        return (type == AlchemyLib.RT_PIGMENT) ? stringValue : intValue;
    }

    private static function getAC(key:*, type:int, intValue:int, stringValue:String):AlchemyReagent {
        var dict:Object= Dicts[type];
        if(key in dict) return dict[key] as AlchemyReagent;
        return (dict[key] = new AlchemyReagent(type,intValue,stringValue));
    }
    public static function getReagent(type:int, value:*):AlchemyReagent {
        if (type == AlchemyLib.RT_PIGMENT) {
            return getAC(value, type, 0, String(value));
        } else {
            return getAC(value, type, int(value), null);
        }
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
