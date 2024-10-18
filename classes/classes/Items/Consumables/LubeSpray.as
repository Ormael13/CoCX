package classes.Items.Consumables {
import classes.AssClass;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.VaginaClass;

/**
 * Taken from unfinished Urta content and finally coded in.
 * @author Svalkash
 * */
public class LubeSpray extends Consumable {
    public function LubeSpray() {
        super("LubeSpray", "Lube Spray", "a vial of lubricant spray", 20, "");
    }

    //basically, SH workaround to get this shit earlier for me.
    override public function get description():String {
        var desc:String = flags[kFLAGS.DISCUSSED_LUBE_SPRAY] ? "A highly concentrated spray juice Lianna distilled for you, it may have some transforming properties." :
            "A vial of strange spray found in Tel'Adre. It's unknown if it has any special effects, but you'd better be careful with it.";
        return desc + super.description;
    }

    override public function useItem():Boolean {
        var choices:Array = [];
        clearOutput();
        outputText("You inhale the strong, musky scent of the fluid, then grit your teeth and toss it back in a single gulp.  It's got an oily kind of taste, but there's barely a mouthful of it and it slides down your belly quick and easy, leaving a slight queasiness in your guts as the aftereffect.");
        //Text and preparation
        choices.push(0); //failure
        if (player.ass.analWetness < AssClass.WETNESS_SLIME_DROOLING && rand(2) == 0) choices.push(1); //rare enough?
        outputText("A strange dampness starts around your [asshole], you remove your lower garments and observe.  You clutch your [ass] as it starts drooling its own natural lubricant.  Almost as if in sympathy, your mouth starts feeling wet, and you find yourself hard-pressed to keep from drooling as your saliva glands kick into overdrive, making your mouth far wetter and slicker.\n");
        if (player.hasBalls()) {
            choices.push(2);
            outputText("Your [multiCock] begin dripping clear looking pre on the floor, despite none of "+(player.cocks.length > 1?"them":"it")+" being fully erect.\n")
        }
        if (player.hasVagina()) {
            if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) choices.push(3);
            outputText("You feel a trickle of wetness running down your [legs] and look down to see that your [pussy] is unbelievably wet, constantly leaking juices that pool on the floor.\n")
        }
        if (player.isLactating()) {
            choices.push(4);
            outputText("A strange wetness begins forming on the tips of your [nipples] and you quickly strip off your top and watch in amazement as beads of moisture form on the tips of your nipples, dripping down on the floor and running down your [breasts].  The color is off-white, the strange wetness must be leaking along with your milk.\n")
        }
        outputText("Almost as suddenly as the effects started, they all dissipate.  Though you're visibly wet after the events that transpired.\n\n");
        //pick!
        var choice:int = choices[rand(choices.length)];
        switch (choice) {
            case 0:
                outputText("Aside from the effects you suffered through earlier, you don't notice any other changes to your body.");
                break;
            case 1:
                outputText("You realize your ass still feels moist and clench your butt, you squeak with surprise as " + (player.ass.analWetness == AssClass.WETNESS_DRY ? "some" : "even more") + "juices are squeezed out of your [asshole].  ");
                if (player.ass.analWetness == AssClass.WETNESS_DRY) outputText("<b>Your anus is now permanently wet, ensuring it will always be lubed!</b>");
                else outputText("<b>Your anus is even wetter, ensuring even better lubrication!</b>");
                ++player.ass.analWetness;
                break;
            case 2:
                outputText("Somehow your [balls] feel heavier than before, though they don't look any bigger.  You reach down to weigh them and moan in pleasure as a sudden pressure erupts from then and you shoot a small rope of cum on the floor.  Looks like your <b>cum production has been augmented</b> somehow.");
                ++player.cumMultiplier;
                break;
            case 3:
                outputText("You notice your vagina is still dripping, and realize that it's not getting any drier.  <b>Your vaginal wetness has been increased.</b>");
                ++player.vaginas[0].vaginalWetness;
                break;
            case 4:
                outputText("Your [breasts] tingle softly, and when you massage them you gasp as a small jet of milk sprays forward, somehow you know that <b>your milk production has increased.</b>");
                player.boostLactation(1, true); //no diminishing? she knows what she does!
                break;
        }
        return false;
    }
}
}
