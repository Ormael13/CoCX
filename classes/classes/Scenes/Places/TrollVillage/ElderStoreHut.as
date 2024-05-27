/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */

package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.Items.Weapon;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.TrollVillage;
import classes.Stats.Buff;

public class ElderStoreHut extends TrollVillageAbstractContent{
    public function ElderStoreHut() {
    }

    public function ElderShops():void{
        clearOutput();
        menu();
        outputText("You decide to approach the Elder’s hut, it’s very large, tall, and probably contains many different things inside. The entrance is wide and lacks a door, signaling that anyone is welcome to enter, but the guard near the entrance also enforces a sense of security.\n");
        if (TrollVillage.ZenjiFollowing){
            outputText("Zenji speaks up, \"<i>The Elder’s hut is really just a place where people trade goods, nobody really has anyting to say to the elders. It’s not like dey want to, anyway.</i>\"\n");
        }
        outputText("As you enter the hut you see a handful of people about. Not just trolls, but a few lizans, chameleons and other races besides trolls are trading underneath the hut. The stands contain fairly mundane general goods and supplies needed for daily life. Past all the stands is a door where you can only assume the Elders reside.\n" +
                "\n" +
                "As you examine the market stalls, you eye over all the different options from what you have to buy. A few guards guard the entry to the door further in the back. You don’t have anything to talk about with them, anyway.\n");
        addButton(0,"Snacks", TheElderSnacks);  //Who needs the Elder Scrolls anyways.
        addButton(1,"Weapons", TheElderWeapons);
        addButton(2,"Armour", TheElderArmours);
        //outputText("As you glance over to the shopping district, you notice some guards blocking you off. Past them is a sign that says, \"Closed for renovations\""+
        //        "[This area is not yet ready to be added into the game yet, please wait for another patch]");
        //Temporary not in until I get the items in. Or someone else helps with it.
        addButton(14, "Return", SceneLib.trollVillage.EnterTheVillage);
        //Yeah, those last two don't sound as funny as the first one.
    }

    private function TheElderSnacks():void{
        clearOutput();
        outputText("You decide to approach the stand filled with different assortments of wrapped snacks.\n" +
                "\n" +
                "You browse the assortments of food each item has a label as you take your time deciding on what you should take for the road.\n" +
                "\n" +
                "The man behind the counter speaks up, \"<i>¿Buscando algo de comer? Todo aquí sólo cuesta 6 gems.</i>\"\n" +
                "\n" +
                "6 gems for any of the listed items, seems reasonable.\n");
        menu();
        addButton(0,"Troll Fig", foodStoreTroll,consumables.TROLFIG);
        addButton(1,"TrollMix", foodStoreTroll, consumables.TRAILMX);
        addButton(2, "Aji de Aji", foodStoreTroll, consumables.AjidAji);
        addButton(3,"Dulce Morada", foodStoreTroll, consumables.D_MORAD);
        addButton(14, "Return", SceneLib.trollVillage.EnterTheVillage);

        function foodStoreTroll(item:ItemType):void{
            clearOutput();
            if (player.gems >= 6){
                player.gems -= 6;
                outputText("You ask for a " + item.longName +" as you fork over 6 gems to the troll.\n" +
                        "\n" +
                        "\"<i>¡Muchas gracias!\"</i> he replies as he gives you " + item.longName + "\n");
                inventory.takeItem(item, TheElderSnacks);
            }
            else{
                outputText("You don't have enough gems to buy this.");
                doNext(TheElderSnacks);
            }
        }

    }

    public function itemsConsumed(item:String):void{
        if(item == "AjidAji"){
            outputText("You open the small packet before eating the soft, yellow peppers with the provided sauce. It’s not too spicy, and the taste is fairly pleasant. The sauce accentuates the flavor while giving it a faint nuttiness.\n" +
                    "\n" +
                    "Your tongue still sizzles softly, you feel like your fire-based spells will be more powerful for some time.\n");
            player.statStore.addBuff('inte', +0, 'AjidAji', {rate: Buff.RATE_HOURS, tick:1})
            //this is suppposed to boost fire damage by 30% for an hour. but I can't find the specific stat for it.
            player.refillHunger(18);
            return;
        }
        if(item == "D.Morada"){
            outputText("You open the small piece of paper to see the piece of purple candy. As you examine it, it’d almost look like a gem itself with the shape it was molded into. Finally, you bring it to your mouth. The taste is sweet with a very mild flavor.\n");
            if(silly()) outputText("It’s DEFINITELY not grape. You consider whether or not that was supposed to be a scam or not.");
            outputText("You hold it in your mouth as it slowly dissolves, it’ll be gone in a few minutes.\n" +
                    "\n" +
                    "You can feel a small sense of power within you as if mana flows through you with more ease.\n");
            player.statStore.addBuff('inte', +0, 'DMorada', {rate: Buff.RATE_HOURS, tick:1})
            //Missing +25% Mana regen boost for an hour. Same issue as above.
            if (rand(4) < 4 && player.ballSize >= 1){
                outputText("You feel your balls churn slightly, it’s apparent your cum production has increased.");
                player.cumMultiplier += .45
            }
            player.refillHunger(10);
        }
    }

