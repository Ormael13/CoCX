/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Player;

public class ScyllaInkGlandsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
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
            switch (currentTier(this)){
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
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requirePerk(PerkLib.InkSpray)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.scyllaScore() >= 7;
                    }, "Scylla race");
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
        override public function pBuffs():Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this);
            if (pTier == 1) pBuffs['str.mult'] = 0.1;
            //else if (pTier == 2) pBuffs['int.mult'] = 0;
            //else if (pTier == 3) pBuffs['int.mult'] = 0;
            return pBuffs;
        }

        public function ScyllaInkGlandsMutation() {
            super("Scylla Ink Glands IM", "Scylla Ink Glands", ".");
            maxLvl = 1;
        }
        
    }
}