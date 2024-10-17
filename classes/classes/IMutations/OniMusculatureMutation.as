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

public class OniMusculatureMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Oni Musculature";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Your altered musculature allows you to increase your natural strength and tone. Oni Rampage and Drunker Power can be used at Half-Oni score";
            }
            if (pTier == 2){
                descS = "Your musculature continues to increase your natural strength and tone gained from previous changes. Oni Rampage and Drunker Power req. only 3+ pts in Oni score and dmg multi from Oni Rampage increased to 4x";
            }
            if (pTier == 3){
                descS = "Your musculature once again increases your natural strength and tone limit. Dmg multi from Oni Rampage increased to 6x, its duration is increased by 3 turns and its cooldown is decreased by 3 turns. Drunken Power boost increased to 6x";
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
                    this.requireMusclesMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tone >= 100;
                    }, "100+ tone")
                    .requireRace(Races.ONI);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.3;
            return pBuffs;
        }

        public function OniMusculatureMutation() {
            super(mName + " IM", mName, SLOT_MUSCLE, 3);
        }
        
    }
}
