package classes {

import classes.Scenes.SceneLib;

public class PotionType {
    // declare properties here
    public var ID:String;
    public var name:String;
    public var description:String;
    public var recipe:Object;
    public var effect:Function;

    public function PotionType(ID:String, name:String, description:String, recipe:Object, effect:Function) {
        this.ID = ID;
        this.name = name;
        this.description = description;
        this.recipe = recipe;
        this.effect = effect;

        ALL_POTIONS[ID] = this;
    }

    /**
     * key = ID
     * object = PotionType
     */
    public static var ALL_POTIONS:Object = {};

    // you'll be initializing items in library like this:
    /*public static var POULTICE:PotionType = new PotionType("POULTICE", "Poultice", "Apply a healing salve to your wounds in order to recover health.",[], SceneLib.combat.Poultice);
    public static var ENERGYDRINK:PotionType = new PotionType("E.DRNK", "Energy drink", "Use an energy drink to recover your resources.",[], SceneLib.combat.EnergyDrink);
    public static var CURE:PotionType = new PotionType("CURE", "Cure", "Negate status ailments.",[], SceneLib.combat.Cure);
    public static var PAINKILLER:PotionType = new PotionType("P.KILL", "Painkiller", "Greatly reduce damage taken.",[], SceneLib.combat.Painkiller);
    public static var STIMULANT:PotionType = new PotionType("STIM", "Stimulant", "Increase physical attack power.",[], SceneLib.combat.Stimulant);
    public static var PERFUME:PotionType = new PotionType("PERFUME", "Perfume", "Empower tease through scent components.",[], SceneLib.combat.Perfume);*/
}
}
