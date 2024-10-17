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

public class HumanMusculatureMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Musculature";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Your altered musculature allows you to increase your natural strength and tone.";
            }
            if (pTier == 2){
                descS = "Your musculature continues to increase your natural strength and tone gained from previous changes. (+15% of max core Str as phantom Str)";
            }
            if (pTier == 3){
                descS = "Your musculature once again increases your natural strength and tone limit. Boost Warrior's Rage effect (+1 per 10 pts of core stat value) and duration by 5 turns. (+45%/+15% of max core Str/Spe as phantom Str/Spe)";
            }
            if (pTier == 4){
                descS = "Your musculature once again increases your natural strength and tone limit. Increases maximum base/core Str, +10% to max overfatigue. Boost Warrior's Rage effect (+1 per 4 pts of core stat value) and duration by 5 turns. (+90%/+45% of max core Str/Spe as phantom Str/Spe)";
            }
            if (pTier >= 1) descS += " (req. 18+ human score to have all effects active)";
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
                        return player.tone >= 100 && player.racialScore(Races.HUMAN) > 16;
                    }, "100+ tone & Human race (17+)");
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
            if (pTier == 1) pBuffs['str.mult'] = 0.15;
            if (pTier == 2) pBuffs['str.mult'] = 0.45;
            if (pTier == 3) pBuffs['str.mult'] = 0.9;
            if (pTier == 4) pBuffs['str.mult'] = 1.8;
            return pBuffs;
        }

        public function HumanMusculatureMutation() 
		{
			super(mName + " IM", mName, SLOT_MUSCLE, 4);
        }
        
    }
}
