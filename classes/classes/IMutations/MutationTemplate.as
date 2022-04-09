/**
 * Original code by aimozg on 27.01.14.
 * Reworked for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Tail;
import classes.MutationsLib;
    import classes.PerkClass;
    import classes.PerkType;
    import classes.PerkLib;
    import classes.Player;

    public class MutationTemplate extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MutationsTemplateIM)
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += "";
            }
            if (pTier >= 3){
                descS += "";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Doesn't work.... for now.
        /*
        public function llongDesc(params:PerkClass = null):String{
            var descS:String = ""
            var pTier:int = player.perkv1(IMutationsLib.)
            if (pTier >= 1){
                descS = "";
            }
            if (pTier >= 2){
                descS += "";
            }
            if (pTier >= 3){
                descS += "";
            }
            return descS;
        }*/

        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.MutationsTemplateIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "PerkName Here" + sufval;
        }

        public function MutationTemplate() {
            super("PerkName Here", "PerkName Here", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }

        public static function mutationReqs():void{
            var pTier:int = player.perkv1(IMutationsLib.MutationsTemplateIM);
            switch (pTier){
                case 0:
                    IMutationsLib.MutationsTemplateIM.requireThyroidGlandMutationSlot().requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune).requireCustomFunction(function (player:Player):Boolean {
                        return player.tailType == Tail.FOX && player.tailCount >= 2;
                    }, "2+ fox tails");
                    break;
                case 1:
                    IMutationsLib.MutationsTemplateIM.requireLevel(30)
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.perkv1(IMutationsLib.MutationsTemplateIM) == 1;
                            }, "Previous perk tier required.");
                    break;
                case 2:
                    IMutationsLib.MutationsTemplateIM.requireLevel(60)
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.perkv1(IMutationsLib.MutationsTemplateIM) == 2;
                            }, "Previous perk tier required.");
                    break;
            }
        }

        public static function perkBuffs():Object {
            var pBuffs:Object = {};
            var pTier:int = player.perkv1(IMutationsLib.MutationsTemplateIM)
            pBuffs['spe.mult'] = 0.05 * pTier;
            if (pTier - 1 != 0) pBuffs['wis.mult'] = 0.05 * (pTier - 1);
            if (pTier - 2 != 0) pBuffs['int.mult'] = 0.05 * (pTier - 1);
            return pBuffs
        }
    }
}