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

public class OrcAdrenalGlandsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
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
            return "Orc Adrenal Glands" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Ferocity).requireCustomFunction(function (player:Player):Boolean {
                        return player.orcScore() >= 11;
                    }, "Orc race");
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
            if (pTier == 2) pBuffs['str.mult'] = 0.5;
            else if (pTier == 3) pBuffs['str.mult'] = 1;
            return pBuffs;
        }

        public function OrcAdrenalGlandsMutation() {
            super("Orc Adrenal Glands IM", "Orc Adrenal Glands", ".");
            maxLvl = 3;
        }
        
    }
}