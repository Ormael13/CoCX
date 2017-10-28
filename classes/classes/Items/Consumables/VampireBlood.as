package classes.Items.Consumables {
import classes.GlobalFlags.kGAMECLASS;
import classes.Items.Consumable;

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
        var story:BoundStory = getGame().rootStory.locate("diva/item").bind(kGAMECLASS.context);
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
                BodyPart: 'wingType',
                ChangeTo: pure ? WING_TYPE_VAMPIRE : WING_TYPE_BAT_ARM,
                Check   : player.hasGooSkin(),
                Override: mutations.humanizeSkin
            }, {
                BodyPart: 'earType',
                ChangeTo: pure ? EARS_VAMPIRE : EARS_BAT,
                Check   : pure ? player.earType != EARS_HUMAN : false,
                Override: pure ? mutations.humanizeEars : null
            }, {
                BodyPart: 'eyeType',
                ChangeTo: EYES_VAMPIRE
            }, {
                BodyPart: 'faceType',
                ChangeTo: FACE_VAMPIRE
            }
        ];
        if(pure){
            tfArr.push({
                BodyPart: 'skinTone',
                ChangeTo: "pale",
                Addition: {
                    Eyes:{
                        BodyPart: 'eyeColor',
                        ChangeTo: "blood red"
                    }
                }
            });
        } else {
            tfArr.push({
                BodyPart: 'rearBody',
                ChangeTo: REAR_BODY_BAT_COLLAR
            });
        }
        changeLimit = 1;
        changes = 0;
        for each (var tf:Object in tfArr) {
            if (changes >= changeLimit) break;
            if (rand(tf.Chance? tf.Chance : 3) == 0) {
                if (tf.ChangeTo != -1 && player[tf.BodyPart] != tf.ChangeTo) {
                    if (tf.Check) {
                        tf.Override();
                        changes++;
                    }
                    outputText("\n\n");
                    story.display(tf.BodyPart, {$pure: pure});
                    player[tf.BodyPart] = tf.ChangeTo;
                    for each(var extra:Object in tf.Addition){
                        player[extra.BodyPart] = extra.ChangeTo;
                    }
                    changes++;
                }
            }
        }
        if(changes == 0){outputText("\n\n");story.display("noChange");}
        return false;
    }
}
}
