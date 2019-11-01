package classes.Items.Consumables {
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.RearBody;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;

import coc.xxc.BoundStory;

public class VampireBlood extends Consumable {
    private var pure:Boolean;
    public static var first:Boolean = true;
    public function VampireBlood(purified:Boolean=false) {
        super(
                purified ? "VampBld" : "RedVial",
                purified ? "VampBld" : "RedVial",
                purified ? "a vial of vampire blood" : "a vial of ominous red liquid",
                purified ? 30 : 15,
                purified ? "This vial is filled with vampire blood. You don’t need to be a genius to figure what will happen if you drink that." :
                        "A vial of thick, deep red liquid. It has a slightly metallic scent."
        );
        pure = purified;
    }
    override public function get description():String{
        if(pure){
            _description = "This vial is filled with vampire blood. You don’t need to be a genius to figure what will happen if you drink that.";
        } else if(first){
            _description = "A vial of thick, deep red liquid. It has a slightly metallic scent.";
        } else {
            _description = "This vial can’t seriously contain blood, can it? You hope you won’t turn into a vampire from drinking it.";
        }
        return super.description;
    }
    override public function useItem():Boolean{
        clearOutput();
        var story:BoundStory = CoC.instance.rootStory.locate("diva/item").bind(CoC.instance.context);
        if(first){
            story.display("useText/first");
            first = false;
        } else if (player.vampireScore() >= 6){
            story.display("useText/vampire");
        } else {
            story.display(pure ? "useText/pure" : "useText/normal");
        }
        //outputText("\n\n");
        story = story.locate("tfText");

        var tfArr:Array = [
            {
                BodyPart: 'wings.type',
                ChangeTo: pure ? Wings.VAMPIRE : Wings.BAT_ARM,
                Check   : player.hasGooSkin(),
                Override: mutations.humanizeSkin,
                Metamorph: pure ? StatusEffects.UnlockedVampireWings : StatusEffects.UnlockedBatWings
            }, {
                BodyPart: 'ears.type',
                ChangeTo: pure ? Ears.VAMPIRE : Ears.BAT,
                Check   : pure ? player.ears.type != Ears.HUMAN : false,
                Override: pure ? mutations.humanizeEars : null,
                Metamorph: pure ? StatusEffects.UnlockedVampireEars : StatusEffects.UnlockedBatEars
            }, {
                BodyPart: 'eyes.type',
                ChangeTo: Eyes.VAMPIRE,
                Metamorph: StatusEffects.UnlockedVampireEyes
            }, {
                BodyPart: 'faceType',
                ChangeTo: Face.VAMPIRE,
                Metamorph: StatusEffects.UnlockedVampireFace
            }
        ];
        if(pure){
            tfArr.push({
                BodyPart: 'skinTone',
                ChangeTo: "pale",
                Addition: {
                    Eyes:{
                        BodyPart: 'eyes.colour',
                        ChangeTo: "blood red"
                    }
                }
            });
        } else {
            tfArr.push({
                BodyPart: 'rearBody.type',
                ChangeTo: RearBody.BAT_COLLAR,
                Metamorph: StatusEffects.UnlockedBatCollar
            }, {
                BodyPart: 'arms.type',
                ChangeTo: Arms.HUMAN
            });
        }
        changes = 0;
        changeLimit = 1;
		if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist)) changeLimit++;
		if (player.hasPerk(PerkLib.Enhancement)) changeLimit++;
		if (player.hasPerk(PerkLib.Fusion)) changeLimit++;
		if (player.hasPerk(PerkLib.Enchantment)) changeLimit++;
		if (player.hasPerk(PerkLib.Refinement)) changeLimit++;
		if (player.hasPerk(PerkLib.Saturation)) changeLimit++;
		if (player.hasPerk(PerkLib.Perfection)) changeLimit++;
		if (player.hasPerk(PerkLib.Creationism)) changeLimit++;
		if (player.hasPerk(PerkLib.EzekielBlessing)) changeLimit++;
		if (player.hasPerk(PerkLib.TransformationResistance)) changeLimit--;
        if (player.hasPerk(PerkLib.TransformationImmunity) || player.hasPerk(PerkLib.Undeath)) changeLimit = 0;
		for each (var tf:Object in tfArr) {
            if (changes >= changeLimit) break;
            if (trueOnceInN(tf.Chance? tf.Chance : 3)) {
	            doChange(tf);
            }
		}
	    if(changes == 0){outputText("\n\n");story.display("noChange");}
        return false;

        function doChange(tf:Object,count:Boolean=true):void{
            if (tf.ChangeTo != -1) {
	            var keys:Array = tf.BodyPart.split('.');
	            var hostObj:Object = player;
	            var bodyPart:String = tf.BodyPart;
	            if(keys.length > 1){
		            hostObj = player[keys[0]];
		            bodyPart = keys[1];
	            }
	            if (hostObj[bodyPart] != tf.ChangeTo){
		            if (tf.Check) {
			            tf.Override();
			            if(count)changes++;
		            }
		            outputText("\n\n");
		            if(count){
			            story.display(tf.BodyPart, {$pure: pure});
		            }
		            hostObj[bodyPart] = tf.ChangeTo;
     				if (tf.Metamorph) {
        				mutations.addGeneticMemory(tf.Metamorph, tf.Metamorph.id.replace("Unlocked ", ""));
     				}
		            for each(var extra:Object in tf.Addition){
			            doChange(extra,false);
		            }
		            if(count) changes++;
	            }
            }
        }
    }
}
}
