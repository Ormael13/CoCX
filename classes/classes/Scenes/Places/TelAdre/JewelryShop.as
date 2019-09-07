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
        addButton(2, "Ench. rings", enchantedRings1);
        addButton(3, "Ench. rings", enchantedRings2);
        addButton(4, "Other materials", otherMaterials);
		addButton(5, "Other jewelries", normalRings2);
		addButton(6, "Other jewelries", normalRings3);
		//3 i 4 for necklaces and head accesories - maybe more buttons then move Jewelry Box i statue do niższego rzedu
        addButton(10, "Jewelry box",curry(confirmBuy, null, 500, "Equipment Storage - Jewelry Box"));
        addButton(11, useables.GLDSTAT.shortName, confirmBuy, useables.GLDSTAT);
		addButton(14, "Leave", telAdre.telAdreMenu);
    }
    private function normalRings2():void {
        clearOutput();
        menu();
        var button:int = 0;
        addButton(button++, headjewelries.FIRECRO.shortName, confirmBuy, headjewelries.FIRECRO);
        addButton(button++, headjewelries.ICECROW.shortName, confirmBuy, headjewelries.ICECROW);
        addButton(button++, headjewelries.LIGHCRO.shortName, confirmBuy, headjewelries.LIGHCRO);
        addButton(button++, headjewelries.DARKCRO.shortName, confirmBuy, headjewelries.DARKCRO);
        addButton(button++, headjewelries.POISCRO.shortName, confirmBuy, headjewelries.POISCRO);
        addButton(button++, headjewelries.LUSTCRO.shortName, confirmBuy, headjewelries.LUSTCRO);
        addButton(button++, necklaces.FIRENEC.shortName, confirmBuy, necklaces.FIRENEC);
        addButton(button++, necklaces.ICENECK.shortName, confirmBuy, necklaces.ICENECK);
        addButton(button++, necklaces.LIGHNEC.shortName, confirmBuy, necklaces.LIGHNEC);
        addButton(button++, necklaces.DARKNEC.shortName, confirmBuy, necklaces.DARKNEC);
        addButton(button++, necklaces.POISNEC.shortName, confirmBuy, necklaces.POISNEC);
        addButton(button++, necklaces.LUSTNEC.shortName, confirmBuy, necklaces.LUSTNEC);
        addButton(14, "Back", inside);
    }
    private function normalRings3():void {
        clearOutput();
        menu();
        var button:int = 0;
        addButton(button++, headjewelries.CROWINT.shortName, confirmBuy, headjewelries.CROWINT);
        addButton(button++, headjewelries.CROWLIB.shortName, confirmBuy, headjewelries.CROWLIB);
        addButton(button++, headjewelries.CROWSEN.shortName, confirmBuy, headjewelries.CROWSEN);
        addButton(button++, headjewelries.CROWSPE.shortName, confirmBuy, headjewelries.CROWSPE);
        addButton(button++, headjewelries.CROWSTR.shortName, confirmBuy, headjewelries.CROWSTR);
        addButton(button++, headjewelries.CROWTOU.shortName, confirmBuy, headjewelries.CROWTOU);
        addButton(button++, headjewelries.CROWWIS.shortName, confirmBuy, headjewelries.CROWWIS);
        addButton(button++, necklaces.NECKINT.shortName, confirmBuy, necklaces.NECKINT);
        addButton(button++, necklaces.NECKLIB.shortName, confirmBuy, necklaces.NECKLIB);
        addButton(button++, necklaces.NECKSEN.shortName, confirmBuy, necklaces.NECKSEN);
        addButton(button++, necklaces.NECKSPE.shortName, confirmBuy, necklaces.NECKSPE);
        addButton(button++, necklaces.NECKSTR.shortName, confirmBuy, necklaces.NECKSTR);
        addButton(button++, necklaces.NECKTOU.shortName, confirmBuy, necklaces.NECKTOU);
        addButton(button++, necklaces.NECKWIS.shortName, confirmBuy, necklaces.NECKWIS);
        addButton(14, "Back", inside);
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
    private function enchantedRings1():void{
        clearOutput();
        display("enchantedRings");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.CRIMRNG.shortName, confirmBuy, jewelries.CRIMRNG);
        addButton(button++, jewelries.FERTRNG.shortName, confirmBuy, jewelries.FERTRNG);
        addButton(button++, jewelries.ICE_RNG.shortName, confirmBuy, jewelries.ICE_RNG);
        addButton(button++, jewelries.MYSTRNG.shortName, confirmBuy, jewelries.MYSTRNG);
        addButton(button++, jewelries.POWRRNG.shortName, confirmBuy, jewelries.POWRRNG);
        addButton(button++, jewelries.RPOWRNG.shortName, confirmBuy, jewelries.RPOWRNG);
        addButton(button++, jewelries.LIFERNG.shortName, confirmBuy, jewelries.LIFERNG);
        addButton(button++, jewelries.WRATRNG.shortName, confirmBuy, jewelries.WRATRNG);
        addButton(button++, jewelries.MANARNG.shortName, confirmBuy, jewelries.MANARNG);
        addButton(14,"Back",inside);
    }
    private function enchantedRings2():void{
        clearOutput();
        display("enchantedRings");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.RINGINT.shortName, confirmBuy, jewelries.RINGINT);
        addButton(button++, jewelries.RINGLIB.shortName, confirmBuy, jewelries.RINGLIB);
        addButton(button++, jewelries.RINGSEN.shortName, confirmBuy, jewelries.RINGSEN);
        addButton(button++, jewelries.RINGSPE.shortName, confirmBuy, jewelries.RINGSPE);
        addButton(button++, jewelries.RINGSTR.shortName, confirmBuy, jewelries.RINGSTR);
        addButton(button++, jewelries.RINGTOU.shortName, confirmBuy, jewelries.RINGTOU);
        addButton(button++, jewelries.RINGWIS.shortName, confirmBuy, jewelries.RINGWIS);
        addButton(button++, jewelries.FIRERNG.shortName, confirmBuy, jewelries.FIRERNG);
        addButton(button++, jewelries.ICERNG.shortName, confirmBuy, jewelries.ICERNG);
        addButton(button++, jewelries.LIGHRNG.shortName, confirmBuy, jewelries.LIGHRNG);
        addButton(button++, jewelries.DARKRNG.shortName, confirmBuy, jewelries.DARKRNG);
        addButton(button++, jewelries.POISRNG.shortName, confirmBuy, jewelries.POISRNG);
        addButton(button++, jewelries.LUSTRNG.shortName, confirmBuy, jewelries.LUSTRNG);
        addButton(14,"Back",inside);
    }
    private function otherMaterials():void {
        clearOutput();
        //display("normalRings");
        menu();
        var button:int = 0;
        addButton(button++, useables.AMETIST.shortName, confirmBuy, useables.AMETIST);
        addButton(button++, useables.DIAMOND.shortName, confirmBuy, useables.DIAMOND);
        addButton(button++, useables.S_INGOT.shortName, confirmBuy, useables.S_INGOT);
        addButton(14, "Back", inside);
    }
}
}
