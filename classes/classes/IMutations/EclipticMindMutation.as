/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
    import classes.Player;

public class EclipticMindMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "Allows you to retain an aura at all time, gaining whichever corresponds to your alignment. Empower the effect of your aura based on your purity or corruption score";
            var pTier:int = player.perkv1(IMutationsLib.EclipticMindIM);
            if (pTier >= 3){
                descS += " x3";
            }
            else if (pTier >= 2){
                descS += " x2";
            }
            else {
                descS += "";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.EclipticMindIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Ecliptic Mind" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.EclipticMindIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.EclipticMindIM.requirePeripheralNervSysMutationSlot()
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.alicornScore() >= 12 || player.unicornScore() >= 12 || player.alicornkinScore() >= 10 || player.unicornkinScore() >= 10;
                    }, "Unicorn or Bicorn race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.EclipticMindIM.requireLevel(pLvl);
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
            return pBuffs;
        }

        public function EclipticMindMutation() {
            super("Ecliptic Mind IM", "Ecliptic Mind", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}