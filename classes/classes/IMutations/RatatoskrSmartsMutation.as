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

public class RatatoskrSmartsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.RatatoskrSmartsIM);
            if (pTier >= 1){
                descS += "Allows you to perm Weird words";
            }
            if (pTier >= 3){
                descS += ", knowledge is power is now three times as effective";
            }
            if (pTier >= 2){
                descS += ", increase the damage of Weird words by" + (pTier == 2)?"20%":((pTier == 3)?"50%":"") + ", lower cooldown of Knowledge overload by" +(pTier == 2)?"1":((pTier == 3)?"2":"") + "turns";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.RatatoskrSmartsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Ratatoskr Smarts" + sufval;
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
                IMutationsLib.RatatoskrSmartsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.RatatoskrSmartsIM.requirePeripheralNervSysMutationSlot()
                    .requirePerk(PerkLib.KnowledgeIsPower).requireCustomFunction(function (player:Player):Boolean {
                        return player.ratatoskrScore() >= 12;
                    }, "Squirrel/Ratatoskr race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.RatatoskrSmartsIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['int.mult'] = 0.05;
            if (pTier == 2) pBuffs['int.mult'] = 0.15;
            if (pTier == 3) pBuffs['int.mult'] = 0.35;
            return pBuffs;
        }

        public function RatatoskrSmartsMutation() {
            super("Ratatoskr Smarts IM", "Ratatoskr Smarts", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}