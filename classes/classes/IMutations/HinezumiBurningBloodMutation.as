/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Arms;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class HinezumiBurningBloodMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "Increase the healing from the cauterize ability by 0.5%";
            var pTier:int = player.perkv1(IMutationsLib.HinezumiBurningBloodIM);
            if (pTier >= 3){
                descS += ", allows you to use Cauterize even if you're no longer a Hinezumi";
            }
            descS += "and raise Blazing battle spirit duration by "
            if (pTier == 1){ //Could have used tier....
                descS += "1";
            }
            if (pTier == 2){///but...
                descS += "2";
            }
            if (pTier == 3){///WHAM, 7. CAUSE WHY NOT.
                descS += "7";
            }
            if (descS != "")descS += " round(s).";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.HinezumiBurningBloodIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Hinezumi Burning Blood" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.HinezumiBurningBloodIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.HinezumiBurningBloodIM.requireBloodsteamMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.arms.type == Arms.HINEZUMI;
                    }, "Hinezumi arms")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.lowerBody == LowerBody.HINEZUMI;
                    }, "Hinezumi legs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tailType == Tail.HINEZUMI;
                    }, "Hinezumi tail")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.mouseScore() >= 12;
                    }, "Hinezumi race (Mouse 12+)");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.HinezumiBurningBloodIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function HinezumiBurningBloodMutation() {
            super("Hinezumi Burning Blood IM", "Hinezumi Burning Blood IM", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}