package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.TrollVillage;
public class ElderStoreHut extends TrollVillageAbstractContent{
    public function ElderStoreHut() {
    }

    public function ElderShops():void{
        clearOutput();
        menu();
        outputText("You decide to approach the Elder’s hut, it’s very large, tall, and probably contains many different things inside. The entrance is wide and lacks a door, signaling that anyone is welcome to enter, but the guard near the entrance also enforces a sense of security.\n");
        if (TrollVillage.ZenjiFollowing){
            outputText("Zenji speaks up, “Dre Elder’s hut is really just a place where people trade goods, nobody really has anyting to say to the elders. It’s not like dey want to, anyway.”\n");
        }
        outputText("As you enter the hut you see a handful of people about. Not just trolls, but a few lizans, chameleons and other races besides trolls are trading underneath the hut. The stands contain fairly mundane general goods and supplies needed for daily life. Past all the stands is a door where you can only assume the Elders reside.\n" +
                "\n" +
                "As you examine the market stalls, you eye over all the different options from what you have to buy. A few guards guard the entry to the door further in the back. You don’t have anything to talk about with them, anyway.\n");
        addButton(0,"Snacks", TheElderSnacks);  //Who needs the Elder Scrolls anyways.
        addButton(1,"Weapons", TheElderWeapons);
        addButton(2,"Armour", TheElderArmours);
        //Yeah, those last two don't sound as funny as the first one.
    }

    private function TheElderSnacks():void{
        clearOutput();
        outputText("You decide to approach the stand filled with different assortments of wrapped snacks.\n" +
                "\n" +
                "You browse the assortments of food each item has a label as you take your time deciding on what you should take for the road.\n" +
                "\n" +
                "The man behind the counter speaks up, “¿Buscando algo de comer? Todo aquí sólo cuesta 6 gems.”\n" +
                "\n" +
                "6 gems for any of the listed items, seems reasonable.\n");

    }

    private function TheElderWeapons():void{
        clearOutput();
        outputText("You approach the stand with an assortment of weapons in large barrels, displayed to any onlookers.\n" +
                "\n" +
                "The troll eyes you warily as you look at the options. You consider what you want to buy. The prices for the items are conveniently listed on the barrels.\n");

    }

    private function TheElderArmours():void{
        clearOutput();
        outputText("You approach the stand with an assortment of different armors and clothing. You eye the many options as you consider what you want to buy.\n" +
                "\n" +
                "The troll attending the stand says nothing as she stares vacantly into the distance.\n");

    }
}
}
