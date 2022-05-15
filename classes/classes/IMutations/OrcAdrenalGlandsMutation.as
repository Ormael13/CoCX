/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
import classes.PerkLib;
import classes.PerkType;
import classes.Player;

public class OrcAdrenalGlandsMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.OrcAdrenalGlandsIM);
            if (pTier == 1){
                descS = "Your Orc adrenal glands are increasing Ferocity limit by 1%, +5% of max core Str as phantom Str";
            }
            if (pTier == 2){
                descS = "Your Orc adrenal glands are increasing Ferocity limit by 3%, +15% of max core Str as phantom Str, increase your natural strength and tone";
            }
            if (pTier == 3){
                descS = "Your Orc adrenal glands are increasing Ferocity limit by 3%, +30% of max core Str as phantom Str, increase your natural strength and tone, boost natural wrath generation rate, allow to use Ferocity even when been no longer an orc";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Orc Adrenal Glands" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.OrcAdrenalGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.OrcAdrenalGlandsIM.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Ferocity).requireCustomFunction(function (player:Player):Boolean {
                        return player.orcScore() >= 11;
                    }, "Orc race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.OrcAdrenalGlandsIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        public static var _perkLvl:int = 3;

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier == 2) pBuffs['str.mult'] = 0.5;
            else if (pTier == 3) pBuffs['str.mult'] = 1;
            return pBuffs;
        }

        public function OrcAdrenalGlandsMutation() {
            super("Orc Adrenal Glands IM", "Orc Adrenal Glands", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}