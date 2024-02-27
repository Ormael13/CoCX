package classes.Scenes.Places.Ingnam {
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.BodyParts.Ears;
import classes.BodyParts.Horns;
import classes.internals.SaveableState;

public class IngramTavern extends BaseContent implements SaveableState {

    public static var IngramRumors:Number;
    public static var IngramEarFreakout:Number;
    public static var IngramTailFreakout:Number;
    public function IngramTavern() {
        Saves.registerSaveableState(this);
    }
    public function stateObjectName():String {
        return "IngramTavern";
    }
    public function resetState():void {
        IngramRumors = 0;
        IngramEarFreakout =0;
        IngramTailFreakout = 0;
        
    }
    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            IngramRumors = o["IngramRumors"];
            IngramEarFreakout = o["IngramEarFreakout"];
            IngramTailFreakout = o["IngramTailFreakout"];
        } else  {
            resetState();
        }
    }
    public function saveToObject():Object {
        return {
            "IngramRumors":IngramRumors,
            "IngramEarFreakout":IngramEarFreakout,
            "IngramTailFreakout":IngramTailFreakout
        }
    }
    public function hearRumors():void { //Hear rumors. Will be altered after defeating Lethice so he will say "Welcome back".
        clearOutput();
        var rumor:int = rand(4);
        outputText("You ask the innkeeper if he has anything special to tell you.");
        switch (IngramRumors) {
            case 0:
                outputText("\n\nHe nods and says, \"<i>Let me tell you. You know what happens to the so-called 'champions'?</i>\" ");
                outputText("\n\nYou nod in response and he continues, \"<i>Well... Nobody ever came back. I've seen twenty people depart over the course of my career. Twenty years. None of them ever returned. Who knows what happened to them? Some say they're abducted by an evil presence as soon as they set foot into the portal.</i>\"");
                outputText("\n\nHe looks at you and sniffles. \"<i>Truth be told, you're going to be the Champion of Ingnam. You will be sent to the so-called 'portal' that is supposedly located in Mount Ilgast. I will miss your patronage at the inn. You're still welcome anytime.</i>\"");
                IngramRumors = 1;
                break;
            case 1:
                outputText("\n\nHe nods and says, \"<i>You know Mount Ilgast?</i>\" ");
                outputText("\n\nYou nod in response and he continues, \"<i>Before I began my work as an innkeeper, I was an adventurer. I've explored Mount Ilgast once. There was something glowing. It's a portal but it's no ordinary portal. Even stranger was that there was something stirring in my groin. Honestly, I swear I never felt that sensation before. I winded up masturbating at the cave entrance just because of that warmth. As soon as I go near the portal, the warm sensation came back again. It's just strange, really strange. So I've hurried back to Ingnam and never visited the mountain again.</i>\"");
                outputText("\n\nYou thank him for telling you.");
                IngramRumors = 2;
                break;
            case 2:
                outputText("\n\n\"He nods and says, \"<i>Do you want to know something special?</i>\" You nod in response before he continues, \"<i>One time I saw a man with cat ears and a tail. I thought they were just accessories, but he insisted it was real. I tugged on his ears, and it was... real. I thought he used a lot of glue, but he insisted that it was real. His ears do feel real. His tail even swished from side to side like it was an actual cat tail. He told me about something called 'Whisker Fruit' or something. So I guess that the food in the so-called 'demon realm' can change you.</i>");
                outputText("\n\nYou ask him if he has some tips for you. He nods as he speaks, \"<i>Yes. If I were you, I would eat them only as last resort. Even food that could transform you can make the difference between life and death.</i>\" You thank him for the advice.");
                outputText("\n\n\"<i>You're welcome. I have nothing left to tell you but you're always welcome,</i>\" he replies.");
                IngramRumors = 3;
                break;
            case 3:
                outputText("\n\nI shouldnt tell you this but since you are soon going to be sent through the portal, about 4 years before you were chosen as the next tribute, I was approached by a group of people being lead by somone named ChiChi.");
                outputText("\n\nThey came to my inn for lodging and paid heavily to keep it hush hush because they planned to sneak through the portal the next day.");
                outputText("\n\nBefore they left I heard them talking about setting up some kind of settlement if they succeed in surviving on the other side of the portal. If they survived they may be able to help you.")
                IngramRumors = 4;
                break;
        }
        doNext(camp.returnToCampUseOneHour);
    }
    //Tavern
    public function menuTavern():void {
        hideMenus();
        clearOutput();
        outputText(images.showImage("location-ingnam-inn"));
        outputText("The inn is a cozy little nook that exudes a warm and welcoming air. You see several guardsmen roaring with laughter over a few steins and a hand of cards, and some townsfolk chatting about random topics. The innkeeper stands behind the polished wooden counter, serving beverages to his patrons and cleaning up spilled drinks.");
        if (flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] > 0 && flags[kFLAGS.INGNAM_GREETED_AFTER_LONGTIME] <= 0) {
            welcomeBack();
        }
        if ((player.ears.type > Ears.HUMAN && player.ears.type != flags[kFLAGS.INGNAM_EARS_LAST_TYPE] && IngramEarFreakout <= 0) || (player.tailType > 0 && player.tailType != flags[kFLAGS.INGNAM_TAIL_LAST_TYPE] && IngramTailFreakout <= 0) && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
            appearanceFreakout();
            return;
        }
        menu();
        addButton(0, "Order Drink", orderDrink).hint("Buy some refreshing beverages.");
        addButton(1, "Order Food", orderFood).hint("Buy some food" + (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 50 ? " and curb that hunger of yours!": ".") + "");
        if (IngramRumors < 3) addButton(2, "Stories", hearRumors).hint("Hear the stories the innkeeper has to offer.");
        //if (player.hasPerk(PerkLib.HistoryWhore)) addButton(5, "Prostitute", whoreForGems).hint("Seek someone who's willing to have sex with you for profit.");
        addButton(14, "Leave", SceneLib.ingnam.menuIngnam);
    }

    public function welcomeBack():void {
        clearOutput();
        outputText("The innkeeper looks at you and says, \"<i>Welcome back! I've missed you! How did your adventures go?</i>\"");
        outputText("\n\nYou tell the innkeeper about your adventures and how you've met various denizens in Mareth.\n\n");
        if (flags[kFLAGS.TIMES_TRANSFORMED] <= 0) outputText("The innkeeper looks at you in awe and says, \"<i>Wow, you haven't changed at all! How did you manage to stay in that strange realm for years and still be normal?</i>\"");
        else if (player.isRace(Races.HUMAN, 1, false)) {
            outputText("The innkeeper looks at you and says, \"<i>I can see that you have changed a bit.</i>\" ");
        }
        else {
            outputText("The innkeeper looks at you and says, \"<i>I can see that you have changed quite a lot! Back then, before you left, you were a human. Now look at yourself!</i>\"");
        }
        if (player.horns.count > 0 && player.horns.type > 0) {
            outputText("\n\n\"<i>Are these " + (player.horns.type == Horns.ANTLERS ? "antlers" : "horns") + "? I can imagine they must be real,</i>\" The innkeeper says before touching your [horns]. You can already feel his fingers rubbing against your [horns]. \"<i>Yes, they're real and I think you look better,</i>\" he says. You thank him for complimenting on your horns.");
        }
        if (player.wings.type > 0) {
            outputText("\n\nNext, he looks at your wings that sprout from your back and says, \"<i>Wings? I've never seen a person with wings before!</i>\" ");
            if (player.canFly()) outputText("You tell him that you can fly. To demonstrate, you guide the innkeeper outside and you grit your teeth with effort as you flap your wings and you finally launch off from the ground and fly around the town! The people of Ingnam, including your family and friends, look at you in shock and some even say, \"<i>[He] can fly!</i>\"");
        }
        outputText("\n\nPLACEHOLDER.");
        flags[kFLAGS.INGNAM_GREETED_AFTER_LONGTIME] = 1;
        doNext(menuTavern);
    }

    public function appearanceFreakout():void {
        clearOutput();
        outputText("The innkeeper stands up to see that there's something unusual with your appearance.");
        if (player.ears.type > Ears.HUMAN) {
            if (player.ears.type == Ears.HORSE) {
                outputText("\n\nHe says, \"<i>Your ears... They look different! They look like horse's! I have no idea how your ears changed.</i>\"");
            } else if (player.ears.type == Ears.DOG) {
                outputText("\n\nHe says, \"<i>Your ears... They look like dog's! I have no idea how your ears changed.</i>\"");
            } else if (player.ears.type == Ears.CAT) {
                outputText("\n\nHe says, \"<i>Your ears... They look like cat's! I have no idea how your ears changed but other than that, you look much cuter with cat ears!</i>\" He walks over to you and scratch your cat-ears. \"<i>They look and feel so real,</i>\" he says.");
            } else {
                outputText("\n\nHe says, \"<i>Your ears... They look like [race]'s! I have no idea how your ears changed.</i>\"");
            }
            flags[kFLAGS.INGNAM_EARS_LAST_TYPE] = player.ears.type;
            IngramEarFreakout = 1;
        }
        if (player.ears.type > 0 && player.tailType > 0 && player.hasLongTail()) outputText("Next, he walks behind you, taking a glance at your tail.");
        if (player.tailType > 0) {
            if (player.hasLongTail()) {
                outputText("\n\nHe says with a surprised look, \"<i>You have a tail now? Are you sure this is fake?</i>\" You tell him that your tail is not fake; it's real. \"<i>Prove it,</i>\" he says as he tugs your tail. Ouch! That hurts! \"<i>Sorry about that,</i>\" he says, \"<i>but that tail definitely looks and feels real! I think your tail does look nice.</i>\"");
                outputText("\n\nYou wag your tail and thank him for the compliment and he walks behind the counter.");
            }
            flags[kFLAGS.INGNAM_TAIL_LAST_TYPE] = player.tailType;
            IngramTailFreakout = 1;
        }
        doNext(menuTavern);
    }


    public function orderDrink():void {
        clearOutput();
        outputText("What kind of drink would you like?");
        outputText("\n\n<b><u>Pricings</u></b>");
        outputText("\n5 gems - Beer");
        outputText("\n2 gems - Milk");
        outputText("\n3 gems - Root Beer");

        menu();
        addButton(0, "Beer", buyBeer);
        addButton(1, "Milk", buyMilk);
        addButton(2, "Root Beer", buyRootBeer);
        addButton(14, "Back", menuTavern);
    }

    public function buyBeer():void {
        clearOutput();
        if (player.gems < 5) {
            outputText("You don't have enough gems for that.");
            doNext(orderDrink);
            return;
        }
        player.gems -= 5;
        outputText("\"<i>I'd like a glass of beer please,</i>\" you say. You hand over the five gems to the innkeeper and he pours you a glass of beer.");
        outputText("\n\nYou kick back and drink the beer slowly. ");
        dynStats("lus", 20, "scale", false);
        player.refillHunger(10);
        if (!player.hasStatusEffect(StatusEffects.Drunk)) {
            player.createStatusEffect(StatusEffects.Drunk, 2, 1, 1, 0);
            dynStats("str", 0.1);
            player.addCurse("inte", 0.5, 1);
            dynStats("lib", 0.25);
        }
        else {
            player.addStatusValue(StatusEffects.Drunk, 2, 1);
            if (player.statusEffectv1(StatusEffects.Drunk) < 2) player.addStatusValue(StatusEffects.Drunk, 1, 1);
            if (player.statusEffectv2(StatusEffects.Drunk) == 2) {
                outputText("\n\n<b>You feel a bit drunk. Maybe you should cut back on the beers?</b>");
            }
            //Get so drunk you end up peeing! Genderless can still urinate.
            if (player.statusEffectv2(StatusEffects.Drunk) >= 3) {
                outputText("\n\nYou feel so drunk. Your vision is blurry and you realize something's not feeling right. Gasp! You have to piss like a racehorse! You stumble toward the back door and go outside. ");
                if (player.hasVagina() && !player.hasCock()) outputText("You open up your [armor] and squat down while you release your pressure onto the ground. ");
                else outputText("You open up your [armor] and lean against the wall using one of your arms for support while you release your pressure onto the wall. ");
                outputText("It's like as if the floodgate has opened! ");
                awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true, false);
                awardAchievement("Smashed", kACHIEVEMENTS.GENERAL_SMASHED, true, true, false);
                outputText("\n\nIt seems to take forever but it eventually stops. You look down to see that your urine has been absorbed into the ground. You close up your [armor] and head back inside.");
                player.removeStatusEffect(StatusEffects.Drunk);
                cheatTime(1/12);
            }
        }
        cheatTime(1/12);
        doNext(menuTavern);
    }
    public function buyMilk():void {
        clearOutput();
        if (player.gems < 2) {
            outputText("You don't have enough gems for that.");
            doNext(orderDrink);
            return;
        }
        player.gems -= 2;
        outputText("\"<i>I'd like a glass of milk please,</i>\" you say. You hand over the two gems to the innkeeper and he pours you a glass of milk.");
        outputText("\n\nYou drink the cup of milk. You feel calm and refreshed. ");
        fatigue(-15);
        HPChange(player.maxHP() / 4, false);
        player.refillHunger(10);
        cheatTime(1/12);
        doNext(menuTavern);
    }
    public function buyRootBeer():void {
        clearOutput();
        if (player.gems < 3) {
            outputText("You don't have enough gems for that.");
            doNext(orderDrink);
            return;
        }
        player.gems -= 3;
        outputText("\"<i>I'd like a glass of root beer please,</i>\" you say. You hand over the three gems to the innkeeper and he pours you a glass of root beer.");
        outputText("\n\nYou drink the cup of root beer. Refreshing! ");
        fatigue(-15);
        HPChange(player.maxHP() / 4, false);
        player.refillHunger(10);
        cheatTime(1/12);
        doNext(menuTavern);
    }

    public function orderFood():void { //Order food, because you need to be able to fill hunger.
        clearOutput();
        outputText("You take a seat and look at the menu. What would you like?");
        outputText("\n\n<b><u>Pricings</u></b>");
        outputText("\n5 gems - Sandwich");
        outputText("\n3 gems - Soup");
        outputText("\n5 gems - Hard biscuits (Packed)");
        outputText("\n20 gems - Trail mix (Packed)");
        menu();
        addButton(0, "Sandwich", buySandwich);
        addButton(1, "Soup", buySoup);
        addButton(2, "Biscuits", buyHardBiscuits);
        addButton(3, "Trail Mix", buyTrailMix);
        addButton(14, "Back", menuTavern);
    }

    public function buySandwich():void { //Eat sandwich, refill hunger. The reason it's ambiguous is to let you imagine what sandwich you're eating.
        clearOutput();
        if (player.gems < 5) {
            outputText("You don't have enough gems for that.");
            doNext(orderDrink);
            return;
        }
        player.gems -= 5;
        outputText("You tell the innkeeper that you would like a sandwich and toss five gems at him. \"<i>Certainly, " + player.mf("sir", "madam") + ",</i>\" he says as he quickly grabs a plate and assembles a sandwich. Hey, it's your favorite type!");
        outputText("\n\nYou eat the sandwich. Delicious!");
        HPChange(player.maxHP() / 3, false);
        player.refillHunger(25);
        cheatTime(1/12);
        doNext(menuTavern);
    }

    public function buySoup():void { //Eat soup. Again, it's vague to let you imagine what soup you're eating.
        clearOutput();
        if (player.gems < 3) {
            outputText("You don't have enough gems for that.");
            doNext(orderDrink);
            return;
        }
        player.gems -= 3;
        outputText("You tell the innkeeper that you would like a bowl of soup and toss three gems at him. \"<i>Certainly, " + player.mf("sir", "madam") + ",</i>\" he says as he grabs a bowl and fills it with steaming soup. Hey, it's your favorite type!");
        outputText("\n\nYou take one spoonful at a time, blowing to make sure the soup isn't too hot. You eventually finish the soup. Delicious!");
        HPChange(player.maxHP() / 3, false);
        player.refillHunger(20);
        cheatTime(1/12);
        doNext(menuTavern);
    }

    private function buyHardBiscuits():void {
        clearOutput();
        if(player.gems < 5) {
            outputText("You can't afford one of those!");
            doNext(orderFood);
            return;
        }
        outputText("You pay five gems for a pack of hard biscuits.  ");
        player.gems -= 5;
        statScreenRefresh();
        inventory.takeItem(consumables.H_BISCU, orderFood);
    }

    private function buyTrailMix():void {
        clearOutput();
        if (player.gems < 20) {
            outputText("You can't afford one of those!");
            doNext(orderFood);
            return;
        }
        outputText("You pay twenty gems for a pack of trail mix.  ");
        player.gems -= 20;
        statScreenRefresh();
        inventory.takeItem(consumables.TRAILMX, orderFood);
    }
}
}
