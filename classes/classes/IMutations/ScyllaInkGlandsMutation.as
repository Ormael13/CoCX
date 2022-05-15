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

public class ScyllaInkGlandsMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.ScyllaInkGlandsIM);
            if (pTier >= 1){
                descS += "Your Scylla Ink Glands increase rate at which your body produce ink and slight boost to your natural strength";
            }
            if (pTier >= 2){
                descS += ", ";
            }
            if (pTier >= 3){
                descS += ", ";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.ScyllaInkGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Scylla Ink Glands" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.ScyllaInkGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.ScyllaInkGlandsIM.requirePerk(PerkLib.InkSpray)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.scyllaScore() >= 7;
                    }, "Scylla race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.ScyllaInkGlandsIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 1;
        }

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier == 1) pBuffs['str.mult'] = 0.1;
            //else if (pTier == 2) pBuffs['int.mult'] = 0;
            //else if (pTier == 3) pBuffs['int.mult'] = 0;
            return pBuffs;
        }

        public function ScyllaInkGlandsMutation() {
            super("Scylla Ink Glands IM", "Scylla Ink Glands", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}