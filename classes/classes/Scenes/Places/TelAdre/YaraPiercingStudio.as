package classes.Scenes.Places.TelAdre {
import classes.BodyParts.Piercing;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.StatusEffects;
import classes.display.SpriteDb;
import coc.view.ButtonDataList;

public class YaraPiercingStudio extends TelAdreAbstractContent {
    /**
     * 3 variables that define bonuses for piercing.
     */
    public const LOC_CLIT:int    = 0;
    public const LOC_DICK:int    = 1;
    public const LOC_EARS:int    = 2;
    public const LOC_EYEBROW:int = 3;
    public const LOC_LIP:int     = 4;
    public const LOC_NIPPLES:int = 5;
    public const LOC_NOSE:int    = 6;
    public const LOC_TONGUE:int  = 7;
    public const LOC_VULVA:int   = 8;

    //{region PiercingVariables

    //0) **Clit (+2 sens)
    //1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
    //2) **Ears
    //3) **Eyebrow (-.5 def)
    //4) **Lip (-.5 def)
    //5) **Nipples (+1 sens, +1 lib)
    //6) **Nose (+.5 attack)
    //7) **Tongue (+1 sens)
    public const MAT_AMETHYST:int  = 1;
    public const MAT_DIAMOND:int   = 2;
    public const MAT_GOLD:int      = 3;
    public const MAT_EMERALD:int   = 4;
    public const MAT_JADE:int      = 5;
    public const MAT_ONYX:int      = 6;
    public const MAT_RUBY:int      = 7;
    public const MAT_STEEL:int     = 8;
    public const MAT_LETHITE:int   = 9;
    public const MAT_FERRITE:int   = 10;
    public const MAT_FURRITE:int   = 11;
    public const MAT_CRIMSTONE:int = 12;
    public const MAT_ICESTONE:int  = 13;
    public const TYPE_NONE:int   = 0;
    //1. Amethyst (+1 int, +1 lib)
    //2. Diamond (+2 int, -1 cor)
    //3. Gold (+1 int, +1 sens)
    //4. Emerald (+1 spe)
    //5. Jade (+1 spe, -.5 tou)
    //6. Onyx (+1 tou, -1 spe)
    //7. Ruby (+1 lib, +1 sens)
    //8. Steel (+2 str, -2 int)
    //9. Lethite (Demon Lure)
    //10. Fertite (Fertility Booster)
    //11. Furrite (Attracts Furries)
    //12. Crimstone - + min lust
    //13. Icestone (-Min Lust)

    //}endregion
    public function YaraPiercingStudio() {

    }
    //1. Stud
    //2. Ring (Called prince albert on dick)
    //3. Jacobs Ladder (dick only)
    //4. Hoop (ears/nipples/clit)
    //5. Chain (nipples only)
    //8) **Vulva (+1 sens)
    public var piercingLoc:Number = 0;

    public function piercingStudio():void {
        spriteSelect(SpriteDb.s_yara);
        var about:Function = null;
        if (!player.hasStatusEffect(StatusEffects.Yara)) {
            about = aboutYara;
        }
        clearOutput();
        outputText("The interior of the piercing studio is earthy, leaving the stone floors and walls uncovered, though the windows are covered with woven blankets, sewn from multicolored threads.  There are a number of cushy chairs facing a wall of mirrors, along with a shelf covered in needles, piercings, and strong alcohols.  A brunette prowls about the place, tidying it up during a lull in business.  You dully notice that unlike everyone else in this town, she's mostly human.  Perhaps she came through a portal as well?  She approaches you, and you see a cat tail waving behind her, and a pair of fuzzy feline ears, both covered in piercings, perched atop her head.  Clearly she's been here long enough to pick up some of the local flavor.\n\n");
        outputText("She introduces herself, \"<i>Hello there " + player.mf("sir", "cutie") + ", my name is Yara.  Would you like to get a piercing?</i>\"");
        if (!flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) {
            simpleChoices("Pierce", pierceMenu, "Remove", piercingRemove, "About Her", about, "", null, "Leave", telAdre.telAdreMenu);
        } else {

            outputText("\n\n(Low Standard mode!)\nAlternatively, she might be open to a quick fuck if you ask.");
            choices("Pierce", pierceMenu,
                    "Remove", piercingRemove,
                    "", null,
                    "AsFemale", createCallBackFunction(letsDoYaraSex, true),
                    "AsMale", createCallBackFunction(letsDoYaraSex, false),
                    "About Her", about,
                    "", null,
                    "", null,
                    "", null,
                    "Leave", telAdre.telAdreMenu);
        }
    }

    private function aboutYara():void {
        spriteSelect(SpriteDb.s_yara);
        player.createStatusEffect(StatusEffects.Yara, 0, 0, 0, 0);
        clearOutput();
        outputText("You introduce yourself and ask Yara about her past, noting that ");
        if (player.humanScore() <= 2) {
            outputText("you were once a human too.");
        } else {
            outputText("you haven't seen many other humans about.");
        }
        outputText("\n\nShe blushes a little when she answers, her tail curling about her protectively, \"<i>My home city was built around a portal, and the Baron that ruled it insisted that we send a sacrifice through every year.  We were raised believing that if we didn't sacrifice SOMEONE, the gods would become angry and bring our city to ruin.  Of course the whole thing was a sham, but the families of those sacrificed get compensation.  My father tried to whore me out first, but when that didn't work, the bastard had me drugged and sacrificed.  I woke up next to a lake, ate some weird fruit when I got hungry, and I... well, I changed.  Thankfully I found my way here before I ran into any demons, or who knows what would have happened to me!  Tel'Adre has been good to me, and I'm sure it'll be good to you.  Now, how about getting a piercing?</i>\"");
        dynStats("int", 2, "lus", -5, "cor", -1);
        doNext(piercingStudio);
    }

    private function locChoicesArray(pierce:Boolean, fun:Function):Array {
        var pDesc:Array;
        var locChoices:Array = [];
        if (pierce){
            pDesc = ["Add Piercing", "You can't have a piercing here!"];
            locChoices.push("Clit", ((!player.hasVagina() || player.vaginas[0].clitPierced != TYPE_NONE) ? false: curry(fun, LOC_CLIT)), pDesc);
            locChoices.push("Dick", ((!player.hasCock() || player.cocks[0].pierced != 0) ? false: curry(fun, LOC_DICK)), pDesc);
            locChoices.push("Ears", (player.earsPierced != TYPE_NONE ? false: curry (fun, LOC_EARS)), pDesc);
            locChoices.push("Eyebrow", (player.eyebrowPierced != TYPE_NONE ? false: curry (fun, LOC_EYEBROW)), pDesc);
            locChoices.push("Lip", (player.lipPierced != TYPE_NONE ? false: curry (fun, LOC_LIP)), pDesc);
            locChoices.push("Nipples", (player.nipplesPierced != TYPE_NONE ? false: curry (fun, LOC_NIPPLES)), pDesc);
            locChoices.push("Nose", (player.nosePierced != TYPE_NONE ? false: curry (fun, LOC_NOSE)), pDesc);
            locChoices.push("Tongue", (player.tonguePierced != TYPE_NONE ? false: curry (fun, LOC_TONGUE)), pDesc);
            locChoices.push("Labia", ((!player.hasVagina() || player.vaginas[0].labiaPierced != TYPE_NONE) ? false: curry (fun, LOC_VULVA)), pDesc);
        }
        else {
            pDesc = ["Remove Piercing", "You don't have a piercing here!"];
            locChoices.push("Clit", ((!player.hasVagina() || player.vaginas[0].clitPierced == TYPE_NONE) ? false: curry(fun, LOC_CLIT)), pDesc);
            locChoices.push("Dick", ((!player.hasCock() || player.cocks[0].pierced == 0) ? false: curry(fun, LOC_DICK)), pDesc);
            locChoices.push("Ears", (player.earsPierced == TYPE_NONE ? false: curry (fun, LOC_EARS)), pDesc);
            locChoices.push("Eyebrow", (player.eyebrowPierced == TYPE_NONE ? false: curry (fun, LOC_EYEBROW)), pDesc);
            locChoices.push("Lip", (player.lipPierced == TYPE_NONE ? false: curry (fun, LOC_LIP)), pDesc);
            locChoices.push("Nipples", (player.nipplesPierced == TYPE_NONE ? false: curry (fun, LOC_NIPPLES)), pDesc);
            locChoices.push("Nose", (player.nosePierced == TYPE_NONE ? false: curry (fun, LOC_NOSE)), pDesc);
            locChoices.push("Tongue", (player.tonguePierced == TYPE_NONE ? false: curry (fun, LOC_TONGUE)), pDesc);
            locChoices.push("Labia", ((!player.hasVagina() || player.vaginas[0].labiaPierced == TYPE_NONE) ? false: curry (fun, LOC_VULVA)), pDesc);
        }
        return locChoices;
    }

    private function pierceMenu():void {
        spriteSelect(SpriteDb.s_yara);
        hideUpDown();
        clearOutput();
        outputText("Yara asks, \"<i>Ok then, what would you like pierced " + player.mf("sir", "cutie") + "?  Just keep in mind my piercings are special - they're permanent and CAN'T be removed.</i>\"");
        var locChoices:Array = locChoicesArray(true, chooseLoc);
        if (menuActiveButtons(locChoices) > 0) //pre-check
            menuGen(locChoices, 0, piercingStudio);
        else {
            outputText("\n\nYou give yourself a quick once-over and realize there's nowhere left for her to pierce you.  Oh well.");
            doNext(piercingStudio);
        }
    }

    private function chooseLoc(loc:int):void {
        doNext(pierceMenu);
        if (loc == LOC_DICK && !player.hasCock()) {
            outputText("You realize you don't have a dick to pierce.  Whoops!  Better pick something else...");
            return;
        }
        if ((loc == LOC_CLIT || loc == LOC_VULVA) && !player.hasVagina()) {
            outputText((loc == LOC_CLIT ? "You realize you don't have a clit to pierce." : "You realize you don't have a pussy to pierce.")
                    + "  Whoops!  Better pick something else...");
            return;
        }
        switch (loc) {
            case LOC_CLIT:
                outputText("\"<i>Ohhh, that's going to be suckably cute!</i>\" exclaims Yara, blushing more than a little. \"<i>What kind of piercing would you like?</i>");
                break;
            case LOC_DICK:
                outputText("\"<i>Ok, this is gonna hurt a LOT, but I've heard good things about it.  What kind of piercing do you want done?</i>\" Yara asks.");
                break;
            case LOC_EARS:
                outputText("\"<i>Okay, just let me get my supplies and we can get started.  What kind of jewelry do you want in them?</i>\" asks Yara.");
                break;
            case LOC_EYEBROW:
                outputText("\"<i>Ah, that's a good look!  What do you want there?</i>\" asks Yara.");
                break;
            case LOC_LIP:
                outputText("\"<i>Oh my, that'll be HAWT!  What kind of jewelry do you want there?</i>\" asks Yara.");
                break;
            case LOC_NIPPLES:
                outputText("\"<i>Yeah, sure I can do those!  What kind of jewelry do you want there?  I'm partial to nipple-chains myself,</i>\" admits Yara, blushing bright red.");
                break;
            case LOC_NOSE:
                outputText("Yara wrinkles her nose in distaste, \"<i>Really?  Well ok, what do you want there?</i>\"");
                break;
            case LOC_TONGUE:
                outputText("Yara happily purrs, \"<i>Oh my, I bet that'll be fun!  I'm afraid I can only put a stud there though, ok?</i>\"");
                break;
            case LOC_VULVA:
                outputText("Yara explains, \"<i>This is gonna hurt a lot, but I think you'll love how it feels after.  I know I do!  Now what kind of jewelry do you want down-town?</i>\"");
                break;
        }
        var typeChoices:ButtonDataList = new ButtonDataList();
        typeChoices.add("Stud", curry(chooseMaterials, loc, Piercing.STUD));
        typeChoices.add("Ring", curry(chooseMaterials, loc, Piercing.RING)).visible     = (loc != LOC_TONGUE);
        typeChoices.add("Ladder", curry(chooseMaterials, loc, Piercing.LADDER)).visible = (loc == LOC_DICK);
        typeChoices.add("Hoop", curry(chooseMaterials, loc, Piercing.HOOP)).visible     = (loc == LOC_EARS);
        typeChoices.add("Chain", curry(chooseMaterials, loc, Piercing.CHAIN)).visible   = (loc == LOC_NIPPLES);
        submenu(typeChoices, pierceMenu);
    }

    private function chooseMaterials(loc:int, type:int):void {
        spriteSelect(SpriteDb.s_yara);
        clearOutput();
        outputText("Yara gathers up her materials and says, \"<i>Ok, now what type of material do you want it made from?  Don't worry about price, none of these are that rare, so the piercing will only be 100 gems.  Though I do have some rarer materials; you'll need 1,000 gems to spend if you want to check them out.</i>\"");
        if (player.gems < 100) {
            outputText("\n\nYou realize you don't have enough gems to get a piercing.");
            doNext(piercingStudio);
            return;
        }
        var rare:Function = null;
        if (player.gems >= 1000) {
            rare = curry(chooseAdvancedMaterials, loc, type);
        }
        var doConfirm:Function = curry(areYouSure, loc, type);
        choices("Amethyst", curry(doConfirm, MAT_AMETHYST),
                "Diamond", curry(doConfirm, MAT_DIAMOND),
                "Gold", curry(doConfirm, MAT_GOLD),
                "Emerald", curry(doConfirm, MAT_EMERALD),
                "Jade", curry(doConfirm, MAT_JADE),
                "Onyx", curry(doConfirm, MAT_ONYX),
                "Ruby", curry(doConfirm, MAT_RUBY),
                "Steel", curry(doConfirm, MAT_STEEL),
                "Rare Menu", rare,
                "Nevermind", piercingStudio);
    }

    private function areYouSure(loc:int, type:int, mat:int):void {
        spriteSelect(SpriteDb.s_yara);
        clearOutput();
        outputText("Yara says, \"<i>Ok, last chance to back out, are you sure you want to go ahead with this?  Remember, once I put it in, it's permanent.</i>\"");
        doYesNo(curry(normalPierceAssemble, loc, type, mat), piercingStudio);
    }

    private function chooseAdvancedMaterials(loc:int, type:int):void {
        spriteSelect(SpriteDb.s_yara);
        clearOutput();
        outputText("Yara goes back into the back and comes out with a gilded tray full of exotic materials.  She hands you a brochure and asks, \"<i>Ok, now what am I going to be working with?</i>\"");
        outputText("\n\nThere's a number of materials listed here:");
        outputText("\n1. Lethite - Fake lethicite.  While beautiful, it's known to attract demons.");
        outputText("\n2. Fertite - A green gem sometimes fished up from the bottom of Mareth's great lake, it is said to enhance the fertility of both genders.");
        outputText("\n3. Furrite - This beautiful purple gem is actually crystalized from materials used in hunting lures.  It is said to enhance the wearer's appeal to beast-people.");
        outputText("\n4. Crimstone - Crimstone is said to be formed from volcanic fires, and to keep the fires of one's desires burning brightly.");
        outputText("\n5. Icestone - Found from the Glacial Rift, this rare gem is said to counter the effects of Crimstone and quell ever-burning desires. This will annihilate some of crimstone magic. Due to its rarity, this costs 2000 gems instead.");
        outputText("\n\n<b>DISCLAIMER</b>: Yara's Piercing Studio is not responsible if the piercee's body absorbs any residual magic of these stones, and is not required to resolve any issues if the effects persist beyond removal.</b>");
        var doConfirm:Function = curry(areYouSure, loc, type);
        choices("Lethite", curry(doConfirm, MAT_LETHITE),
                "Fertite", curry(doConfirm, MAT_FERRITE),
                "Furrite", curry(doConfirm, MAT_FURRITE),
                "Crimstone", curry(doConfirm, MAT_CRIMSTONE),
                "", null, "", null, "", null, "", null, "", null,
                "Back", piercingStudio);
        if (player.gems >= 2000) {
            addButton(4, "Icestone", curry(doConfirm, MAT_ICESTONE));
        }
    }

    private function normalPierceAssemble(loc:int, type:int, mat:int):void {
        spriteSelect(SpriteDb.s_yara);
        clearOutput();
        outputText("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled and before you know it, your piercing is done!");
        var shortP:String = "";
        var longP:String  = "";
        player.gems -= 100;
        if (mat > 8) {
            player.gems -= 900;
        }
        if (mat == 13) {
            player.gems -= 1000;
        }
        statScreenRefresh();
        //set up material description
        switch (mat) {
            case MAT_AMETHYST:
                shortP += "amethyst ";
                dynStats("int", 1, "lib", 1);
                longP += "Amethyst ";
                break;
            case MAT_DIAMOND:
                shortP += "diamond ";
                dynStats("int", 2, "cor", -1);
                longP += "Diamond ";
                break;
            case MAT_GOLD:
                shortP += "gold ";
                dynStats("int", 1, "sen", 1);
                longP += "Gold ";
                break;
            case MAT_EMERALD:
                shortP += "emerald ";
                dynStats("spe", 1);
                longP += "Emerald ";
                break;
            case MAT_JADE:
                shortP += "jade ";
                dynStats("tou", -.5, "int", 1, "cor", -1);
                longP += "Jade ";
                break;
            case MAT_ONYX:
                shortP += "onyx ";
                dynStats("tou", 1, "spe", -1);
                longP += "Onyx ";
                break;
            case MAT_RUBY:
                shortP += "ruby ";
                dynStats("lib", 1, "sen", 1);
                longP += "Ruby ";
                break;
            case MAT_STEEL:
                shortP += "steel ";
                dynStats("str", 2, "int", -2);
                longP += "Steel ";
                break;
            case MAT_LETHITE:
                shortP += "lethite ";
                if (!player.hasPerk(PerkLib.PiercedLethite)) {
                    player.createPerk(PerkLib.PiercedLethite, 0, 0, 0, 0);
                }
                longP += "Lethite ";
                break;
            case MAT_FERRITE:
                shortP += "fertite ";
                if (!player.hasPerk(PerkLib.PiercedFertite)) {
                    player.createPerk(PerkLib.PiercedFertite, 5, 0, 0, 0);
                } else {
                    player.addPerkValue(PerkLib.PiercedFertite, 1, 5);
                }
                longP += "Fertite ";
                break;
            case MAT_FURRITE:
                shortP += "furrite ";
                if (!player.hasPerk(PerkLib.PiercedFurrite)) {
                    player.createPerk(PerkLib.PiercedFurrite, 0, 0, 0, 0);
                }
                longP += "Furrite ";
                break;
            case MAT_CRIMSTONE:
                shortP += "crimstone ";
                if (player.hasPerk(PerkLib.PiercedIcestone)) {
                    player.addPerkValue(PerkLib.PiercedIcestone, 1, -5);
                    if (player.perkv1(PerkLib.PiercedIcestone) <= 0) {
                        player.removePerk(PerkLib.PiercedIcestone);
                    }
                }
                else {
                    if (!player.hasPerk(PerkLib.PiercedCrimstone)) {
                        player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
                    } else {
                        player.addPerkValue(PerkLib.PiercedCrimstone, 1, 5);
                    }
                }
                longP += "Crimstone ";
                break;
            case MAT_ICESTONE:
                shortP += "icestone ";
                if (player.hasPerk(PerkLib.PiercedCrimstone)) {
                    player.addPerkValue(PerkLib.PiercedCrimstone, 1, -5);
                    if (player.perkv1(PerkLib.PiercedCrimstone) <= 0) {
                        player.removePerk(PerkLib.PiercedCrimstone);
                    }
                }
                else {
                    if (!player.hasPerk(PerkLib.PiercedIcestone)) {
                        player.createPerk(PerkLib.PiercedIcestone, 5, 0, 0, 0);
                    } else {
                        player.addPerkValue(PerkLib.PiercedIcestone, 1, 5);
                    }
                }
                longP += "Icestone ";
                break;
        }
        switch (loc) {
            case LOC_CLIT:
                shortP += "clit-";
                longP += "clit-";
                dynStats("sen", 2);
                break;
            case LOC_DICK:
                if (type == 3) {
                    break;
                }
                shortP += "cock-";
                longP += "cock-";
                dynStats("lib", 2);
                break;
            case LOC_EARS:
                shortP += "ear";
                longP += "ear";
                break;
            case LOC_EYEBROW:
                dynStats("tou", -.5);
                shortP += "eyebrow-";
                longP += "eyebrow-";
                break;
            case LOC_LIP:
                dynStats("tou", -.5);
                shortP += "lip-";
                longP += "lip-";
                break;
            case LOC_NIPPLES:
                dynStats("lib", 1, "sen", 1);
                shortP += "nipple-";
                longP += "nipple-";
                break;
            case LOC_NOSE:
                dynStats("str", .5);
                shortP += "nose-";
                longP += "nose-";
                break;
            case LOC_TONGUE:
                dynStats("sen", 1);
                shortP += "tongue-";
                longP += "tongue-";
                break;
            case LOC_VULVA:
                dynStats("sen", 1);
                shortP += "labia-";
                longP += "labia-";
                break;
        }
        switch (type) {
                //studs
            case Piercing.STUD:
                //multiples
                if (loc == 2 || loc == 5 || loc == 8) {
                    shortP += "studs";
                    longP += "studs";
                }
                else {
                    shortP += "stud";
                    longP += "stud";
                }
                break;
                //2. Ring (Called prince albert on dick)
            case Piercing.RING:
                //multiples
                if (loc == 2 || loc == 5 || loc == 8) {
                    shortP += "rings";
                    longP += "rings";
                }
                else {
                    shortP += "ring";
                    longP += "ring";
                }
                break;
                //3. Jacobs Ladder (dick only)
            case Piercing.LADDER:
                shortP += "jacob's ladder";
                longP += "jacob's ladder";
                break;
                //4. Hoop (ears/nipples/clit)
            case Piercing.HOOP:
                //multiples
                if (loc == 2 || loc == 5 || loc == 8) {
                    shortP += "hoops";
                    longP += "hoops";
                }
                else {
                    shortP += "hoop";
                    longP += "hoop";
                }
                break;
                //5. Chain (nipples only)
            case Piercing.CHAIN:
                shortP += "chain";
                longP += "chain";
                break;
        }
        //Actually assign values to their real storage locations
        applyPiercing(loc, type, shortP, longP);
        //Girls
        if (loc == 8 || loc == 0) {
            yaraSex();
            return;
        }
        //Dudes
        else if (loc == 1 && (player.cockThatFits(36) >= 0 || flags[kFLAGS.HYPER_HAPPY])) {
            yaraSex(false);
            return;
        }
        //Piercing shop main menu
        doNext(piercingStudio);
    }

    private function applyPiercing(loc:int, type:int = TYPE_NONE, shortP:String = "", longP:String = ""):void {
        switch (loc) {
            case LOC_CLIT:
                player.vaginas[0].clitPierced = type;
                player.vaginas[0].clitPShort  = shortP;
                player.vaginas[0].clitPLong   = longP;
                break;
            case LOC_DICK:
                player.cocks[0].pierced    = type;
                player.cocks[0].pShortDesc = shortP;
                player.cocks[0].pLongDesc  = longP;
                break;
            case LOC_EARS:
                player.earsPierced = type;
                player.earsPShort  = shortP;
                player.earsPLong   = longP;
                break;
            case LOC_EYEBROW:
                player.eyebrowPierced = type;
                player.eyebrowPShort  = shortP;
                player.eyebrowPLong   = longP;
                break;
            case LOC_LIP:
                player.lipPierced = type;
                player.lipPShort  = shortP;
                player.lipPLong   = longP;
                break;
            case LOC_NIPPLES:
                player.nipplesPierced = type;
                player.nipplesPShort  = shortP;
                player.nipplesPLong   = longP;
                break;
            case LOC_NOSE:
                player.nosePierced = type;
                player.nosePShort  = shortP;
                player.nosePLong   = longP;
                break;
            case LOC_TONGUE:
                player.tonguePierced = type;
                player.tonguePShort  = shortP;
                player.tonguePLong   = longP;
                break;
            case LOC_VULVA:
                player.vaginas[0].labiaPierced = type;
                player.vaginas[0].labiaPShort  = shortP;
                player.vaginas[0].labiaPLong   = longP;
                break;
        }
    }

    private function piercingRemove():void {
        spriteSelect(SpriteDb.s_yara);
        var locChoices:Array = locChoicesArray(false, doRemove);
        hideUpDown();
        clearOutput();
        outputText("\"<i>Really?</i>\" asks Yara, \"<i>I told you those piercings are permanent!  Well, I suppose they CAN be removed, but you're gonna hurt like hell afterwards.  If you really want me to, I can remove something, but it'll cost you 100 gems for the painkillers and labor.</i>\"");
        if (menuActiveButtons(locChoices) < 0) { //pre-check
            outputText("\n\n\"Although... \" Yara giggles, \"<i>You don't have any piercings, silly!</i>\"");
            doNext(piercingStudio);
            return;
        }
        if (player.gems < 100) {
            outputText("\n\n<b>You do not have enough gems.</b>");
            doNext(piercingStudio);
            return;
        }
        if (player.tou <= 5.5) {
            outputText("Yara looks you up and down before refusing you outright, \"<i>You don't look so good [name].  I don't think your body could handle it right now.</i>\"");
            doNext(piercingStudio);
            return;
        }
        menuGen(locChoices, 0, piercingStudio);
    }

    private function doRemove(loc:int):void {
            clearOutput();
            outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.");
            applyPiercing(loc);
            dynStats("tou", -5);
            player.gems -= 100;
            statScreenRefresh();
            doNext(piercingStudio);
        }

    private function yaraSex(girl:Boolean = true):void {
        spriteSelect(SpriteDb.s_yara);
        clearOutput();
        outputText("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled. Before you know it, your piercing is done!  You move to rise, retaining a bit of modesty");
        if (flags[kFLAGS.PC_FETISH] > 0) {
            outputText(" despite the guilty thrill");
        }
        outputText(".  \"<i>Hold it,</i>\" Yara commands softly, pressing her hand against your " + chestDesc() + " and pushing you back in your chair.  \"<i>Do you think I'll let you get away without some... field testing?</i>\"\n\n");
        outputText("She seems intent on getting some loving - would you like to turn her down, or will you let nature run its course?");
        //[not at all] [yeah baby]
        simpleChoices("Turn down", piercingStudio, "Oh yeah!", createCallBackFunction(letsDoYaraSex, girl), "", null, "", null, "", null);
    }

    private function letsDoYaraSex(girl:Boolean = true):void {
        spriteSelect(SpriteDb.s_yara);
        clearOutput();
        var x:Number = player.cockThatFits(36);
        if (flags[kFLAGS.HYPER_HAPPY]) {
            x = player.cockThatFits(50000);
        }
        else if ((x == -1) && !girl)  // No cock that fits
        {
            if (player.hasVagina()) // But the PC has a vagoo! Swap over to female mode"
            {
                outputText("\"<i>Oh dear, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. \"<i>Oh well</i>\", she sighs. \"<i>I guess I'll just have to explore your feminine side instead</i>\"\n");
                girl = true;
            }
            else {
                outputText("\"<i>I'm sorry, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. Maybe come back after you've shrunk it down to a reasonable size?");
                return;
            }
        }
        outputText("Her eyes widen as you begin to ");
        if (player.lust < 50) {
            outputText("protest");
        } else {
            outputText("speak");
        }
        outputText(", neatly silencing you with the lust-filled fires simmering in her eyes.  \"<i>Call it quality testing,</i>\" she purrs.  Her free hand runs up and down your inner thigh, the ticklish teasing nearly making your head spin.  Licking her lips in anticipation, Yara wiggles out of her clothes and clambers onto the chair, kneeling on the armrests.  Due to her awkward posture, you find your gaze drifting to her wide-spread legs.  Nestled there, twinkling with a radiant luster, is a golden ring, looped through her already-throbbing clit.  A blush darkens her cheeks as she notices your stare, but she seems almost empowered by it.\n\n");
        outputText("Yara's free hand slides down her belly - past the stud in her navel - down to her box.  Using two fingers, she spreads her lips apart, giving you a great view of both her glistening button-piercing and the fleshy recesses past it.  She bites her bottom lip gently");
        if (!girl && player.hasCock()) {
            outputText(" as your " + cockDescript(x) + " rises to attention, her eyes fixed upon the stiffened tool.  You resist the urge to grab her thin-yet-girlish hips and power into her right then and there, curious enough to allow her teasing.");
        } else {
            outputText(" as a growing puddle of love stains the cushioned chair.  It takes most of your power to not drag her down and force her face into your box.");
        }
        outputText("\n\n");
        outputText("She leans forward, planting you with a wet and lingering kiss.  She moves lower, kissing ");
        if (player.biggestTitSize() < 1) {
            outputText("your chest");
        } else {
            outputText("your nipples, one at a time");
        }
        outputText(" and smooching your belly.  Even with her racially characteristic flexibility, however, she's not able to get any lower from that angle.  \"<i>Hold this, dear,</i>\" she says somewhat snarkily, pivoting around and resting her ass against your " + chestDesc() + ".  In this new posture, Yara can easily have her way with your junk, and by the way her wagging tail keeps bopping you in the face you can tell she's excited.\n\n");
        outputText("Not content with simple penetration, it seems, the cat girl gets to work.");
        if (player.balls > 0) {
            outputText("  Her dexterous fingertips brush against your [balls], light and fluttery strokes that send shivers coursing through you.  The near-lack of contact is at least as titillating as the less-subtle Marethians you've come across.");
        }
        outputText("  She scoots forward a bit, dragging her soaking cunt down your chest in an effort to reach your crotch.\n\n");

        //male
        if (!girl && player.hasCock()) {
            outputText("Yara's pursed lips touch down upon your cockhead, her head tilting from side to side as she vexingly and repeatedly kisses your " + cockDescript(x) + ".  However, she abruptly pauses, glancing sidelong at you expectantly.  When you don't immediately respond, she huffs a sigh - onto your dick - and raises her hips level with your nose.  After momentarily getting lost in the bouncing of her tight-yet-jiggly cheeks, you get the message, leaning forward and giving her puffy sex a long and lingering lick.  You're rewarded with a low-pitched and very satisfied groan.  Though you go in for another taste, the shining ring looped through her joy-buzzer attracts your oral attention like a magnet.  Gently as a newborn kitten, your teeth close down on the clit-embedded trinket.  Yara goes absolutely stiff as you begin to softly tug the piercing around, neatly paralyzed by the sensitivity.  Indistinguishable mewling tumbles from her mouth as she attempts to attune herself to your yanking antics.  Her lithe frame spasms in ecstasy, forcing you to release your grip on her, lest something unfortunate happen to her undercarriage.\n\n");
            outputText("As soon as you release her from the mind-numbing grasp, she whips her hips forward - spattering your [armor] with her downpour of girlcum in the process - and leaning back, hastily lining herself up with your " + cockDescript(x) + ".  Only hesitating for a second to leak a bit of lubricant onto your eager shaft, she plummets downwards, not stopping until her ass slams against your pelvis.\n\n");
            outputText("Yara takes total control, her death-grip on the armrests giving her full coital maneuverability.  Despite the easy entry, you can't believe how well her sopping-wet folds squeeze against you.  For a long while the only sounds heard are the slapping of her cheeks and the studded-up cat girl's halting pants of pleasure.  \"<i>I wanna say... your new piercing... works like a charm,</i>\" she mutters between throaty groans.\n\n");
            outputText("Before you're even allowed to respond, Yara's pace quickens, her finish line in sight.  More than eager to help spur her on, your hands wrap around her slender waist.  She purrs in appreciation of your assistance.  It's not long before, with a victorious and primal scream, she throws all her weight downwards, splattering the mixture of pre-cum and femspunk and actually stinging you a bit with the force of her descent.\n\n");
            outputText("The powerful motion is all the motivation your body needs.  Before either of you can even consider the ramifications of an internal ejaculation, your bodies seize up, caught in the familiar grasp of orgasmic bliss.  ");
            //([cum quantity time, normal L/M/H/S quantities {IT'S A MARVEL REFERENCE} <no new paragraph>]
            //light and medium
            if (player.cumQ() < 500) {
                outputText("Yara's entire frame spasms as your load paints her private passage with snowy-white seed.  The cat girl writhes happily, arching her spine so far back your eyes nearly meet.\n\nYara dismounts your dick and hops to the ground in one fluid movement.");
            }//heavy
            else if (player.cumQ() <= 1500) {
                outputText("Yara's belly visibly plumps with the quantity of cum you pour into her, the extra weight bending her over to rest heavily against your [leg].  She purrs happily, patting her distended gut even while the tremors of her own orgasm run through her.\n\nYara lifts herself off you, pressing a hand against her tummy as she somewhat ungracefully steps off the chair.");
            }//special (super-big)
            else {
                outputText("Her low-pitched ecstatic moans swiftly escalate to piercing shrieks as her taut belly quickly balloons to roughly beach ball-sized in moments.  With a huge effort, she manages to haul herself off your semen-pumping staff, falling back against you.  Sighing contentedly, Yara nestles herself into your " + chestDesc() + ", getting comfortable despite the seed drizzling from her overstuffed nethers.  You just sit there for a few minutes, waiting patiently as your ejaculatory rampage ceases.\n\nYara makes a noble attempt to rise that is ultimately thwarted by her huge fluid-filled belly.  Casting a sidelong sheepish grin at you, she giggles nervously.  \"<i>Mind helping me out here, friend?</i>\" she says after a moment's hesitation.  With your assistance, she rises and stands on wobbling feet.  She tries her best to compose herself with your cum still streaming down her thighs, the flow only intensifying as she impatiently presses against the bloated belly.");
            }
            outputText("\n\n\"<i>Works like a charm,</i>\" she concludes as you both redress");
            if (player.cumQ() > 1500) {
                outputText(", Yara trying her best to fit her clothes over the bump in her midsection");
            }
            outputText(".  \"<i>Come back whenever, okay?  I'm sure we can arrange another... appointment!</i>\"");
            //ZA ENDO
        }
        //female
        else {
            outputText("A duo of errant forefingers run along the perimeter of your feminine fortress, your signal to prepare for a siege.  Yara reaches down off the side of your seat, pushing on a lever that sends the back of the chair down to about a 30º angle.  She grasps for the armrests of the chair next, promptly lifting her body up and going into what looks like a forward somersault.  Before you can complement the feat, her legs fly up either side of your head.   The only things to have made contact were her nimble feet, gently stroking their way up from your belly, past your chest, off of your shoulders and soaring beyond the back of the chair.  The feline acrobat calls for you to lay your hands open at the sides of the chair, an order you fulfill with due haste.  She wastes no time in seizing your upper arms, causing her body to slide forward off of you.  You return the favor by clasping onto her as well in the same manner, stopping her descent.\n\n");
            outputText("Trying to parse out the scene at play here is a fool's errand.  Yara must have done this before as your two sprawled out bodies have stopped in just the right fashion to make both of your fleshy orifices in plain view of one another's faces.  Air escapes your pursed lips as the \"<i>quality testing</i>\" commences on your " + vaginaDescript() + ", your kitty comrade going in tongue first towards your silken fringes.  ");
            if (player.wetness() >= 3) {
                outputText("She may as well be licking a melting popsicle with how wet your snatch is.");
            } else {
                outputText("Your relatively dry perimeter makes for an easy target.");
            }
            outputText("  Not to be outdone, your ambitious tongue moves in as if it has everything to prove, mirroring your partner's efforts. Both of your lapping endeavors are periodically interrupted by moaning or slight gasps, your grasps on one another only growing more tense.\n\n");
            outputText("Yara looks up - down in her case - at your " + clitDescript() + ", your feminine fragrance riling her up as if it were catnip. Your work on her box is interrupted as your pleasure buzzer gets the oral shebang of a lifetime, eliciting a knowing laugh from deep within your teammate's throat.  Yara's lucky you redouble your clamp on her arms rather than sending the poor woman sliding to the ground as your body writhes in satisfaction.  But this is war, and you'll be damned if you're weak enough to go straight for the crown jewel as she has. No, you go to town, redefining what it means to eat out a pussy.  Your laborious toil is rewarded as the kitten's assault on your button eases up.  Her hold begins to waver, however, forcing you to yank your prey towards you.  The movement pierces through her contentment, her armlock strengthening as the air fills with the sound of a duo of muffled moans.\n\n");
            outputText("Judging by the contortionist's wobbly embrace, you decide it's the perfect time to go in for the kill.  Yara stands no chance as you pounce for her pierced clit, your tongue lodging itself between the loop and her love-button.  It takes all of her willpower to maintain the offensive on your nub nexus while standing firm in her grasp on your arms.  Your oral tugging and teasing proves to be the victor, however, marked by the femspunk making its way right onto your face.  The cocktail combined with the orgasmic-enhanced last ditch effort by Yara on your nether regions triggers your own satisfying outburst.  The chain reaction ends in both your couplings faltering, sending the feline sliding headfirst for the floor.\n\n");
            outputText("Her head stops short, though.  Through your gasping relief, you managed to lock onto her legs.  \"<i>Nice... nice catch,</i>\" is about all Yara manages to share before resuming her purring contentment upside down, limp arms spread across the floor.  After a minute or so, the two of you regain some sort of composure, but the spectacular gymnast from before can only bare to slink around on the ground as she reorients herself.  The most you need to do is fix the back of your chair, lifting it to a more comfortable height.  \"<i>Can you spare one more helping hand here, friend?</i>\" Yara requests, now having at least managed to at least sit up straight.  The two of you exchange a knowing glance as you lift the metal-worker back to her feet.");
        }
        player.orgasm();
        doNext(piercingStudio);
    }
}
}