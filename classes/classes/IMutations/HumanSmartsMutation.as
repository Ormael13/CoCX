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

public class HumanSmartsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Smarts";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1) descS += "Increases maximum base/core Int/Wis by ";
            if (pTier == 1){
                descS += "5.";
            }
            if (pTier == 2){
                descS += "10. Allow the use of options requiring you to have technical knowledge.";
            }
            if (pTier == 3){
                descS += "10, maximum trainable Int/Wis by 20%. Gain soulforce recovery equal to 1% of your total soulforce and mana recovery increased by 0,5% of max mana. Allow to use options requiring to have technical knowledge.";
            }
            if (pTier == 4){
                descS += "20, maximum trainable Int/Wis by 30%. Gain soulforce recovery equal to 2% of your total soulforce and mana recovery increased by 1% of max mana, +5% to max overmana/oversoulforce. Increase m.soulskill power by 100%. Allow to use options requiring to have technical knowledge.";
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
                    this.requirePeripheralNervSysMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.racialScore(Races.HUMAN) > 16;
                    }, "Human race (17+)");
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
            if (pTier == 1) {
				pBuffs['int.mult'] = 0.1;
				pBuffs['wis.mult'] = 0.1;
			}
            if (pTier == 2) {
				pBuffs['int.mult'] = 0.2;
				pBuffs['wis.mult'] = 0.2;
			}
            if (pTier == 3) {
				pBuffs['int.mult'] = 0.4;
				pBuffs['wis.mult'] = 0.4;
			}
            return pBuffs;
        }

        public function HumanSmartsMutation() 
		{
			super(mName + " IM", mName, SLOT_NERVSYS, 4);
		}
		
	}

}
