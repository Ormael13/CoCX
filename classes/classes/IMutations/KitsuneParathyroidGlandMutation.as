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
import classes.Player;
import classes.Races;

public class KitsuneParathyroidGlandMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM);
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
            switch (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Kitsune Parathyroid Gland" + sufval;
        }

        //Mutation Requirements
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.KitsuneParathyroidGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.KitsuneParathyroidGlandsIM.requireParathyroidGlandMutationSlot()
                    .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                    .requireRace(Races.KITSUNE);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.KitsuneParathyroidGlandsIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
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
            super("Kitsune Parathyroid Gland IM", "Kitsune Parathyroid Gland", ".");
            maxLvl = 3;
        }

        
    }
}
