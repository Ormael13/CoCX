package classes.Scenes.Places.TelAdre {
import classes.GlobalFlags.kFLAGS;
import classes.ItemType;

public class WeaponShop extends Shop {
    public function WeaponShop() {
        story = baseStory.locate("WeaponShop");
        sprite = 80;
    }

    //-----------------
    //-- WEAPON SHOP
    //-----------------
    override protected function inside():void {
        super.inside();
        addButton(0, weapons.CLAYMOR.shortName, confirmBuy, weapons.CLAYMOR);
        addButton(1, weapons.WARHAMR.shortName, confirmBuy, weapons.WARHAMR);
        addButton(2, weapons.BFSWORD.shortName, confirmBuy, weapons.BFSWORD);
        addButton(3, weapons.SPEAR.shortName, confirmBuy, weapons.SPEAR);
        addButton(4, weapons.LANCE.shortName, confirmBuy, weapons.LANCE);
        addButton(5, weapons.SCIMITR.shortName, confirmBuy, weapons.SCIMITR);
        addButton(6, weapons.MACE.shortName, confirmBuy, weapons.MACE);
        addButton(7, weapons.FLAIL.shortName, confirmBuy, weapons.FLAIL);
		addButton(8, weapons.HALBERD.shortName, confirmBuy, weapons.HALBERD);
		addButton(9, weapons.DSWORD_.shortName, confirmBuy, weapons.DSWORD_);
        addButton(10, weapons.D_WHAM_.shortName, confirmBuy, weapons.D_WHAM_);
        if (player.hasKeyItem("Sheila's Lethicite") >= 0 || flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] > 0) {
            addButton(13, "ScarBlade", forgeScarredBlade);
        }
        addButton(14, "Leave", telAdre.telAdreMenu);
    }

    private function forgeScarredBlade():void {
        clearOutput();
        doNext(inside);
        if (player.hasKeyItem("Sheila's Lethicite") >= 0) {
            //remove Sheila's Lethicite key item, set sheilacite = 3, start sheilaforge timer, increment once per day at 0:00
            display("scarredBlade/start");
            flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = model.time.days;
            player.removeKeyItem("Sheila's Lethicite");
        }
        else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] < 14) {
            display("scarredBlade/middle");
        }
        else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] >= 14) {
            display("scarredBlade/end");
            inventory.takeItem(weapons.SCARBLD, finishTakingScarredBlade, inside);
        }
        flushOutputTextToGUI();
        function finishTakingScarredBlade():void {
            flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = -1;
            inside();
        }
    }
}
}
