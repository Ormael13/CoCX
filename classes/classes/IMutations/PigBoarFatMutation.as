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

public class PigBoarFatMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Pig Boar Fat";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Your altered fat tissue allows to increase your natural resistance to damage, toughness and thickness";
            if (pTier == 1){
                descS = "Increase max Hunger cap by 5 (if PC has Hunger bar active)";
            }
            if (pTier == 2){
                descS = "Body Slam requires lower thickness to be used, increase max Hunger cap by 15 (if PC has Hunger bar active)";
            }
            if (pTier == 3){
                descS = "Body Slam thickness requirement lowered and its power is doubled, pig/boar/red panda req. removed, increase max Hunger cap by 35 (if PC has Hunger bar active)";
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
                    this.requireFatTissueMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.thickness >= 100;
                    }, "100+ thickness")
                    .requireRace(Races.PIG);
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
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function PigBoarFatMutation() {
            super(mName + " IM", mName, SLOT_FAT, 3);
        }

    }
}
