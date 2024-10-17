/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class FrozenHeartMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Frozen Heart";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Allows you to retain the abilities Ice Barrage and Hungering Cold at all times and increase their damage by " + 10 * pTier + "%";
            }
            if (pTier >= 3){
                descS += ", Hungering Cold lasts for 3 additional turns and recharges 3 turns faster. Gain an extra modifier from your intelligence to health. (Increases original value by 50%)";
            }
            else if (pTier >= 2){
                descS += ". Hungering Cold lasts for an additional turn and recharges 1 turn faster";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireHeartMutationSlot()
                    .requireRace(Races.YUKIONNA)
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
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function FrozenHeartMutation() {
            super(mName + " IM", mName, SLOT_HEART, 3);
        }

    }
}
