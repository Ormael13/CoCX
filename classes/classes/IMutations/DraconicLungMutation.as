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
import classes.Races;

public class DraconicLungMutation extends IMutationPerkType
    {
        private static const mName:String = "Draconic Lung";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Allows you to use breath attacks more often. (All dragon breaths usable once per combat)";
            }
            if (pTier >= 2){
                descS = "Increases threefold the power of dragon breath attacks. (+300% to dragon breaths damage, +5% of max core Spe as phantom Spe)";
            }
            if (pTier >= 3){
                descS = "Increases dragon breath attacks power and allows you to combine all 4 basic breath types more often. (+900% to dragon breaths damage, +20% of max core Spe as phantom Spe)";
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
            return mName + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireLungsMutationSlot()
                    .requirePerks(PerkLib.DragonFireBreath, PerkLib.DragonIceBreath, PerkLib.DragonLightningBreath, PerkLib.DragonDarknessBreath)
                    .requireRace(Races.DRAGON);
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
        override public function buffsForTier(pTier:int):Object {
            var pBuffs:Object = {};
            if (pTier == 1) pBuffs['spe.mult'] = 0.05;
            if (pTier == 2) pBuffs['spe.mult'] = 0.15;
            if (pTier == 3) pBuffs['spe.mult'] = 0.35;
            return pBuffs;
        }

        public function DraconicLungMutation() {
            super(mName + " IM", mName, SLOT_LUNGS, 3);
        }

    }
}
