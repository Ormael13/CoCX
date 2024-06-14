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
import classes.Races;

public class BlackHeartMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Black Heart";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Increased Lust strike power, empower Fascinate";
            if (pTier >= 2) descS += ", adds extra Lust damage to Lust strike scaling with Wisdom (Wis/10). Lowers Fascinate Cooldown by ";
            if (pTier == 2 || pTier == 3) descS += "1";
			if (pTier >= 4) descS += "2";
            if (pTier >= 3) descS += ", adds extra Lust damage to Lust strike, scaling with Sensitivity (Sensitivity/10). Facinate Stun lasts 2 turns";
            if (pTier >= 4) descS += ", count your lust for twice as high when using Lust strike and it's now benefit from all effects that pertain to the tease action";
            if (descS != "")descS += ".";
            return descS;
        }

        override public function evolveText():String {
            var descS:String = "\nAs you acclimate further to your new life as a fiend you find your thought and morality slowly sinking deeper and deeper into the abyss of corruption. Betraying someone who trusted and loved you would be so easy now if it could further your growing ambitions.";
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
                    .requirePerk(PerkLib.DarkCharm).requireCor(100)
                    .requireAnyRace(Races.DEMON, Races.IMP, Races.GREMLIN, Races.DRACULA);
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

        public function BlackHeartMutation() {
            super(mName + " IM", mName, SLOT_HEART, 4);
        }

        
    }
}
