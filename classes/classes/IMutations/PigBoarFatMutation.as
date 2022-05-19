/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class PigBoarFatMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.PigBoarFatIM);
            if (pTier >= 1) descS += "Your altered fat tissue allows to increase your natural resistance to damage, toughness and thickness";
            if (pTier == 1){
                descS = "Increase max Hunger cap by 5 (if PC have Hunger bar active)";
            }
            if (pTier == 2){
                descS = "Body Slam req. lower thickness to be used, increase max Hunger cap by 15 (if PC have Hunger bar active)";
            }
            if (pTier == 3){
                descS = "Body Slam req. lower thickness and doubled power, pig/boar req. removed, thickness requirement lowered, increase max Hunger cap by 35 (if PC have Hunger bar active)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.PigBoarFatIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Pig Boar Fat" + sufval;
        }

        //Mutation Requirements
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.PigBoarFatIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.PigBoarFatIM.requireFatTissueMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.thickness >= 100;
                    }, "100+ thickness")
                    .requireRace(Races.PIG);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.PigBoarFatIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function PigBoarFatMutation() {
            super("Pig Boar Fat IM", "Pig Boar Fat", ".");
            maxLvl = 3;
        }

        
    }
}
