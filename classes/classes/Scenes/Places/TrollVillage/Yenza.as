package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.TrollVillage;
public class Yenza extends TrollVillageAbstractContent{
    public function Yenza() {
    }

    public function YenzaChecks():void{
        clearOutput();
        if (!TrollVillage.YenzaUnlocked){
            if (!TrollVillage.ZenjiFollowing){
                if (player.femininity > 30 || player.hasBreasts()){
                    outputText("Your eyes roam around until you decide to approach the rather beautiful looking troll sitting by herself.\n" +
                            "\n" +
                            "As you approach she notices you. She scrunches her face in disgust. As you get closer she scoffs and turns away from you.\n" +
                            "\n" +
                            "It looks like she doesn’t want to even look at you right now, what is her deal anyway?\n");
                    doNext(SceneLib.trollVillage.EnterTheVillage);
                }
                else{
                    outputText("You decide to approach the rather beautiful looking troll sitting by herself. She looks toward you and raises an eyebrow as you approach her.\n" +
                            "\n" +
                            "“I don’t think I ordered a tall glass of water, and yet here you are.” She eyes you up and down, taking an extended look at your groin.\n");
                    if (player.hasCock()){
                        outputText("“I’ll pass, move along now, I don’t have time for nonsense.”\n" +
                                "\n" +
                                "She’s very blunt. It would seem she doesn’t even want to talk to you. You decide to leave the diner.\n");
                        doNext(SceneLib.trollVillage.EnterTheVillage);
                    }
                    else{
                        outputText("“Mira, incluso un poco de yapa para mí… You sure have a lot going for you, don’t you? Sit down, I haven’t properly introduced myself…”\n" +
                                "\n" +
                                "She turns toward you, her pristine face and long eyelashes bat at you as she displays her cleavage for you. Her breasts are easily D cups.\n" +
                                "\n" +
                                "“The name’s Yenza, and you are..?”\n" +
                                "\n" +
                                "You tell Yenza your name\n" +
                                "\n" +
                                "Yenza gives you a sultry glare, “[name]... I like that name…” She leans in closer, encroaching on your personal space.\n" +
                                "\n" +
                                "“Listen, why don’t the two of us get to know each other later? My house is part of my tailoring shop, just ask anyone, they’ll tell you where it is. I best… get going…”\n" +
                                "\n" +
                                "Yenza leaves, leaving a fresh, sweet fragrance in her trail as she sashays away.\n" +
                                "\n" +
                                "Once she’s gone you decide to leave the diner, perhaps you could visit her right now?\n");
                        TrollVillage.YenzaUnlocked = true;
                        doNext(SceneLib.trollVillage.EnterTheVillage);
                    }
                }
            }
            else{
                outputText("Your gaze roams around until you see a rather beautiful looking troll lady by herself. Your attention shifts to Zenji sitting between the two of you, he’s giving you a concerned look. He has been sitting between you and the lady the entire time you suppose.\n" +
                        "\n" +
                        "“[name]... we should go… Don’t… don’t look...” He stands up, gesturing for you to follow him.\n" +
                        "\n" +
                        "Instead of following him, your gaze reflexively shifts back around to notice a very beautiful troll standing up now. She is the pinnacle of perfect femininity, with an hourglass figure and long, dark green silky hair. She is approaching fairly quickly. You barely have enough time to blink and she’s already positioned over the other side of the table, giving you a full view of her cleavage.\n");
                outputText("“So, I see you found the tattered scraps of man I left behind, have you?” She smirks, “Has he been a good little boy? Trust me, I know just how tiny he is. Calling him a man is an understatement.”\n" +
                        "\n" +
                        "You want to leave, but something compels you to stay. You can’t explain what, but there’s a certain gravity she has over you.\n" +
                        "\n" +
                        "“Don’t mind the tool slouching at the door, he’s just upset that you’ll never amount to anything like me. It is a shame, really... He had so much to offer me before his mommy had to save the day. Besides, I know seeing me talk to you will make him a mess.”\n" +
                        "\n" +
                        "She snickers, pointing at Zenji, “Look at the stupid look he has on his face, growling in his little corner. He’s such a baby! Trust me, he didn’t even know what to do the first time I was with him in bed. I’d say I feel sorry for you, but… Well, I don’t want to lie directly to your face, now do I? Good luck with that wreck.”\n" +
                        "\n" +
                        "Yenza leaves, smirking at Zenji as she passes by him at the doorway, copping a feel, much to Zenji’s disgust. Her hand shifts around his waist, groping the base of his tail as well. Zenji practically leaps in fear once she touches his tail.\n" +
                        "\n" +
                        "Yenza giggles, amused before leaving.\n" +
                        "\n" +
                        "Zenji shudders after being sexually assaulted before marching up to you, clearly upset, “[name]. What. Did. I. Say?”\n" +
                        "\n" +
                        "Thinking quickly you consider what you want to say.\n");
                menu();
                addButton(0,"Apologize", YenzaApology);
                addButton(1,"Berate", YenzaBerate);
            }
        }
        else{
            if (player.femininity > 30){
                outputText("As you near in, her gaze shifts towards you and she rolls her eyes. She stands up and leaves, not even bothering to look at your direction again.\n" +
                        "\n" +
                        "Once she’s gone you figure there’s nothing left for you to do and you leave the diner as well.\n");
                doNext(camp.returnToCampUseOneHour);
            }
            else{
                outputText("As you near her, her gaze eyes you up and down.\n" +
                        "\n" +
                        "“[name], back again? Our last chat ended so soon, and yet, I still don’t have anything left to offer here.” She swirls her finger in her glass of juice, bringing it up to her lips and giving it a long, sultry lick.\n" +
                        "\n" +
                        "“Why don’t you meet me up at my house later and we can… chat… In private…” She says before standing up and sashaying away.\n" +
                        "\n" +
                        "She’s very evasive and yet persistent. If you want to talk to her, you probably need to go to her house.\n" +
                        "\n" +
                        "Once she’s gone you decide to leave the diner as well seeing as there’s not much left for you to do.\n");
                doNext(camp.returnToCampUseOneHour);
            }
        }
    }

