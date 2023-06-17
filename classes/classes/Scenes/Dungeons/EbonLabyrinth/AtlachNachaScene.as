
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.GeneticMemories.LowerBodyMem;
import classes.GeneticMemories.TailMem;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Player;
import classes.Races;
import classes.Races.AtlachNachaRace;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.display.SpriteDb;
import classes.PerkLib;
import classes.BodyParts.Tail;
import classes.BodyParts.LowerBody;
import classes.EventParser;

public class AtlachNachaScene extends BaseContent {
    public function AtlachNachaScene() {}
    
    public function encounter():void {
        clearOutput();
        spriteSelect(SpriteDb.s_Atlach_16bit);
        if (player.hasPerk(PerkLib.TransformationImmunity2) && player.perkv1(PerkLib.TransformationImmunity2) == 1){
            outputText("By luck or by sheer irony you stumble upon your old nest. It's been empty for a while now and hasn't been used ever since you left." +
                    " This said some of your old minions came over and paid tribute leaving some treasure by your web. You take the gems and leave back for the labyrinth.");
            player.gems += 500;
            doNext(playerMenu);
        }
        else if (AtlachNachaRace.fullTfCheck(player)){
            outputText("As you enter the next room, you immediately recognize the place. Several nearby webs catch your eye, you know you've been here before!" +
                    "\n\nBlazing red eyes open within the darkness at the other side of the vast room with a piercing gaze directed at you." +
                    " You feel a need to submit to this creature as if some deeply ingrained instincts told you it was the right and most just decision in the world and to go against it would be the worst decision in existence." +
                    "\n\nIt would be so easy to give in to the compulsion nagging at your brain right now." +
                    " On the other hand, you could also fight the fiendish spider back again and leave before things get worse. What will you do?");
            menu();
            addButton(0, "Surrender", becomeAtlach);
            addButton(1, "Fight", fightAtlach);
        }
        else {
            outputText("As you enter the next room, you become increasingly wary of the environment. Webs intermingle everywhere in a complex and haunting display sometimes forming something not unlike eldritch symbols and patterns. The room is vast and you can even spot what appears to be shining treasure to the far end, however there is little doubt that this conveniently placed loot is well guarded. ");
            outputText("As you approach to grab the items your foot gets glued to the web and in an effort to pull it off you cause the webbing to shake on the entirety of the room. You try and back off as countless amounts of red lights appear in the darkness in front of you, the disgusting sounds of tentacles rubbing one after another being heard as a nightmarish creature slowly skitters moves out of the shadow as to access its prey.\n\n");
            outputText("This horror has the body of a spider but way too many eyes to be one. It has eyes on its leg head and even backs but the most horrifying is its face. The thing's face has no mouth, just a wriggling amalgam of rapidly moving tentacles, which flail about wildly in anticipation! You got caught into its web and there's a little way you can escape unless you defeat it if only temporarily.\n\n");
            startCombat(new AtlachNacha(), true);
        }
    }

