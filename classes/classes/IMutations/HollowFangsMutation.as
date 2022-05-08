/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
    import classes.Player;

public class HollowFangsMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.HollowFangsIM);
            if (pTier == 1){
                descS = "Your fangs and mouth started to slowly change showing rudimental ability to suck out fluids like blood. (+5 max stack of Vampire Thirst)";
            }
            if (pTier == 2){
                descS = "Your ability to suck substances like blood have developed halfway. (+5 max stack of Vampire Thirst, +3% more healed from Vampire Bite)";
            }
            if (pTier == 3){
                descS = "You can now freely feed on blood and other atypical fluids. (+5 max stack of Vampire Thirst, +7% more healed from Vampire Bite, each Vampire Bite giving 2 stacks and deal +50% lust dmg)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.HollowFangsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Hollow Fangs" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.HollowFangsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.HollowFangsIM.requireMouthMutationSlot()
                            .requirePerk(IMutationsLib.VampiricBloodstreamIM)
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.facePart.type == 34;//player.facePart.isAny(Face.VAMPIRE, Face.)
                            }, "Vampire fangs")
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.vampireScore() >= 10;//potem dodać mosquito race i ew. inne co mogą wypijać krew
                            }, "Vampire race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.HollowFangsIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['tou.mult'] += 0.05;
            if (pTier >= 2) pBuffs['tou.mult'] += 0.1;
            if (pTier >= 3) pBuffs['tou.mult'] += 0.15;
            return pBuffs;
        }

        public function HollowFangsMutation() {
            super("Hollow Fangs IM", "Hollow Fangs", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}