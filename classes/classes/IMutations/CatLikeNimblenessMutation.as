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

public class CatLikeNimblenessMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.CatLikeNimblenessIM);
            if (pTier >= 1){
                descS += "Increases Evasion";
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

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.CatLikeNimblenessIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Cat-like Nimbleness" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.CatLikeNimblenessIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.CatLikeNimblenessIM.requirePerk(PerkLib.Flexibility)
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.catScore() >= 8 || player.nekomataScore() >= 10 || player.displacerbeastScore() >= 14 || player.hellcatScore() >= 10 || player.cheshireScore() >= 11 || player.sphinxScore() >= 14;
                    }, "Any cat race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.CatLikeNimblenessIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Perk Max Level
        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier >= 1) pBuffs['spe.mult'] += 0.1;
            if (pTier >= 2) pBuffs['spe.mult'] += 0.2;
            return pBuffs;
        }

        public function CatLikeNimblenessMutation() {
            super("Cat-like Nimbleness IM", "Cat-like Nimbleness", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}