    public function YenzaHome():void{

    }

    private function YenzaApology():void{
        outputText("You apologize, you’re not sure what happened or why she was so hostile.\n" +
                "\n" +
                "Zenji growls, “[name]. Why?! Why would you do dat when I specifically told ya not to?! I told you not to talk to her, and follow me. You didn’t listen. Look, I dunno if tings are gonna work out if you’re gonna be like dis.”\n" +
                "\n" +
                "You tell Zenji to take a deep breath and relax, you’re sorry to have provoked him, you didn’t mean to hurt him.\n" +
                "\n" +
                "“I AM CALM!” he shouts, “YOU ARE THE ONE WHO’S DOING MORE HARM THAN SHE IS!” His face is completely red, tears are streaming down his face. “SHE IS JUST A BITCH THAT RAPED ME. WHOM OF WHICH YOU NEVER SHOULD’VE TALKED TO! YOU DISOBEYED ME, I TOLD YOU TO COME WITH ME! YOU’VE TAKEN IT TOO FAR! I TOLD YOU NOT TO TALK TO HER! WHAT DID I SAY?! ¡CALABAZA! WHAT DID I SAY?!”\n" +
                "\n" +
                "You’re taken aback, you’ve never heard Zenji raise his voice before. You’re not sure what to say right now.\n" +
                "\n" +
                "Zenji notices the look on your face before his expression turns from rage to sorrow as he collapses to the ground after making such a scene. He’s curled up into a fetal position with his tail tucked between his legs, bawling his eyes out.\n" +
                "\n" +
                "“I… I am so sorry, [name]... I didn’t mean to say dose tings… I just… I… I...”\n" +
                "\n" +
                "You kneel close to him, gently stroking his back, telling him that it’s okay, he just had a lot of emotions to work out. You can tell that’s been bottled up for who knows how long.\n" +
                "\n" +
                "Zenji continues crying, tears are still streaming down his face. He wipes his nose with his arm, unable to make out a coherent sentence.\n" +
                "\n" +
                "After a minute of crying it out, Zenji finally speaks up through the sniffling. “Please, [name]... go home, leave me alone... I’ll… I’ll be back later…”\n" +
                "\n" +
                "If that’s what he wants you’ll leave him be.\n");
        TrollVillage.ZenjiVillageStage = 2;
        doNext(camp.returnToCampUseOneHour);
    }

    private function YenzaBerate():void{
        clearOutput();
        outputText("You tell Zenji to grow a thicker skin, she’s just trying to peev him and he shouldn’t take it so seriously. He needs to man up.\n" +
                "\n" +
                "Zenji grows furiously, “I WILL NOT TOLERATE THIS! APOLOGIZE. NOW! YOU ARE BEING A BIGGER BITCH THAN SHE IS!”\n" +
                "\n" +
                "You fold your arms and refuse, not until he calms down.\n" +
                "\n" +
                "Zenji curls his fist into a ball, punching your face in one swift motion.\n" +
                "\n" +
                "You feel disoriented by how brutal his punch is before shaking it off.\n" +
                "\n" +
                "Zenji shouts at the top of his lungs, “GET OUT OF MY SIGHT, [name]! GET OUT! GET OUT! GET OUT!”\n" +
                "\n" +
                "Zenji is throwing a tantrum, slamming his foot repeatedly against the floor as tears stream across his face.\n" +
                "\n" +
                "You sigh and roll your eyes as you take your leave, if he’s mature about this then he’ll realize what went wrong.\n" +
                "\n" +
                "You decide to head back to camp\n" +
                "\n" +
                "You begin to wonder if Zenji is ever going to return to you after that scene.\n")
        outputText(" Zenji has been removed from the game.");
        TrollVillage.ZenjiBerated = true;
        flags[kFLAGS.ZENJI_PROGRESS] = -1;
        doNext(camp.returnToCampUseOneHour);
    }
}
}
