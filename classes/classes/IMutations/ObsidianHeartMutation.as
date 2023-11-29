/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class ObsidianHeartMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Obsidian Heart";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Devil.M Specials are available even if you do not qualify as devilkin, but will increase your corruption each use until it reaches 60";
            }
            if (pTier == 2){
                descS += ", Maleficium's duration is increased by 5 turns and spellpower is boosted by 25%, Infernal Flare +~25%";
            }
            if (pTier == 3){
                descS += ", Maleficium's duration is increased by 5 turns and spellpower is boosted by 150% + lowers lust resistance to 30%, Infernal Flare +~65% and 20% higher chance to crit";
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
                    this.requireHeartMutationSlot()
                    .requireCor(100).requireRace(Races.DEVIL);
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
            if (pTier == 3) {
                pBuffs['str.mult'] = 0.05;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            return pBuffs;
        }

        public function ObsidianHeartMutation() {
            super(mName + " IM", mName, SLOT_HEART, 3);
        }

    }
}
