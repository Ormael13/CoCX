package classes.Scenes.Places.TelAdre {
import classes.ItemType;

public class JewelryShop extends Shop {
    public static var firstEntry:Boolean = true;

    public function JewelryShop() {
    }

    //-----------------
    //-- JEWELRY STORE
    //-----------------
    public override function enter():void {
        spriteSelect(sprite);
        clearOutput();
        outputText("You enter the jewelry store. " +
                "There are large array of rings and necklaces, all stored in thick glass cases. " +
                "A male lizan sits behind the counter, watching you as you look around the store. " +
                "He is nude save for his gilded silken loincloth and a gold necklace. " +
                "His chin is pierced with several gold ring piercings. " +
                "He also wears a diamond ring on one of his fingers.\n\n" +
                "<i>\"Welcome to my jewelry store. Here, I sell rings and necklaces. " +
                "They can make you look great but not only that, I also have special jewelry that may have magical " +
                "effect on you. The effect stays on until you take them off,\"</i> the lizan says.");
        doNext(inside);
    }

    protected override function inside():void {
        clearOutput();
        outputText("<i>So what will it be?</i>");
        menu();
        addButton(0, "Normal rings", jewelShopPageI);
        addButton(1, "Enchanted rings", jewelShopPageII);
        addButton(3, "Taoth statue", createCallBackFunction(confirmBuy, useables.GLDSTAT));
        addButton(4, "Jewelry box", curry(confirmBuy, null, 500, "Equipment Storage - Jewelry Box"));
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    protected override function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        clearOutput();
        if (keyItem == "Equipment Storage - Jewelry Box") {
            if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) {
                outputText("<b>You already own a jewelry box!</b>");
                doNext(inside);
                return;
            }
            outputText("You look around for a while until you see something that catches your eyes. " +
                    "A finely-polished jewelry box sits on table.  You approach the jewelry box and examine it. " +
                    "The box comes complete with a hinged lid and several small drawers. " +
                    "The price tag says that it costs 500 gems.\n\n" +
                    "The lizan then walks over to you and asks \"<i>See something you'd like to buy?</i>\" " +
                    "You then ask him about the jewelry box. \n\n" +
                    "\"<i>We have plenty of them. This is a finely crafted box. " +
                    "It's designed to hold nine different rings and amulets. " +
                    "Of course, it's secure! It has combination lock. With the right code, you can unlock it. " +
                    "And it can be yours for only 500 gems!</i>\"\n\n");
        } else if (itype == useables.GLDSTAT) {
            outputText("\"<i>Oh so you want this statue? Sure I can sell it to you but I hope you have two thousand gems.</i>\"\n\n");
        } else {
            outputText("The lizan escorts you and opens the case to retrieve the ring. " +
                    "He shows you the ring. He says \"<i>That will be... uh... " + itype.value + " gems.</i>\"");
        }
        super.confirmBuy(itype, priceOverride, keyItem);
    }

    protected override function noBuyOption(itype:ItemType = null, keyItem:String = ""):void {
        clearOutput();
        outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
        outputText("\"<i>Very well. Let me know if you've changed your mind,</i>\" he says.");
        doNext(inside);
    }

    protected override function debit(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        if (keyItem == "Equipment Storage - Jewelry Box") {
            outputText("You hand over five hundred gems to the lizan. " +
                    "He then exclaims\"<i>Sold!</i>\" as he hands over the jewelry box to you. " +
                    "You take your time to set the combination and memorize it should you need to access your jewelry box." +
                    "\n\n<b>Gained Key Item: Jewelry Box!</b>");
        }
        super.debit(itype, priceOverride, keyItem);
    }

    private function jewelShopPageI():void {
        choices(jewelries.SILVRNG.shortName, createCallBackFunction(confirmBuy, jewelries.SILVRNG),
                jewelries.GOLDRNG.shortName, createCallBackFunction(confirmBuy, jewelries.GOLDRNG),
                jewelries.PLATRNG.shortName, createCallBackFunction(confirmBuy, jewelries.PLATRNG),
                jewelries.DIAMRNG.shortName, createCallBackFunction(confirmBuy, jewelries.DIAMRNG),
                jewelries.LTHCRNG.shortName, createCallBackFunction(confirmBuy, jewelries.LTHCRNG),
                "", null,
                "", null,
                "", null,
                "", null,
                "", null);
        addButton(14, "Back", inside);
    }

    private function jewelShopPageII():void {
        choices(jewelries.CRIMRNG.shortName, createCallBackFunction(confirmBuy, jewelries.CRIMRNG),
                jewelries.ICE_RNG.shortName, createCallBackFunction(confirmBuy, jewelries.ICE_RNG),
                jewelries.FERTRNG.shortName, createCallBackFunction(confirmBuy, jewelries.FERTRNG),
                jewelries.MANARNG.shortName, createCallBackFunction(confirmBuy, jewelries.MANARNG),
                jewelries.LIFERNG.shortName, createCallBackFunction(confirmBuy, jewelries.LIFERNG),
                jewelries.POWRRNG.shortName, createCallBackFunction(confirmBuy, jewelries.POWRRNG),
                jewelries.PURERNG.shortName, createCallBackFunction(confirmBuy, jewelries.PURERNG),
                jewelries.MYSTRNG.shortName, createCallBackFunction(confirmBuy, jewelries.MYSTRNG),
                "", null,
                "", null);
        addButton(14, "Back", inside);
    }
}
}
