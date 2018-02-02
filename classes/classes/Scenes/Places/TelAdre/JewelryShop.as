package classes.Scenes.Places.TelAdre {
/**
 * Updated strings
 * @ContentAuthor Starglider
 */
public class JewelryShop extends Shop {
    public static var firstEntry:Boolean = true;

    public function JewelryShop() {
        story = baseStory.locate("JewelryShop");
        localvars.enter = {firstEntry:firstEntry};
        firstEntry=false;
    }

    //-----------------
    //-- JEWELRY STORE
    //-----------------

    protected override function inside():void {
        super.inside();
        addButton(0, "Normal rings", normalRings);
        addButton(1, "Special rings", specialRings);
        addButton(2, "Enchanted rings", enchantedRings);
        addButton(5, "Jewelry box",curry(confirmBuy, null, 500, "Equipment Storage - Jewelry Box"));
        addButton(6, useables.GLDSTAT.shortName, confirmBuy, useables.GLDSTAT);
		addButton(14, "Leave", telAdre.telAdreMenu);
    }
    private function normalRings():void {
        clearOutput();
        display("normalRings");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.SILVRNG.shortName, confirmBuy, jewelries.SILVRNG);
        addButton(button++, jewelries.GOLDRNG.shortName, confirmBuy, jewelries.GOLDRNG);
        addButton(button++, jewelries.PLATRNG.shortName, confirmBuy, jewelries.PLATRNG);
        addButton(button++, jewelries.DIAMRNG.shortName, confirmBuy, jewelries.DIAMRNG);
        addButton(14, "Back", inside);
    }
    private function specialRings():void {
        clearOutput();
        display("specialRings");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.LTHCRNG.shortName, confirmBuy, jewelries.LTHCRNG);
        addButton(button++, jewelries.PURERNG.shortName, confirmBuy, jewelries.PURERNG);
        addButton(14, "Back", inside);
    }
    private function enchantedRings():void{
        clearOutput();
        display("enchantedRings");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.CRIMRNG.shortName, confirmBuy, jewelries.CRIMRNG);
        addButton(button++, jewelries.FERTRNG.shortName, confirmBuy, jewelries.FERTRNG);
        addButton(button++, jewelries.ICE_RNG.shortName, confirmBuy, jewelries.ICE_RNG);
        addButton(button++, jewelries.MANARNG.shortName, confirmBuy, jewelries.MANARNG);
        addButton(button++, jewelries.LIFERNG.shortName, confirmBuy, jewelries.LIFERNG);
        addButton(button++, jewelries.MYSTRNG.shortName, confirmBuy, jewelries.MYSTRNG);
        addButton(button++, jewelries.POWRRNG.shortName, confirmBuy, jewelries.POWRRNG);
        addButton(14,"Back",inside);
    }
}
}
