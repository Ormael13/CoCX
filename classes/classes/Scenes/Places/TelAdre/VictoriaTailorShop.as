package classes.Scenes.Places.TelAdre {
import classes.ItemType;
import classes.StatusEffects;
import classes.display.SpriteDb;

public class VictoriaTailorShop extends Shop {
    public function VictoriaTailorShop() {
        story = baseStory.locate("VictoriaTailorShop");
    }

    override public function sprite():void {
        spriteSelect(SpriteDb.s_victoria)
    }

    //-----------------
    //-- TAILOR SHOPPE
    //-----------------
    override protected function inside():void {
        localvars.inside = {metVictoria:player.hasStatusEffect(StatusEffects.Victoria)};
        super.inside();
        if (!player.hasStatusEffect(StatusEffects.Victoria)) {
            //Flag as meeting her
            player.createStatusEffect(StatusEffects.Victoria, 0, 0, 0, 0);
        }
        menu();
        addButton(0, armors.CLSSYCL.shortName, confirmBuy, armors.CLSSYCL);
        addButton(1, armors.RBBRCLT.shortName, confirmBuy, armors.RBBRCLT);
        addButton(2, armors.ADVCLTH.shortName, confirmBuy, armors.ADVCLTH);
        addButton(3, armors.TUBETOP.shortName, confirmBuy, armors.TUBETOP);

        addButton(5, armors.OVERALL.shortName, confirmBuy, armors.OVERALL);
        addButton(6, armors.B_DRESS.shortName, confirmBuy, armors.B_DRESS);
        addButton(7, armors.T_BSUIT.shortName, confirmBuy, armors.T_BSUIT);
        addButton(8, armors.M_ROBES.shortName, confirmBuy, armors.M_ROBES);

        addButton(10, armors.LTHRPNT.shortName, confirmBuy, armors.LTHRPNT);
        addButton(11, armors.BIMBOSK.shortName, confirmBuy, armors.BIMBOSK);
        addButton(12, armors.A_ROBE_.shortName, confirmBuy, armors.A_ROBE_);
        addButton(13, armors.LTHRROB.shortName, confirmBuy, armors.LTHRROB);

        addButton(4, "Next", undergarmentSection);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    protected override function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        clearOutput();
        super.confirmBuy(itype);
        if (player.hasCock() && player.lust >= 33) {
            addButton(4, "Flirt", flirtWithVictoria, itype);
        }
    }

    private function undergarmentSection():void {
        menu();
        addButton(0, undergarments.C_BRA.shortName, confirmBuy, undergarments.C_BRA);
        addButton(1, undergarments.C_PANTY.shortName, confirmBuy, undergarments.C_PANTY);
        addButton(2, undergarments.C_LOIN.shortName, confirmBuy, undergarments.C_LOIN);
        addButton(3, undergarments.FURLOIN.shortName, confirmBuy, undergarments.FURLOIN);

        addButton(5, undergarments.GARTERS.shortName, confirmBuy, undergarments.GARTERS);
        addButton(6, undergarments.LTX_BRA.shortName, confirmBuy, undergarments.LTX_BRA);
        addButton(7, undergarments.LTXSHRT.shortName, confirmBuy, undergarments.LTXSHRT);
        addButton(8, undergarments.LTXTHNG.shortName, confirmBuy, undergarments.LTXTHNG);
        addButton(8, undergarments.LTXTHNG.shortName, confirmBuy, undergarments.LTXTHNG);
        
        addButton(10, armors.C_CLOTH.shortName, confirmBuy, armors.C_CLOTH);

        addButton(9, "Previous", inside);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    //*Typical buy text goes here. Options are now Yes/No/Flirt*

    //[Flirt]
    private function flirtWithVictoria(itype:ItemType):void {
        clearOutput();
        var x:Number = player.cockThatFits(70);
        if (x < 0) {
            x = player.smallestCockIndex();
        }
        display("flirtWithVictoria/intro",{x:x});
        if (x < 0) {
            display("flirtWithVictoria/tooSmall",{x:x});
            doYesNo(curry(debit, itype), inside);
            return;
        }
        display("flirtWithVictoria/scene",{x:x});
        player.orgasm();
        dynStats("sen", -1);
        doNext(camp.returnToCampUseOneHour);
    }
}
}