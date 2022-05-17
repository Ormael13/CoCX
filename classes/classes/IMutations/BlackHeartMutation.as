/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Player;

    public class BlackHeartMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.BlackHeartIM);
            if (pTier >= 1){
                descS += "Increased Lust strike power, Empower Fascinate";
            }
            if (pTier >= 2){
                descS += ", Adds extra Lust damage to Lust strike dependent on Wisdom (Wis/10) and lowers Fascinate CD by 1";
            }
            if (pTier >= 3){
                descS += ", Adds extra Lust damage to Lust strike dependent on Sensitivity (Sensitivity/10) and extends Facinate Stun to 2 turns";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.BlackHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Black Heart" + sufval;
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
                IMutationsLib.BlackHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.BlackHeartIM.requireHeartMutationSlot()
                    .requirePerk(PerkLib.DarkCharm).requireCor(100)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.demonScore() >= 11;
                    }, "Demon race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.BlackHeartIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            else if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            else if (pTier == 3) pBuffs['lib.mult'] = 0.3;
            return pBuffs;
        }

        public function BlackHeartMutation() {
            super("Black Heart IM", "Black Heart", ".");
            maxLvl = 3;
        }

        
    }
}