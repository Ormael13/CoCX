/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.IMutationPerkType
import classes.PerkClass;
import classes.PerkLib;
    import classes.Player;
    import classes.BodyParts.Tail;

    public class KitsuneThyroidGlandMutation2 extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.KTG2);
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
            switch (player.perkv1(IMutationsLib.KTG2)) {
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Kitsune Thyroid Gland 2 " + sufval;
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
                IMutationsLib.KTG2.requirements = [];
                if (pTier == 0){
                    IMutationsLib.KTG2.requireThyroidGlandMutationSlot()
                    .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tailType == Tail.FOX && player.tailCount >= 2;
                    }, "2+ fox tails");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.KTG2.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var pTier:int = target.perkv1(IMutationsLib.KTG2);
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
        public function KitsuneThyroidGlandMutation2() {
            super("Kitsune Thyroid Gland IM3", "Kitsune Thyroid Gland2", ".")
            maxLvl = 3;
        }

        /*
        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }*/

    }
}