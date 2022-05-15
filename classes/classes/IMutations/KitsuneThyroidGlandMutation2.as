/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.IMutationPerkClass;
import classes.IMutationPerkType;
    import classes.PerkLib;
    import classes.Player;
    import classes.BodyParts.Tail;

    public class KitsuneThyroidGlandMutation2 extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:IMutationPerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.mutationsvX(IMutationsLib.KTG2, 1);
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
        override public function name(params:IMutationPerkClass=null):String {
            var sufval:String;
            switch (player.mutationsvX(IMutationsLib.KTG2, 1)) {
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Kitsune Thyroid Gland2 " + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
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


        public function pBuffs(pTier:int = 1):Object{
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
            return pBuffs
        }

        //Mutations Buffs
        public function KitsuneThyroidGlandMutation2() {
            super("Kitsune Thyroid Gland IM2", "Kitsune Thyroid Gland2", 3, ".");
        }

        /*
        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }*/

    }
}