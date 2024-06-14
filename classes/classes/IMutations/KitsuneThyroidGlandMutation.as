/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.IMutationPerkType;
import classes.Creature;
import classes.PerkClass;
import classes.PerkLib;
import classes.Player;
import classes.BodyParts.Tail;

    public class KitsuneThyroidGlandMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Kitsune Thyroid Gland";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Illusion and Terror cooldown reduced by 3 turns";
            }
            if (pTier >= 2){
                descS += ", 50% reduced costs for Illusion and Terror";
            }
            if (pTier >= 3){
                descS += ", speed debuff from Terror increased to 70, evasion boost from Illusion increased by 30%";//add some more effects to both specials
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
                    this.requireThyroidGlandMutationSlot()
                    .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune, PerkLib.StarSphereMastery)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (player.tailType == Tail.FOX || player.tailType == Tail.KITSHOO) && player.tailCount >= 2;
                    }, "2+ fox/kitsumori tails");
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            if (pTier == 1) {
                pBuffs['spe.mult'] = 0.05;
                pBuffs['wis.mult'] = 0.05;
            }
            if (pTier == 2){
                pBuffs['spe.mult'] = 0.1;
                pBuffs['wis.mult'] = 0.15;
            }
            if (pTier == 3){
                pBuffs['spe.mult'] = 0.15;
                pBuffs['wis.mult'] = 0.35;
                pBuffs['int.mult'] = 0.2;
            }
            return pBuffs;
        }

        //Mutations Buffs
        public function KitsuneThyroidGlandMutation() {
            super(mName + " IM", mName, SLOT_THYROID, 3)
        }

    }
}
