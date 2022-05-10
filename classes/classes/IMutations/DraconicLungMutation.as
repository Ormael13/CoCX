/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
import classes.PerkLib;
import classes.PerkType;
import classes.Player;

public class DraconicLungMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DraconicLungIM);
            if (pTier >= 1){
                descS = "Allows you to use breath attacks more often. (All dragon breaths usable once per combat)";
            }
            if (pTier >= 2){
                descS = "Increases threefold the power of dragon breath attacks. (+300% to dragon breaths damage, +5% of max core Spe as phantom Spe)";
            }
            if (pTier >= 3){
                descS = "Increases dragon breath attacks power and allows you to combine all 4 basic breath types more often. (+900% to dragon breaths damage, +20% of max core Spe as phantom Spe)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.DraconicLungIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Draconic Lung" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.DraconicLungIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DraconicLungIM.requireLungsMutationSlot()
                    .requirePerks(PerkLib.DragonFireBreath, PerkLib.DragonIceBreath, PerkLib.DragonLightningBreath, PerkLib.DragonDarknessBreath)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (player.dragonScore() >= 8);
                    }, "Dragon race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DraconicLungIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['spe.mult'] += 0.05;
            if (pTier >= 2) pBuffs['spe.mult'] += 0.1;
            if (pTier >= 3) pBuffs['spe.mult'] += 0.2;
            return pBuffs;
        }

        public function DraconicLungMutation() {
            super("Draconic Lung IM", "Draconic Lung", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}