    private function TheElderWeapons():void{
        clearOutput();
        outputText("You approach the stand with an assortment of weapons in large barrels, displayed to any onlookers.\n" +
                "\n" +
                "The troll eyes you warily as you look at the options. You consider what you want to buy. The prices for the items are conveniently listed on the barrels.\n");
        menu();
        addButton(0, "Simple Spear", weaponStoreTroll, "SSpear");
        addButton(1, "Guard's Spear", weaponStoreTroll, "GSpear");
        addButton(2, "Simple Staff", weaponStoreTroll, "SStaff");
        addButton(3,"Dagger", weaponStoreTroll, "Dagger");
        addButton(14, "Return", SceneLib.trollVillage.EnterTheVillage);


        function weaponStoreTroll(item:String):void{
            var cost:int = 0;
            var item2:Weapon;
            switch(item){
                case ("SStaff"):
                    item2 = weapons.SIM_STF;
                    cost = 75;
                    break;
                case ("GSpear"):
                    item2 = weapons.G_SPEAR;
                    cost = 450;
                    break;
                case ("SSpear"):
                    item2 = weapons.SIM_SPR;
                    cost = 250;
                    break;
                case ("Dagger"):
                    item2 = weapons.DAGGER;
                    cost = 40;
                    break;
            }
            outputText("\n\nYou examine the " + item2.name +", the troll looks at you, \"That will be " + cost + " gems.\" She states.");
            outputText("\nDo you buy it?\n\n");
            menu();
            addButton(0, "Yes", buyIt, item2, cost);
            addButton(1, "No", nope);
        }

        function nope():void{
            outputText("\"Alright then,\" she replies\n" +
                    "\n" +
                    "You return to looking at her wares.\n");
            doNext(TheElderWeapons);
        }
        function buyIt(item2:Weapon, cost:int):void{
            if (player.gems >= cost){
                player.gems -= cost;
                outputText("You fork over the gems to her and take the " + item2.name +" from the barrel.");
                outputText("\"Have a nice day.\"");
                inventory.takeItem(item2, TheElderWeapons);
            }
            else {
                outputText("You don't have enough gems to buy this.");
                doNext(TheElderWeapons);
            }
        }
    }

    private function TheElderArmours():void{
        clearOutput();
        outputText("You approach the stand with an assortment of different armors and clothing. You eye the many options as you consider what you want to buy.\n" +
                "\n" +
                "The troll attending the stand says nothing as she stares vacantly into the distance.\n");
        menu();
        addButton(0, "Studded Leather", armourStoreTroll, "SLeathr");
        addButton(1, "Heavy Leather", armourStoreTroll, "HLeathr");
        addButton(2, "Fur Clothing", armourStoreTroll, "FCloths");
        addButton(3,"Buckler", armourStoreTroll, "Buckler");
        addButton(14, "Return", SceneLib.trollVillage.EnterTheVillage);

        function armourStoreTroll(item:String):void{
            var cost:int = 0;
            var item2:*;
            switch(item){
                case ("SLeathr"):
                    item2 = armors.SLEATHR;
                    cost = 250;
                    break;
                case ("HLeathr"):
                    item2 = armors.HLEATHR;
                    cost = 375;
                    break;
                case ("FCloths"):
                    item2 = armors.FCLOTHS;
                    cost = 40;
                    break;
                case ("Buckler"):
                    item2 = shields.BUCKLER;
                    cost = 50;
                    break;
            }
            outputText("\n\nYou examine the " + item2.name +", the troll slowly shifts her gaze to you, \"" + cost + "\" She states.");
            outputText("\nDo you buy it?\n\n");
            menu();
            addButton(0, "Yes", buyIt, item2, cost);
            addButton(1, "No", nope);
        }

        function nope():void{
            outputText("\"Qué lástima...\" she replies\n" +
                    "\n" +
                    "You return to looking at her wares.\n");
            doNext(TheElderArmours);
        }
        function buyIt(item2:*, cost:int):void{
            if (player.gems >= cost){
                player.gems -= cost;
                outputText("You fork over the gems to her and take the " + item2.name +" from the barrel.");
                outputText("\"Have a nice day.\"");
                inventory.takeItem(item2, TheElderArmours);
            }
            else{
                outputText("You don't have enough gems to buy this.");
                doNext(TheElderArmours);
            }

        }
    }
}
}
