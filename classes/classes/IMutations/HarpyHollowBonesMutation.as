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
        override public function get mName():String {
            return "Harpy Hollow Bones";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your speed and physical damage by 20%";
            }
            if (pTier >= 2){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your physical damage by 50%, your speed by 45% and evasiveness by 10%";
            }
            if (pTier >= 3){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your physical damage by 80%, your speed by 90%, evasiveness by 10%, \"Great Dive\" damage by 50%, and prevents it from ending flight";
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
                    this.requireBonesAndMarrowMutationSlot()
                    .requireAnyRace(Races.HARPY, Races.SIREN, Races.THUNDERBIRD, Races.PHOENIX, Races.COUATL, Races.AVIAN, Races.GRYPHON, Races.PEACOCK);
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
