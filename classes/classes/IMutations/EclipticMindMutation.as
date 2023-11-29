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
import classes.Races;

public class EclipticMindMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Ecliptic Mind";
        }
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

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requirePeripheralNervSysMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isRace(Races.ALICORN, 2) || player.isRace(Races.UNICORN, 2);
                    }, "Any unicorn race");
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
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function EclipticMindMutation() {
            super(mName + " IM", mName, SLOT_NERVSYS, 3);
        }

    }
}
