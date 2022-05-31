package classes.Scenes.Places.TelAdre {
import classes.CoC;
import classes.ItemType;

import coc.xxc.BoundStory;

public class Shop extends TelAdreAbstractContent {
    protected var story:BoundStory;
    protected var localvars:Object = {};
    private static var _baseStory:BoundStory;

    public function sprite():void {
        spriteSelect(null);
    }
    protected function get baseStory():BoundStory{
        if(!_baseStory){
            _baseStory = CoC.instance.rootStory.locate("teladreshops").bind(CoC.instance.context);
        }
        return _baseStory;
    }

    public function enter():void {
        clearOutput();
        menu();
        sprite();
        if(display("enter",localvars.enter)){
            doNext(inside);
            return;
        }
        inside();
    }

    protected function inside():void {
        clearOutput();
        menu();
        display("inside",localvars.inside);
        doNext(telAdre.telAdreMenu);
    }

    protected function debit(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        clearOutput();
        menu();
        if(localvars.debit == undefined){localvars.debit = {};}
        localvars.debit.itype = itype;
        localvars.debit.priceOverride = priceOverride;
        localvars.debit.keyItem = keyItem;
        display("debit",localvars.debit);
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
        clearOutput();
        menu();
        if(keyItem != "" && player.hasKeyItem(keyItem)>=0){
            var i:int = keyItem.indexOf("-");
            if(i>=0){keyItem = keyItem.substr(i+2);}
            keyItem=keyItem.toLowerCase();
            outputText("<b>You already own a "+keyItem+"!</b>");
            doNext(inside);
            return;
        }

        if(localvars.confirmBuy == undefined){localvars.confirmBuy = {};}
        localvars.confirmBuy.itype = itype;
        localvars.confirmBuy.keyItem = keyItem;
        localvars.confirmBuy.priceOverride = priceOverride;
        display("confirmBuy",localvars.confirmBuy);

        if (player.gems < priceOverride || (itype && player.gems < itype.value)) {
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
        if(localvars.noBuyOption == undefined){localvars.noBuyOption = {};}
        localvars.noBuyOption.itype = itype;
        localvars.noBuyOption.keyItem = keyItem;
        if(display("noBuyOption",localvars.noBuyOption)){doNext(inside);}
        else inside();
    }
    protected function display(ref:String,locals:Object=null):Boolean{
        if(!story) return false;
        try {
            story.display(ref,locals);
            return true;
        } catch (e:Error){
            trace(e.message + " with locals "+locals);
        }
        return false;
    }
}
}