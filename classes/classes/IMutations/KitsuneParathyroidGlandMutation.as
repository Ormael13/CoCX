/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Tail;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkType;
import classes.Player;

public class KitsuneParathyroidGlandMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.KitsuneParathyroidGlandIM);
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
            switch (player.perkv1(IMutationsLib.KitsuneParathyroidGlandIM)){
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
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.KitsuneParathyroidGlandIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.KitsuneParathyroidGlandIM.requireParathyroidGlandMutationSlot()
                    .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tailType == Tail.FOX && player.tailCount >= 2;
                    }, "2+ fox tails")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.kitsuneScore() >= 9;
                    }, "Kitsune race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.KitsuneParathyroidGlandIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier >= 1) {
                pBuffs['spe.mult'] += 0.05;
                pBuffs['int.mult'] += 0.05;
            }
            if (pTier >= 2) {
                pBuffs['spe.mult'] += 0.05;
                pBuffs['int.mult'] += 0.1;
            }
            if (pTier >= 3) {
                pBuffs['spe.mult'] += 0.05;
                pBuffs['int.mult'] += 0.2;
            }
            return pBuffs;
        }

        public function KitsuneParathyroidGlandMutation() {
            super("Kitsune Parathyroid Gland IM", "Kitsune Parathyroid Gland", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}