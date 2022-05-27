/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;

public class CatLikeNimblenessMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
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
            switch (currentTier(this, player)){
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
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requirePerk(PerkLib.Flexibility)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.catScore() >= 8 || player.nekomataScore() >= 10 || player.displacerbeastScore() >= 14 || player.hellcatScore() >= 10 || player.cheshireScore() >= 11 || player.sphinxScore() >= 14;
                    }, "Any cat race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:Creature = null):Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this, (target == null)? player : target);
            if (pTier == 2) pBuffs['spe.mult'] = 0.1;
            if (pTier == 3) pBuffs['spe.mult'] = 0.3;
            return pBuffs;
        }

        public function CatLikeNimblenessMutation() {
            super("Cat-like Nimbleness IM", "Cat-like Nimbleness", ".");
            maxLvl = 3;
        }
        
    }
}