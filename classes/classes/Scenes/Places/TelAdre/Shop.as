package classes.Scenes.Places.TelAdre {
import classes.ItemType;

public class Shop extends TelAdreAbstractContent {
    protected var sprite:int = -1;

    public function enter():void {
        clearOutput();
        spriteSelect(sprite);
        inside();
    }

    protected function inside():void {
    }

    protected function debit(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        player.gems -= priceOverride >= 0 ? priceOverride : itype.value;
        statScreenRefresh();
        if (keyItem != "") {
            player.createKeyItem(keyItem, 0, 0, 0, 0);
            doNext(inside);
        } else {
            inventory.takeItem(itype, inside);
        }
    }

    protected function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        if (player.gems < priceOverride || player.gems < itype.value) {
            outputText("\n\nYou count out your gems and realize it's beyond your price range.");
            //Goto shop main menu
            doNext(inside);
            return;
        } else {
            outputText("\n\nDo you buy it?\n\n");
        }
        doYesNo(curry(debit, itype, priceOverride, keyItem), curry(noBuyOption, itype, keyItem));
    }

    protected function noBuyOption(itype:ItemType = null, keyItem:String = ""):void {
        inside();
    }
}
}
