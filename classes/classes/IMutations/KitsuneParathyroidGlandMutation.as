/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Tail;
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class KitsuneParathyroidGlandMutation extends IMutationPerkType
    {
        private static const mName:String = "Kitsune Parathyroid Gland";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Illusion and Terror cooldown reduced by 3 turns";
            }
            if (pTier >= 2){
                descS += ", Mana and fatigue recovery increased, 50% reduced costs for Illusion and Terror";
            }
            if (pTier >= 3){
                descS += ", further boost mana regen based on star sphere rank, speed debuff from Terror increased to 70, evasion boost from Illusion increased by 30%";
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
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireParathyroidGlandMutationSlot()
                    .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune, PerkLib.StarSphereMastery)
                    .requireAnyRace(Races.KITSUNE, Races.KITSHOO);
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
                pBuffs['spe.mult'] = 0.05;
                pBuffs['int.mult'] = 0.05;
            }
            if (pTier == 2) {
                pBuffs['spe.mult'] = 0.1;
                pBuffs['int.mult'] = 0.15;
            }
            if (pTier == 3) {
                pBuffs['spe.mult'] = 0.15;
                pBuffs['int.mult'] = 0.35;
            }
            return pBuffs;
        }

        public function KitsuneParathyroidGlandMutation() {
            super(mName + " IM", mName, SLOT_PARATHYROID, 3);
        }
        
    }
}
