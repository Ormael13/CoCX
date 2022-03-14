/**
 * Created by aimozg on 27.01.14.
 */
package classes.Mutations
{
import classes.MutationsLib;
import classes.PerkClass;
import classes.PerkType;


public class KitsuneThyroidGlands extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        var descS:String = ""
        var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland)
        if (pTier >= 1){
            descS += "Illusion & Terror -3CD";
        }
        if (pTier >= 2){
            descS += ", FoxFire +50% damage (fire and lust)";
        }
        if (pTier >= 3){
            descS += ", +20% Evasion to Illusion, +50 speed debuff to Terror target, +SF/Mana regen (Star Sphere rank x3/2 respectively), increase Star Sphere Max to 20";
        }
        if (descS != "")descS += ".";
        return descS;
    }


    public function longDesc(params:PerkClass = null):String{
        var descS:String = ""
        var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland)
        if (pTier >= 1){
            descS = "Cooldowns for Illusion and Terror are lowered by three turns. ";
        }
        if (pTier >= 2){
            descS += "Foxfire gains an additional 50% damage. ";
        }
        if (pTier >= 3){
            descS += "Evasion from Illusion is increased by 20%, incur a further 50 speed debuff to terror target, increase SF/Mana regen based on Star Sphere Rank, and increases Star Sphere max rank to 20.";
        }
        return descS;
    }

    override public function name(params:PerkClass=null):String {
        var sufval:String = "";
        switch (player.perkv1(MutationsLib.KitsuneThyroidGland)){
            case 2:
                sufval = "(Primitive)";
                break;
            case 3:
                sufval = "(Evolved)";
                break;
        }
        return "Kitsune Thyroid Gland " + sufval;
    }

    public function KitsuneThyroidGlands() {
        super("Kitsune Thyroid Gland", "Kitsune Thyroid Gland",
                ".", ".");
	}

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }

    public static function perkBuffs():Object {
        var pBuffs:Object = {};
        var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland)
        pBuffs['spe.mult'] = 0.05 * pTier;
        if (pTier - 1 != 0) pBuffs['wis.mult'] = 0.05 * (pTier - 1);
        if (pTier - 2 != 0) pBuffs['int.mult'] = 0.05 * (pTier - 1);
        return pBuffs
    }
}
}