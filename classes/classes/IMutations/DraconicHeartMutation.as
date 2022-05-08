/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
    import classes.Player;

public class DraconicHeartMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DraconicHeartIM);
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
            switch (player.perkv1(IMutationsLib.DraconicHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Draconic Heart" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.DraconicHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DraconicHeartIM.requireHeartMutationSlot()
                    .requirePerk(IMutationsLib.DraconicBonesIM)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (player.dragonScore() >= 8 || player.frostWyrmScore() >= 10 || player.leviathanScore() >= 20);
                    }, "Dragon race or its variants");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DraconicHeartIM.requireLevel(pLvl);
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
            var pBuffs:Object = {}; //0.05, 0.1, 0.2
            if (pTier >= 1) pBuffs['str.mult'] += 0.05;
            if (pTier >= 2) pBuffs['str.mult'] += 0.1;
            if (pTier >= 3) pBuffs['str.mult'] += 0.2;
            return pBuffs;
        }

        public function DraconicHeartMutation() {
            super("Draconic Heart IM", "Draconic Heart", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}