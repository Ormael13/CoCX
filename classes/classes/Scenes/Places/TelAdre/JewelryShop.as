package classes.Scenes.Places.TelAdre {
import classes.ItemType;

/**
 * Updated strings
 * @ContentAuthor Starglider
 */
public class JewelryShop extends Shop {
    public static var firstEntry:Boolean = true;

    public function JewelryShop() {
    }

    //-----------------
    //-- JEWELRY STORE
    //-----------------
    public override function enter():void {
        spriteSelect(sprite);
        clearOutput();
        if(firstEntry){
            outputText("Among the many markets of Tel'Adre, one oddity manages to snare " +
                    "your attention. A simple stall with an askew sign reading 'Jewels!' in calamitous cursive. Its wares are " +
                    "mostly shrouded by a hole-riddled awning, though small rays of desert sun make use of the tears to " +
                    "playfully dazzle a collection of tarnished treasures. Metal-laced glassware, necklaces, rings, baubles, " +
                    "clasps and more are haphazardly hung from the latticed walls.\n\n" +
                    "In the uneven glow of glinting glassware sits a short figure, no more than 4 feet tall. His appearance is " +
                    "shrouded by the hood and wraps of an all-concealing shawl, the opaque fabric patterned with distant " +
                    "dunes and trimmed in a glimmer of gold-threaded tassles.\n\n" +
                    "Your staring is interrupted by a passerby eclipsing your vision, and before you can even consider the " +
                    "interruption you notice the one manning the stall is gone. Not a blink of the eye later and your wrist is " +
                    "grasped by spindly fingers covered in a ratty, dirty gauze, the slightest hint of emerald scales revealing " +
                    "themselves through cracks and tears. Despite the initial urge to stand your ground, the cloaked figure's " +
                    "two-handed grip is surprisingly overbearing for such a short man. \"<i>Ah! Don't be ssshy! Don't be ssshy... " +
                    "I could sssee your interesst, a [man] with a sssharp eye for beauty!</i>\" He waffles disarmingly as he " +
                    "drags you to the stall, his short, strained movements causing his impressive collection of bangles to " +
                    "clatter together noisily. Once getting you off the street, he hops onto the rackety counter, which " +
                    "miraculously doesn't fall apart.\n\n" +
                    "He gestures around to the multitude of adornments hanging in the stall. \"<i>Beautiful baubless and " +
                    "gleaming gemstoness, only the finesst jewelry for the presstigious patron! Keheh!</i>\" The merchant " +
                    "cackles as he grinds his gauzy gloves together, creating a rather discomforting, scratchy sound");
            firstEntry =false;
        } else {
            outputText("The jewelry merchant perks his head up a little as he sees you " +
                    "approach, hailing your visit with a welcoming wave. \"<i>Kehehehe! Greetingss again, traveler. " +
                    "Ssscrounged up the gemss to adorn yoursself with my waress? Let uss hope sso...</i>\" He goes silent, " +
                    "knitting his gauzed fingers together as he observes your perusal.")
        }

        doNext(inside);
    }

    protected override function inside():void {
        clearOutput();
        outputText("<i>So what will it be?</i>");
        menu();
        addButton(0, "Normal rings", normalRings);
        addButton(1, "Special rings", specialRings);
        addButton(2, "Enchanted rings",enchantedRings);
        addButton(5, "Jewelry box",curry(confirmBuy, null, 500, "Equipment Storage - Jewelry Box"));
        addButton(14, "Leave", telAdre.telAdreMenu);
    }
    protected override function confirmBuy(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        clearOutput();
        if (keyItem == "Equipment Storage - Jewelry Box") {
            if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) {
                outputText("<b>You already own a jewelry box!</b>");
                doNext(inside);
                return;
            }
            outputText("Your eyes rest on the shelf beyond the merchant, this one stocked with small " +
                    "wooden boxes. The merchant, following your eyes with greed in his own, snatches a box off the shelf " +
                    "and strokes its surface gently, producing a light hum \"<i>Ah! Keen again, what proud jewelry owner " +
                    "would be without ssafe sstorage for their pricelesss gemss? Not you, not for a ssmall fee! Yess, with " +
                    "one of thesse lockboxess, no marauder or ssilly fox in tightss wielding a kebab will ssnatch from you " +
                    "your preciouss accesssoriess. If only chasstity beltss were as sstrong as my boxess... Ah, wouldn't be " +
                    "much fun, though, would it? Keheheheh! 500 gemss!</i>\"");
        } else {
            outputText("The merchant stares at your hands as you point out the item with an almost " +
                    "palpable excitement. \"<i>Ah, excellent choice!</i>\" He scoops up the accessory and hefts it a couple times in " +
                    "his palm, \"<i>Keheh, I'd be willing to part with it for, ssay, "+itype.value+" gems?</i>\"");
        }
        super.confirmBuy(itype, priceOverride, keyItem);
    }

    protected override function noBuyOption(itype:ItemType = null, keyItem:String = ""):void {
        clearOutput();
        if(keyItem == "Equipment Storage - Jewelry Box"){
            outputText("You decline with a firm hand and a shake of your head, prompting the " +
                    "merchant to whisper a growl. \"<i>Bah, fine! You'd besst have a good hiding place, then.</i>\" He leans a little " +
                    "beyond the counter on his spindly arms, taking a look at your [butt]. He's stoic at first, " +
                    "but he settles down to the tune of a chuckle.")
        } else {
            outputText("You decline the offer, causing the merchant to scoff and cross his arms. " +
                    "\"<i>Mmn, dissappointing. Kehehehe, ssuit yourself!</i>\"");
        }
        doNext(inside);
    }

    protected override function debit(itype:ItemType = null, priceOverride:int = -1, keyItem:String = ""):void {
        if (keyItem == "Equipment Storage - Jewelry Box") {
            outputText("You nod a bit skeptically, but hand over the 500 gems. It's worth the " +
                    "organizational value. You reach out to take the box from the counter, but he hisses rather alarmingly, " +
                    "moving an arm to block you. Taken aback, you watch on as the odd little merchant checks the gem's " +
                    "authenticity with dice-rolling and tapping. \"<i>Sseemsss all's in order. Thank you kindly! Keheheh...</i>\"\n\n" +
                    "More carefully, you pick up the box without hassle and stow it away as the merchant does the same " +
                    "with your gems");
        } else {
            outputText("The minute you finish counting out your gems, he snatches them from " +
                    "your hand and replaces it with your purchase, quietly snickering to himself as he cradles the gems in " +
                    "both hands.")
        }
        super.debit(itype, priceOverride, keyItem);
    }

    private function normalRings():void {
        clearOutput();
        outputText("A standard collection of jewelry hangs from small pegs on the left side of the " +
                "stall, gemmed and set in all manner of colors. The merchant taps his fingers together impatiently as you " +
                "peruse, giddily whispering to himself. ");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.SILVRNG.shortName, confirmBuy, jewelries.SILVRNG);
        addButton(button++, jewelries.GOLDRNG.shortName, confirmBuy, jewelries.GOLDRNG);
        addButton(button++, jewelries.PLATRNG.shortName, confirmBuy, jewelries.PLATRNG);
        addButton(button++, jewelries.DIAMRNG.shortName, confirmBuy, jewelries.DIAMRNG);
        addButton(14, "Back", inside);
    }
    private function specialRings():void {
        clearOutput();
        outputText(" On the far wall is a shelf of rings hidden behind an out of place cabinet of " +
                "glass. Tags of papyrus paper stricken with odd arcane symbols are plastered all over the transparent " +
                "surface, almost concealing the collection within.\n\n" +
                "The merchant notices your staring and cackles, motioning to the display. \"<i>Ahh! An eye as sssharp as a " +
                "blade! You've picked the most intriguing dissplay in my sstore! Not that the resst of my waress aren't " +
                "intriguing. Thiss little duo hass a different story, however.</i>\" He taps the glass on the side before one of " +
                "the rings, a familiar dark stone stricken with cracks of red. \"<i>They're part of a sset, remnantss of a " +
                "tragedy you ssee. Legend hass it thesse rings were once beautiful maidenss! Thiss one here, jealouss of " +
                "itss counterpart, a bride to be. Before the ceremony, the lecherouss and jealouss maiden asssailed the " +
                "groom and sstole hiss purity. The bride to be, obsesssed with purity, sssacrificed hersself for a cursse, " +
                "turning both of their sssoulss to sstone. And so, this one here is the bride.</i>\" His hand moves a few " +
                "inches and taps the glass again, a contrastingly smooth stone of pearly white just beside it. " +
                "\"<i>Keheheheh... I wouldn't sssell a sssoul for cheap, would you? Let's start at 3,000.</i>\"");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.LTHCRNG.shortName, confirmBuy, jewelries.LTHCRNG);
        addButton(button++, jewelries.PURERNG.shortName, confirmBuy, jewelries.PURERNG);
        addButton(14, "Back", inside);
    }
    private function enchantedRings():void{
        clearOutput();
        outputText("Frankly, it's just a collection of tarnished silver and scratchy  " +
                "gold. You'd probably find better jewelry on corpses. The peddler catches on, swatting a hanging " +
                "necklace away from his wrapped snout. \"<i>Bah! Of coursse, of coursse... Nothing in the dissplay ssstock " +
                "would sssuit you!</i>\" He reaches beneath the counter and pauses for a dramatic speech. \"<i>You're a traveler " +
                "of much mysstery and power, I can smell it on you. Sssorceriess sssurely ressonate with your sssoul!</i>\" " +
                "He delivers a small wooden box to the surface.\n\n" +
                "The box actually looks better than the jewelry you saw before. The wood is stained a brilliant color, and " +
                "laquered smooth like glass. The golden hinges are outlined in silver and shine brilliantly, the matching " +
                "locks in the front forming three identical sundials. With a single wrapped finger, the peculiar merchant " +
                "adjusts the dials, and with a subtle 'click' the box opens on its own. All the tiny drawers within unfold " +
                "like a pop-up book, revealing a small collection of rings. Their craftsmanship and elegance alone are " +
                "jaw-dropping, but there's something less tangibly appealing about them.\n\n" +
                "Seeing your expression, the shrouded man wheezes and glides a hand over the specialty wares. \"<i>The " +
                "powerful are invigorated by thesse ssstoness, but do not be brassh! Thesse jewelss compliment their " +
                "bearer in wayss you may not be expecting! Kehehehehe...</i>\" He fades into a bit of a cough, his reptillian " +
                "eyes revealed for but a moment.\n\n");
        menu();
        var button:int = 0;
        addButton(button++, jewelries.CRIMRNG.shortName, confirmBuy, jewelries.CRIMRNG);
        addButton(button++, jewelries.FERTRNG.shortName, confirmBuy, jewelries.FERTRNG);
        addButton(button++, jewelries.ICE_RNG.shortName, confirmBuy, jewelries.ICE_RNG);
        addButton(button++, jewelries.MANARNG.shortName, confirmBuy, jewelries.MANARNG);
        addButton(button++, jewelries.LIFERNG.shortName, confirmBuy, jewelries.LIFERNG);
        addButton(button++, jewelries.MYSTRNG.shortName, confirmBuy, jewelries.MYSTRNG);
        addButton(button++, jewelries.POWRRNG.shortName, confirmBuy, jewelries.POWRRNG);
        addButton(14,"Back",inside);
    }
}
}
