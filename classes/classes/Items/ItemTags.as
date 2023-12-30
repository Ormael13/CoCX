package classes.Items {
public class ItemTags {
    function ItemTags() {
    }

    //////////////
    // Armor tags
    //////////////
    
    /**
     * For armors that display a lot of skin and thus count as naked for tease purpose and perks such as naked truth
     * Value: none.
     */
    public static const A_REVEALING:String      = "Revealing";
    /**
     * For armors that are flexible or nearly as flexible as if wearing nothing
     * Value: none.
     */
    public static const A_AGILE:String          = "Agile";
    /**
     * For consumables that trigger a transformation
     */
    public static const U_TF:String             = "tf";
    /**
     * To legendary items, which will have a level requirement to equip
     */
    public static const I_LEGENDARY:String     = "Legendary";
}
}
