package classes.Scenes.Places.TelAdre {
import classes.CoC;
import classes.ItemType;

import coc.xxc.BoundStory;
import classes.GlobalFlags.kFLAGS;

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

    protected function debit(itype:ItemType = null, priceOverride:int = -1, keyItem:String = "", priceRate:Number = 1, useStones:Boolean = false, currentQuantity:int = 1):void {
        clearOutput();
        menu();
        if(localvars.debit == undefined){localvars.debit = {};}
        localvars.debit.itype = itype;
        localvars.debit.priceOverride = priceOverride;
        localvars.debit.keyItem = keyItem;
        localvars.debit.priceRate = priceRate;
        localvars.debit.useStones = useStones;
        localvars.debit.currentQuantity = currentQuantity;
        display("debit",localvars.debit);

        /*player.gems -= priceOverride >= 0 ? priceOverride : itype.value;
        statScreenRefresh();
        if (keyItem != "") {
            player.createKeyItem(keyItem, 0, 0, 0, 0);
            doNext(inside);
        } else {
            inventory.takeItem(itype, inside);
        }*/

        var wallet:int;
        var costPerItem:int;
        var debitFunction:Function;
        var paymentMethod:String = useStones? "spirit stones": "gems";
        var baseValue:int = (priceOverride >= 0)? priceOverride: itype.value;

        if (useStones) {
            wallet = flags[kFLAGS.SPIRIT_STONES];
            costPerItem = baseValue / priceRate;
            debitFunction = function (cost:int):void {
                flags[kFLAGS.SPIRIT_STONES] -= cost;
            };
        } else {
            wallet = player.gems;
            costPerItem = baseValue * priceRate;
            debitFunction = function (cost:int):void {
                player.gems -= cost;
            };
        }

        var value:int = costPerItem * currentQuantity;

        if (wallet < value) {
            clearOutput();
            if (!display("tooPoor",localvars.debit)) {
                outputText("\n\nYou count out your gems and realize it's beyond your price range. You need " + String(value - wallet) + " more " + paymentMethod + " to purchase this item.");
            }
            doNext(inside);
            return;
        }

        debitFunction(value);
        statScreenRefresh();
        if (keyItem != "") {
            player.createKeyItem(keyItem, 0, 0, 0, 0);
            doNext(inside);
        } else {
            var amountDeposited:int = inventory.tryAddMultipleItemsToPlayer(itype, currentQuantity);
            outputText("You place " + amountDeposited + " of them in your bag, leaving you with " + player.itemCount(itype) + " of them.");

            if(amountDeposited < currentQuantity) {
                var amountToRefund:int = (currentQuantity - amountDeposited) * costPerItem;
                debitFunction(-amountToRefund);
                statScreenRefresh();
            }
            doNext(inside);
            return;
        }
    }

    protected function confirmation(itype:ItemType = null, priceOverride:int = -1, keyItem:String = "", priceRate:Number = 1, useStones:Boolean = false, currentQuantity:int = 1):void {
        clearOutput();

        if(localvars.confirmation == undefined){localvars.confirmation = {};}
        localvars.confirmation.itype = itype;
        localvars.confirmation.keyItem = keyItem;
        localvars.confirmation.priceOverride = priceOverride;
        localvars.confirmation.priceRate = priceRate;
        localvars.confirmation.useStones = useStones;
        localvars.confirmation.currentQuantity = currentQuantity;
        if (!display("confirmation",localvars.confirmation)) {
            outputText("Do you buy it?\n\n");
        }
        
        var returnFunc:Function;
        if (keyItem != "") {
            returnFunc = inside;
        } else {
            returnFunc = curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity);
        }
        
        doYesNo(curry(debit, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity),
        returnFunc);
    }

    protected function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = "", priceRate:Number = 1, useStones:Boolean = false, currentQuantity:int = 1):void {
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
        localvars.confirmBuy.priceRate = priceRate;
        localvars.confirmBuy.useStones = useStones;
        localvars.confirmBuy.currentQuantity = currentQuantity;
        display("confirmBuy",localvars.confirmBuy);

        //Skip straight to confirmation for key item purchases
        if (keyItem != "") {
            confirmation(itype, priceOverride, keyItem, priceRate, useStones, currentQuantity);
            return;
        }

        var costPerItem:int = (useStones)? itype.value / priceRate: itype.value * priceRate;
        var wallet:int = (useStones)? flags[kFLAGS.SPIRIT_STONES]: player.gems;

        var roomLeftInBag:int = player.roomForItem(itype);
        var maxBuy:int = Math.floor(wallet / costPerItem);
        var maxQuanity:int = Math.min(roomLeftInBag, maxBuy);
        var paymentMethod:String = (useStones)? "spirit stones" : "gems";
        

        if (currentQuantity < 1) {
            currentQuantity = 1;
        }
        if (currentQuantity > maxQuanity){
            currentQuantity = maxQuanity;
        }

        /*if (player.gems < priceOverride || (itype && player.gems < itype.value)) {
            outputText("\n\nYou count out your gems and realize it's beyond your price range.");
            //Goto shop main menu
            doNext(inside);
            return;
        } else {
            outputText("\n\nDo you buy it?\n\n");
        }
        doYesNo(curry(debit, itype, priceOverride, keyItem), curry(noBuyOption, itype, keyItem)); */
        outputText("\n\n");
        outputText("Currently buying: " + itype.longName + "\n");
        outputText("Maximum amount: " + maxQuanity + "\n");
        outputText("Quanity: " + currentQuantity + "\n");
        if (maxBuy != 0) {
            outputText("Cost: " + String(costPerItem * currentQuantity) + " " + paymentMethod + "\n");
        } else {
            outputText("This item costs " + String(costPerItem) + " " + paymentMethod + ".\n");
            outputText("You need " + String(costPerItem - wallet) + " more " + paymentMethod + " to buy this item.\n");
        }

        menu();
        addButton(0, "Subtract 1", curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity - 1))
            .disableIf(currentQuantity <= 1, "Minimum Quantity reached");
        addButton(1, "Add 1", curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity + 1))
            .disableIf(currentQuantity == maxQuanity, "Maximum Quantity reached");
        addButton(5, "Subtract 5", curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity - 5))
            .disableIf(currentQuantity <= 1, "Minimum Quantity reached");
        addButton(6, "Add 5", curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity + 5))
            .disableIf(currentQuantity == maxQuanity, "Maximum Quantity reached");

        addButton(4, "1", curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, 1))
            .disableIf(currentQuantity <= 1, "Minimum Quantity reached");
        addButton(9, "Max", curry(confirmBuy, itype, priceOverride, keyItem, priceRate, useStones, maxQuanity))
            .disableIf(currentQuantity == maxQuanity, "Maximum Quantity reached");

        addButton(13, "Buy", curry(confirmation, itype, priceOverride, keyItem, priceRate, useStones, currentQuantity))
            .disableIf(roomLeftInBag == 0, "You have no space left in your bag")
            .disableIf(maxBuy == 0, "You do not have enough to buy this item");
        addButton(14, "Return", inside);
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