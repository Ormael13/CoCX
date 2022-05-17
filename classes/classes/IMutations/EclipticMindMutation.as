/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class EclipticMindMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.EclipticMindIM);
            if (pTier >= 1) descS += "Allows you to retain an aura at all time, gaining whichever corresponds to your alignment. Empower the effect of your aura based on your purity or corruption score";
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
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
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

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            return pBuffs;
        }

        public function EclipticMindMutation() {
            super("Ecliptic Mind IM", "Ecliptic Mind", ".");
            maxLvl = 3;
        }

        
    }
}