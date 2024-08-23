/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Tail;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class DrakeBloodMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Drake Blood";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Dragon strong vitality grants mana, soulforce and health regeneration " + pTier + "%";
			if (pTier >= 2) descS += ". You take " + (pTier - 1) * 5 + "% less damage from magical attack";
            if (pTier >= 3) descS += ". Magic Effect from you are " + (pTier - 2) * 25 + "% more powerful";
            if (pTier >= 4) descS += ". Magic Ability are 100% Stronguer";
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
                    this.requireBloodsteamMutationSlot()
                    .requireAnyRace(Races.DRAGON, Races.FROSTWYRM, Races.JABBERWOCKY, Races.SEA_DRAGON);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.35;
            if (pTier == 4) pBuffs['tou.mult'] = 0.75;
            return pBuffs;
        }

        public function DrakeBloodMutation() 
		{
			super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
        }
        
    }
}
