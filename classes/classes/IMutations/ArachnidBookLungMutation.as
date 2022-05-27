/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;

    public class ArachnidBookLungMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increase web and poison capacity by " + 100 * pTier + "%";
            }
            if (pTier >= 2){
                descS += ", increases all Web abilities effectiveness by half ";
            }
            if (pTier >= 3){
                descS += ", and gives them a 50% chance to immobilize opponents for 2 rounds when opponent tries to struggle out";
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
            return "Arachnid Book Lung" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireAdaptationsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.spiderScore() >= 5 || player.atlachNachaScore() >= 21;
                    }, "Arachnid race");
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
            if (pTier == 1) pBuffs['int.mult'] = 0.05;
            else if (pTier == 2) pBuffs['int.mult'] = 0.15;
            else if (pTier == 3) pBuffs['int.mult'] = 0.3;
            return pBuffs
        }

        public function ArachnidBookLungMutation() {
            super("Arachnid Book Lung IM", "Arachnid Book Lung", ".");
            maxLvl = 3;
        }
        
    }
}