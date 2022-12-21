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

public class DraconicHeartMutation extends IMutationPerkType
    {
        private static const mName:String = "Draconic Heart";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Your heart was strengthened to better handle your changing body. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen)";
            }
            if (pTier >= 2){
                descS = "Each heartbeat fills your body with great power. (+2 Fatigue / +8 SF / +10 Mana / +2 Wrath regen, +5% of max core Str as phantom Str)";
            }
            if (pTier >= 3){
                descS = "Your heart metamorphosis reached pseudo-dragon level. (+3 Fatigue / +12 SF / +15 Mana / +3 Wrath regen, +1% HP regen, +15% of max core Str as phantom Str)";
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
                    this.requireHeartMutationSlot()
                    .requireMutation(IMutationsLib.DraconicBonesIM)
                    .requireAnyRace(Races.DRAGON,Races.FROSTWYRM, Races.YGGDRASIL,Races.SEA_DRAGON, Races.FAERIEDRAGON);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.35;
            return pBuffs;
        }

        public function DraconicHeartMutation() {
            super(mName + " IM", mName, SLOT_HEART, 3);
        }

    }
}