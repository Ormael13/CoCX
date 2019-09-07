package classes.Scenes.Places.TelAdre {
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.ItemType;
import classes.Items.Armor;
import classes.Scenes.SceneLib;

public class YvonneArmorShop extends Shop {
    public function YvonneArmorShop() {
        story = baseStory.locate("YvonneArmorShop");
        sprite = 64;
    }

    //-----------------
    //-- ARMOUR SHOP
    //-----------------
    protected override function inside():void {
        super.inside();
        menu();
        addButton(0,    armors.CHBIKNI.shortName,   confirmBuy, armors.CHBIKNI);
        addButton(1,    armors.FULLCHN.shortName,   confirmBuy, armors.FULLCHN);
        addButton(2,    armors.FULLPLT.shortName,   confirmBuy, armors.FULLPLT);
        addButton(3,    armors.INDECST.shortName,   confirmBuy, armors.INDECST);
        addButton(4,    armors.LTHRROB.shortName,   confirmBuy, armors.LTHRROB);
        addButton(5,    armors.SCALEML.shortName,   confirmBuy, armors.SCALEML);
        addButton(6,    armors.SAMUARM.shortName,   confirmBuy, armors.SAMUARM);
        addButton(7,    shields.BUCKLER.shortName,  confirmBuy, shields.BUCKLER);
        addButton(8,    shields.KITE_SH.shortName,  confirmBuy, shields.KITE_SH);
        addButton(9,    shields.GREATSH.shortName,  confirmBuy, shields.GREATSH);
        addButton(10,   shields.TOWERSH.shortName,  confirmBuy, shields.TOWERSH);

        if (player.hasKeyItem("Dragon Eggshell") >= 0 && player.gems >= 200) {
            addButton(12, "Eggshell", SceneLib.emberScene.getSomeStuff);
        }
        addButton(13, "Flirt", yvonneFlirt);
        addButton(14, "Leave", telAdre.telAdreMenu);
    }
    //[Flirt]
    private function yvonneFlirt():void {
        spriteSelect(64);
        clearOutput();
        display("yvonneFlirt/intro");
        dynStats("lus", (10 + player.lib / 10));
        if (player.cockTotal() == 0 || ((player.tallness > 65 ||player.cockThatFits(75) == -1)&&!flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) ) {
            display("yvonneFlirt/noGo");
            doNext(inside);
            return;
        }
        display("yvonneFlirt/go");
        simpleChoices("Fuck Her", fuckYvonneInZeBlacksmith, "Nevermind", backOutOfYvonneFuck, "", null, "", null, "", null);
    }

    //[Nevermind]
    private function backOutOfYvonneFuck():void {
        clearOutput();
        display("yvonneFlirt/backOut");
        doNext(inside);
    }

    //[Fuck]
    private function fuckYvonneInZeBlacksmith():void {
        spriteSelect(64);
        clearOutput();
        //X = cock that fits!
        var x:Number = player.cockThatFits(75);
        if (x < 0) {
            x = 0;
        }
        display("fuckYvonneInZeBlacksmith",{x:x});
        player.orgasm();
        dynStats("sen", -1);
        flags[kFLAGS.YVONNE_FUCK_COUNTER]++;
        doNext(camp.returnToCampUseOneHour);
    }
}
}