    private function becomeAtlach():void {
        clearOutput()
        outputText("You find yourself unable to fight it anymore. You want this thing, regardless of what." +
                " Want it for what? Your body walks to the beast without the permission of your mind. You know that you will find out what it wants soon enough." +
                "\n\nThe spider hisses in approval at your approach. It gently picks you up, as you face the being. It shifts as you gaze upon its horrid face, it's an unholy bouquet of tentacles, all writhing before you." +
                " The tentacle parts way, revealing a large rod, not unlike a 16-inch-long penis." +
                "\n\nWhile you admire the thing in awe, the spider brutally shoves you down into the erect member, hilting itself fully into your ");
        if (player.hasVagina()) outputText(""+player.vaginaDescript()+".");
        else outputText(""+player.assholeDescript()+".");
        outputText(" You yelp from the intrusion, before you relish from the deep, throbbing penetration as the tentacles wrap around your legs," +
                " pulling you to the writhing mass of the creature's head. Through the length within you, you begin feeling the rest of the creature's body," +
                " discovering nerves you didn't know you even had as your spine begins to somehow prolong itself inside the rod that constantly fucks you." +
                "\n\nYou can feel your mind intertwining with the arachnid. The two of you used to be separate entities," +
                " now connected by mutual lust like the perfectly aligned piece of the same puzzle. Through this connection, you feel a ");
        if (player.hasVagina()) outputText("second cunt");
        else outputText("slit");
        outputText(" beneath your spider abdomen, dripping in excitement.");
        if (!player.hasVagina()) outputText(" Such a strange accommodation, one you know you'll get pleasure out of.");
        outputText(" Your upper body is now locked in a constant copulating state you drool in bliss as you feel" +
                " something slide out from your lower half, which causes an even more intense sensation to overtake you." +
                "\n\nThis… this is an ovipositor… this is how you will expel the fertilized eggs you will be producing from now on." +
                " Clarity dawns on your lust-addled mind as you come to the realization that you are at long last complete." +
                " It takes you a few minutes to slowly get used to your new state of mind and body and adapt to the pleasure from your constantly orgasming top half," +
                " now seeking out even greater sensations to feel with your spider genitals." +
                "\n\nYou turn around on your eight legs surveilling the room, this was a good nest while it lasted but now you have places to go and eggs to lay." +
                " You are completely satisfied with merging with your host or perhaps were you the host? Does it matter? You know it doesn't anymore as you head back into the labyrinth.");
        //TF list
        dynStats("cor", 100);
        player.tailType = Tail.SPIDER_ADBOMEN;
        player.lowerBody = LowerBody.ATLACH_NACHA;
        Metamorph.unlockMetamorph(LowerBodyMem.getMemory(LowerBodyMem.ATLACH_NACHA));
        Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SPIDER_ADBOMEN));
        player.legCount = 8;
        if (!player.hasVagina()) player.createVagina();
        player.vaginaType(5);
        if (player.tailRecharge < 15) player.tailRecharge = 15;
        player.createPerk(PerkLib.SpiderOvipositor,0,0,0,0);
        player.createPerk(PerkLib.TransformationImmunity2,1,0,0,0);
        if (player.hasPerk(PerkLib.RacialParagon)) flags[kFLAGS.APEX_SELECTED_RACE] = Races.ATLACH_NACHA;
        player.createPerk(PerkLib.Venomancy, 0, 0, 0, 0);
		outputText("\n\nEverything makes so much sense now. You were blind to the truth but thanks to the voice of the master in your head your eyes are now open. You have access to knowledge you thought you didn't possess about your reality and the reality between the reality. ");
		outputText("Such knowledge is not for your mind alone though you want to share it with the world. Their blindness and mind untouched by him is a disease and you just happen to have the cure.  (<b>Gained Perk: Insanity!</b>)");
        player.createPerk(PerkLib.Insanity,0,0,0,0);
        IMutationsLib.TrachealSystemIM.trueMutation = true;
        IMutationsLib.ArachnidBookLungIM.trueMutation = true;
        IMutationsLib.VenomGlandsIM.trueMutation = true;
        player.removeAllRacialMutation();
        doNext(playerMenu);
    }
    
    private function fightAtlach():void {
        clearOutput()
        outputText("You ain't gonna let this thing mess with your brain any longer. You draw your weapon prepared to engage it!");
        startCombat(new AtlachNacha(), true);
    }

    public function defeatedBy():void {
        clearOutput();
        outputText(" You fall to the ground defeated " + (player.lust >= player.maxOverLust() ? "by your growing lust":"") + ((player.inte <= 0 || player.wis <= 0) ? "as you lose your grip on reality going insane":"") + ". The last thing anyone will hear from you is your tortured screams as the nightmarish spiders cocoons you. ");
        outputText("What will happen to you from now on is perhaps too horrible to be told and you will lose your sanity long before you die of fatigue, serving as this creature's plaything until you no longer can go on with your life.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }
    
    public function defeat():void {
        clearOutput();
        outputText("You barely manage to force the spider back into the back of the room as you finally escape the web rushing for the exit, your nightmarish pursuer only meters away from you as you finally leave the room. It claws and flail but you prove faster and manage to outrun it. This was a close one but now you can keep on exploring the labyrinth.\n\n");
        if (player.hasStatusEffect(StatusEffects.TFDealer2) && player.statusEffectv2(StatusEffects.TFDealer2) < 1) player.addStatusValue(StatusEffects.TFDealer2, 2, 1);
        else player.createStatusEffect(StatusEffects.TFDealer2, 0, 1, 0, 0);
        cleanupAfterCombat();
    }
}
}
