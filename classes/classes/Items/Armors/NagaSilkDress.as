package classes.Items.Armors {
import classes.Items.Armor;

public class NagaSilkDress extends Armor {
    private var _name:String;
    public function NagaSilkDress() {
        super("NagaDress","Naga Dress","","a desert naga silk dress",0,0,0,
                "",
        "",false,false);
        setColor();
    }
    public function setColor(color:String="purple"):void
    {
        _name = "desert naga "+color+" and black silk dress";
        _longName = "a "+color+" desert naga silk dress";
        _description = "A very seductive dress made for naga or females without a human set of legs. It has a black collar, bikini top, sleeves with golden bangles and a waistcloth, all decorated with a golden trim. The bottom has a "+color+" silk veil that runs down to what would be the human knee while the center of the bikini is also covered by a small strand of silk. It helps accentuate your curves and increase your natural charm. The dress obviously is so minimalist that you could as well say you are naked yet it looks quite classy on a tauric or naga body giving you the air of a master seducer.";
    }
    public override function get name():String{return _name;}
}
}
