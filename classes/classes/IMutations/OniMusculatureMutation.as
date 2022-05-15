/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class OniMusculatureMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.OniMusculatureIM);
            if (pTier == 1){
                descS = "Your altered musculature allows to increase your natural strength and tone. Oni Rampage and Drunker Power can be used at Half-Oni score";
            }
            if (pTier == 2){
                descS = "Your musculature continue to increase your natural strength and tone gained from previous change. Oni Rampage and Drunker Power req. only 3+ pts in Oni score and dmg multi from Oni Rampage increased to 4x";
            }
            if (pTier == 3){
                descS = "Your musculature increased again your natural strength and tone limit. Dmg multi from Oni Rampage increased to 6x, it duration increased by 3 turns and cooldown decreased by 3 turns. Drunken Power boost increased to 6x";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.OniMusculatureIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Oni Musculature" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.OniMusculatureIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.OniMusculatureIM.requireMusclesMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tone >= 100;
                    }, "100+ tone")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.oniScore() >= 12;
                    }, "Oni race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.OniMusculatureIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        public static var _perkLvl:int = 3;

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.3;
            return pBuffs;
        }

        public function OniMusculatureMutation() {
            super("Oni Musculature IM", "Oni Musculature", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}