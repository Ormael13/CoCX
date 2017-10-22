package classes.Items.Consumables {
import classes.AppearanceDefs;
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
                ChangeTo: pure ? AppearanceDefs.WING_TYPE_VAMPIRE : AppearanceDefs.WING_TYPE_BAT_ARM,
                Check   : player.hasGooSkin(),
                Override: mutations.humanizeSkin
            }, {
                BodyPart: 'earType',
                ChangeTo: pure ? AppearanceDefs.EARS_VAMPIRE : AppearanceDefs.EARS_BAT,
                Check   : pure ? player.earType != AppearanceDefs.EARS_HUMAN : false,
                Override: pure ? mutations.humanizeEars : null
            }, {
                BodyPart: 'eyeType',
                ChangeTo: AppearanceDefs.EYES_VAMPIRE
            }, {
                BodyPart: 'faceType',
                ChangeTo: AppearanceDefs.FACE_VAMPIRE
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
                ChangeTo: AppearanceDefs.REAR_BODY_BAT_COLLAR
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
                    story.display(tf.BodyPart, {$pure: pure});
                    outputText("\n\n");
                    player[tf.BodyPart] = tf.ChangeTo;
                    for each(var extra:Object in tf.Addition){
                        player[extra.BodyPart] = extra.ChangeTo;
                    }
                    changes++;
                }
            }
        }
        if(changes == 0){story.display("noChange");}
        return false;
    }
}
}
