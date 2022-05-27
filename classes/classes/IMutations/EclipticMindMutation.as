/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;

public class EclipticMindMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
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
            switch (currentTier(this, player)){
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
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requirePeripheralNervSysMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.alicornScore() >= 12 || player.unicornScore() >= 12 || player.alicornkinScore() >= 10 || player.unicornkinScore() >= 10;
                    }, "Unicorn or Bicorn race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:Creature = null):Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this, (target == null)? player : target);
            return pBuffs;
        }

        public function EclipticMindMutation() {
            super("Ecliptic Mind IM", "Ecliptic Mind", ".");
            maxLvl = 3;
        }

    }
}