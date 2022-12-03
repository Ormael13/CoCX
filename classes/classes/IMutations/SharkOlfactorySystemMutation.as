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

public class SharkOlfactorySystemMutation extends IMutationPerkType
    {
        private static const mName:String = "Shark Olfactory System";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            var perkCent:int = 0;
            var bleedCent:int = 0;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increase bleed damage by 50%, allows non-sharks to use blood frenzy";
                perkCent += 10;
            }
            if (pTier >= 2){
                perkCent += 15;
				bleedCent += 50;
            }
            if (pTier >= 3){
                perkCent += 20;
				bleedCent += 50;
            }
            if (pTier >= 4){
                perkCent += 25;
				bleedCent += 50;
            }
            if (pTier >= 2) descS += ", Bite becomes free and increases bleed damage by " + bleedCent + " %";
            if (pTier >= 1) descS += "and increase melee damage against bleeding enemies by " + perkCent + " %";
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
                case 3:
                    sufval = "(Final Form)";
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
                    this.requirePeripheralNervSysMutationSlot()
                    .requireAnyRace(Races.SHARK, Races.SIREN);
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
                pBuffs['spe.mult'] = 0.05;
            }
            else if (pTier == 2) {
                pBuffs['wis.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.1;
            }
            else if (pTier == 3) {
                pBuffs['int.mult'] = 0.05;
                pBuffs['wis.mult'] = 0.1;
                pBuffs['spe.mult'] = 0.15;
            }
            else if (pTier == 4) {
                pBuffs['int.mult'] = 0.1;
                pBuffs['wis.mult'] = 0.15;
                pBuffs['spe.mult'] = 0.25;
            }
            return pBuffs;
        }

        public function SharkOlfactorySystemMutation() {
            super(mName + " IM", mName, SLOT_NERVSYS, 4);
        }

    }
}
