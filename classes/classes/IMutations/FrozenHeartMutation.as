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
                descS += "Allow you to retain the ability Ice barrage and hungering cold at all times";
            }
            if (pTier >= 3){
                descS += ", hungering cold lasts for 3 additional turn(s) and recharge 3 turn(s) faster. Gain an extra modifier from your intelligence to health. (Increase original value by 50%).";
            }
            else if (pTier >= 2){
                descS += "hungering cold last for 1 additional turn and recharge 1 turn faster";
            }
            if (pTier >= 1) descS += "and increase their damage by " + 10 * pTier + "%";
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
