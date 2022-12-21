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

public class HarpyHollowBonesMutation extends IMutationPerkType
    {
        private static const mName:String = "Harpy Hollow Bones";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your speed and physical damage by 20%";
            }
            if (pTier >= 2){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your physical damage by 50% and speed by 45% and evasiveness by 10%";
            }
            if (pTier >= 3){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your physical damage by 80% and speed by 90%, evasiveness by 10%, \"Great Dive\" damage by 50%, and prevents it from ending flight";
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
                    this.requireBonesAndMarrowMutationSlot()
                    .requireAnyRace(Races.HARPY, Races.SIREN, Races.THUNDERBIRD, Races.PHOENIX, Races.COUATL);
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
            if (pTier == 1) {
                pBuffs['spe.mult'] = 0.2;
                pBuffs['tou.mult'] = -0.05;
            }
            if (pTier == 2) {
                pBuffs['spe.mult'] = 0.45;
                pBuffs['tou.mult'] = -0.1;
            }
            if (pTier == 3) {
                pBuffs['spe.mult'] = 0.9;
                pBuffs['tou.mult'] = -0.15;
            }
            return pBuffs;
        }

        public function HarpyHollowBonesMutation() {
            super(mName + " IM", mName, SLOT_BONE, 3);
        }
        
    }
}
