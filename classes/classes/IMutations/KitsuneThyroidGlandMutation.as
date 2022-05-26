/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.PerkLib;
import classes.Player;
import classes.BodyParts.Tail;

    public class KitsuneThyroidGlandMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
            if (pTier >= 1){
                descS += "Illusion & Terror -3CD";
            }
            if (pTier >= 2){
                descS += ", FoxFire +50% damage (fire and lust)";
            }
            if (pTier >= 3){
                descS += ", +20% Evasion to Illusion, +50 speed debuff to Terror target, +SF/Mana regen (Star Sphere rank x3/2 respectively), increase Star Sphere Max to 20";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this)) {
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Kitsune Thyroid Gland " + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireThyroidGlandMutationSlot()
                    .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tailType == Tail.FOX && player.tailCount >= 2;
                    }, "2+ fox tails");
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        override public function pBuffs():Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this);
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
            super("Kitsune Thyroid Gland IM", "Kitsune Thyroid Gland", ".")
            maxLvl = 3;
        }

    }
}