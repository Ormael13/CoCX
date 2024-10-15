/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class BlazingHeartMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Blazing Heart";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Gain permanent weakness to cold and fire resistance. Increase fire damage by "+(25*pTier)+"%";
            if (pTier >= 2) descS += ". Heat and Rut also grant you a bonus equal to ";
            if (pTier == 2 || pTier == 3) descS += "1";
			if (pTier >= 4) descS += "2";
            if (pTier >= 2) descS += "0% of the libido bonus to strength";
            if (pTier >= 3) descS += ". Setting an enemy on fire emboldens and arouses you, increasing damage dealt to burn enemies by 100% but also making you take lust damage as a recoil";
            if (pTier >= 4) descS += ". Fire active and passive abilities have a 20% chance to apply the burning status effect if they do not already";
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
                    this.requireHeartMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isRace(Races.FIRESNAILS) || player.isRace(Races.HELLCAT) || player.isRace(Races.PHOENIX) || player.isRace(Races.SALAMANDER) || player.isRace(Races.MOUSE,2);
                    }, "fire snail, hellcat, phoenix, salamander or hinezumi race");
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            else if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            else if (pTier == 3) pBuffs['lib.mult'] = 0.3;
            else if (pTier == 4) pBuffs['lib.mult'] = 0.9;
            return pBuffs;
        }

        public function BlazingHeartMutation() 
		{
			super(mName + " IM", mName, SLOT_HEART, 4);
        }

        
    }
}
