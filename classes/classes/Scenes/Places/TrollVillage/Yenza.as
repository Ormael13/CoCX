/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.ZenjiScenes;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class Yenza extends TrollVillageAbstractContent{
    public function Yenza() {
    }

    public function YenzaChecks():void{
        clearOutput();
        if (TrollVillage.YenzaUnlocked == 0){
            if (!TrollVillage.ZenjiFollowing){
                if ((player.femininity > 30 || player.hasBreasts()) && !flags[kFLAGS.LOW_STANDARDS_FOR_ALL]){
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
                            "\"<i>I don’t think I ordered a tall glass of water, and yet here you are.</i>\" She eyes you up and down, taking an extended look at your groin.\n");
                    if (!player.hasCock()){
                        outputText("\"<i>I’ll pass, move along now, I don’t have time for nonsense.</i>\"\n" +
                                "\n" +
                                "She’s very blunt. It would seem she doesn’t even want to talk to you. You decide to leave the diner.\n");
                        doNext(SceneLib.trollVillage.EnterTheVillage);
                    }
                    else{
                        outputText("\"<i>Mira, incluso un poco de yapa para mí… You sure have a lot going for you, don’t you? Sit down, I haven’t properly introduced myself…</i>\"\n" +
                                "\n" +
                                "She turns toward you, her pristine face and long eyelashes bat at you as she displays her cleavage for you. Her breasts are easily D cups.\n" +
                                "\n" +
                                "\"<i>The name’s Yenza, and you are..?</i>\"\n" +
                                "\n" +
                                "You tell Yenza your name.\n" +
                                "\n" +
                                "Yenza gives you a sultry glare, \"<i>[name]... I like that name…</i>\" She leans in closer, encroaching on your personal space.\n" +
                                "\n" +
                                "\"<i>Listen, why don’t the two of us get to know each other later? My house is part of my tailoring shop, just ask anyone, they’ll tell you where it is. I best… get going…</i>\"\n" +
                                "\n" +
                                "Yenza leaves, leaving a fresh, sweet fragrance in her trail as she sashays away.\n" +
                                "\n" +
                                "Once she’s gone you decide to leave the diner, perhaps you could visit her right now?\n");
                        TrollVillage.YenzaUnlocked = 1;
                        doNext(SceneLib.trollVillage.EnterTheVillage);
                    }
                }
            }
            else{
                outputText("Your gaze roams around until you see a rather beautiful looking troll lady by herself. Your attention shifts to Zenji sitting between the two of you, he’s giving you a concerned look. He has been sitting between you and the lady the entire time you suppose.\n" +
                        "\n" +
                        "\"<i>[name]... we should go… Don’t… don’t look...</i>\" He stands up, gesturing for you to follow him.\n" +
                        "\n" +
                        "Instead of following him, your gaze reflexively shifts back around to notice a very beautiful troll standing up now. She is the pinnacle of perfect femininity, with an hourglass figure and long, dark green silky hair. She is approaching fairly quickly. You barely have enough time to blink and she’s already positioned over the other side of the table, giving you a full view of her cleavage.\n");
                outputText("\"<i>So, I see you found the tattered scraps of man I left behind, have you?</i>\" She smirks, \"<i>Has he been a good little boy? Trust me, I know just how tiny he is. Calling him a man is an overstatement.</i>\"\n" +
                        "\n" +
                        "You want to leave, but something compels you to stay. You can’t explain what, but there’s a certain gravity she has over you.\n" +
                        "\n" +
                        "\"</i>Don’t mind the tool slouching at the door, he’s just upset that you’ll never amount to anything like me. It is a shame, really... He had so much to offer me before his mommy had to save the day. Besides, I know seeing me talk to you will make him a mess.</i>\"\n" +
                        "\n" +
                        "She snickers, pointing at Zenji, </i>Look at the stupid look he has on his face, growling in his little corner. He’s such a baby! Trust me, he didn’t even know what to do the first time I was with him in bed. I’d say I feel sorry for you, but… Well, I don’t want to lie directly to your face, now do I? Good luck with that wreck.</i>\"\n" +
                        "\n" +
                        "Yenza leaves, smirking at Zenji as she passes by him at the doorway, copping a feel, much to Zenji’s disgust. Her hand shifts around his waist, groping the base of his tail as well. Zenji practically leaps in fear once she touches his tail.\n" +
                        "\n" +
                        "Yenza giggles, amused before leaving.\n" +
                        "\n" +
                        "Zenji shudders after being sexually assaulted before marching up to you, clearly upset, \"<i>[name]. What. Did. I. Say?</i>\"\n" +
                        "\n" +
                        "Thinking quickly you consider what you want to say.\n");
                menu();
                addButton(0,"Apologize", YenzaApology);
                addButton(1,"Berate", YenzaBeratePart1);
            }
        }
        else{
            if (player.femininity > 30 && !flags[kFLAGS.LOW_STANDARDS_FOR_ALL]){
                outputText("As you near in, her gaze shifts towards you and she rolls her eyes. She stands up and leaves, not even bothering to look at your direction again.\n" +
                        "\n" +
                        "Once she’s gone you figure there’s nothing left for you to do and you leave the diner as well.\n");
                doNext(camp.returnToCampUseOneHour);
            }
            else{
                outputText("As you near her, her gaze eyes you up and down.\n" +
                        "\n" +
                        "\"<i>[name], back again? Our last chat ended so soon, and yet, I still don’t have anything left to offer here.</i>\" She swirls her finger in her glass of juice, bringing it up to her lips and giving it a long, sultry lick.\n" +
                        "\n" +
                        "\"<i>Why don’t you meet me up at my house later and we can… chat… In private…</i>\" she states before standing up and sashaying away.\n" +
                        "\n" +
                        "She’s very evasive and yet persistent. If you want to talk to her, you probably need to go to her house.\n" +
                        "\n" +
                        "Once she’s gone you decide to leave the diner as well seeing as there’s not much left for you to do.\n");
                doNext(camp.returnToCampUseOneHour);
            }
        }
    }

    public function YenzaHome():void{
        clearOutput();
        if (TrollVillage.ZenjiFollowing){
            outputText("Zenji clutches your wrist, pulling you back to him gently, \"<i>[name]... Let’s not do dat. Sound good? Yeah, okay, let’s leave.</i>\"\n" +
                    "\n" +
                    "Zenji is adamant about not going to her house. It’s probably for the best, it’d only stir more trouble.\n");
        }
        else{
            if ((player.hasBreasts() || player.femininity > 30) && !flags[kFLAGS.LOW_STANDARDS_FOR_ALL]){
                outputText("You knock on the door. After a few minutes of waiting, nobody responds, so you decide to take your leave\n");
            }
            else{
                outputText("You knock on the door. It doesn’t take long until you hear footsteps approach and Yenza opens the door.\n" +
                        "\n" +
                        "Yenza speaks softly with a sultry tone, \"<i>[name], it’s you again. Come in…</i>\"\n" +
                        "\n" +
                        "She guides you into her home, it’s small and comfortable. You don’t see much of it as she quickly drags you to her bedroom. Her scent is sweet and overpowering, almost attacking your nostrils.\n" +
                        "\n" +
                        "\"<i>Let’s get straight to business, I know why you’re here, and I’m not taking no for an answer.</i>\" She leans closer, copping a feel from your crotch.\n");
                if (!player.hasCock()){
                    outputText("Her hand goes uninterrupted as she attempts to grope a bulge that does not exist.\n" +
                            "\n" +
                            "\"<i>Ew, get the fuck out of here, now!</i>\" She turns her back against you and refuses to look at you.\n");
                    outputText("With nothing left to do, you take your leave.\n");
                    doNext(SceneLib.trollVillage.EnterTheVillage);
                }
                else{
                   outputText("Her soft, gentle fingers grope at your length. You’re stuck with her now, what do you want to do?\n");
                   YenzaTalkOptions();
                }
            }
        }
    }
    private function YenzaTalkOptions():void{
        menu();
        if (TrollVillage.YenzaUnlocked >= 4){
            outputText("You feel your mind grow clouded when you’re near her. Her scent is getting to you, desperate for more of her presence. You need her now more than ever, you want to be with her forever.\n\n");
        }
        addButton(0, "Appearance", YenzaAppearance);
        addButton(1, "Titjob", YenzaTitjob);
        if (player.cockThatFits(40) >= 0) addButton(2, "Cowgirl", YenzaCowgirl);
        else addButtonDisabled(2,"Cowgirl","Your dick is too big for her.");
        if (TrollVillage.YenzaUnlocked >= 4) addButton(3, "Submit", YenzaSubmit);
        else addButtonDisabled(3, "???", "Req. to know her better.");
    }

    private function YenzaAppearance():void{
        clearOutput();
        outputText("Yenza is a female troll, the pinnacle of femininity. In fact, she’s the only troll you’ve seen with such a perfect figure and incredibly feminine features.\n" +
                "\n" +
                "She is currently clad in a silk, button-up blouse and silken underwear, currently not wearing anything else.\n" +
                "\n" +
                "She is 7’2\" tall, covered in light green fur and dark green frizzled hair that extends down to her neck. She has a jaw-droppingly feminine face with full lips and high cheekbones. Sticking out from her mouth are two ivory tusks, curling upward, each about 6 inches long. Her grey, almond-shaped eyes are adorned with perfectly long and luscious eyelashes. Her gaze peers at you lecherously. Her nose is still pronounced, but not as bulbous as most trolls. Her long ears are still covered in fur, pointed at the tip.\n" +
                "\n" +
                "She carries a perfect hourglass figure with D cup breasts, easily the largest breasts any troll has in the village. Her body is softy with underlying hints of muscle tone, perfect and ready for your touch. She has the standard features you’d expect on a troll. Four fingers and toes, covered head to toe in soft cuddly fur.\n" +
                "\n" +
                "She speaks up, \"<i>Are you just going to stare? I’m not just an object you know. I wonder how long until you realize you’re the only toy here.</i>\"\n");
        YenzaTalkOptions();
    }

    private function YenzaTitjob():void{
        outputText("You tell her that you’re ready, after all, that’s why you’re here.\n" +
                "\n" +
                "She smirks as she guides you to the bedroom.\n" +
                "\n" +
                "\"<i>Let’s get out of these clothes…</i>\" She states as she unbuttons her blouse, letting it drop to the floor as she shimmies out of her panties.\n\n");
        if (!player.lowerGarment.isNothing || !player.upperGarment.isNothing || !player.armor.isNothing){
            outputText("She approaches you and quickly makes way with your [armor] setting all of your clothing aside, making sure she has a full view of your body\n\n");
        }
        outputText("\"<i>Lie down, my little plaything…</i>\" she instructs once she’s ready.\n" +
                "\n" +
                "You follow her guidance, lying down on her soft, plushy bed. She slinks up the bed, resting her breasts against your [legs]. The fur on her breasts tickles you gently, the soft texture of her is tantalizing as you can feel yourself erecting to full mast.\n" +
                "\n" +
                "She gives you a sultry wink as she crawls up on your body, \"<i>Let’s start with a little foreplay, pet. Let me introduce you to the girls...</i>\"\n" +
                "\n" +
                "She places your length in between her full, voluptuous breasts. Lifting her chest up and down along your length. She lowers her long, grey tongue down to the tip of your length, fondling your erection with a sultry grin.\n" +
                "\n" +
                "You thrust against her, wanting to get more out of the situation, needy for her soft grace. Her hands stretch out to your stomach, pressing you firmly down onto her bed.\n" +
                "\n" +
                "\"<i>Bad boy! We got at my speed. Naughty boys don’t get to cum.</i>\"\n" +
                "\n" +
                "She continues working her soft, pliable breasts against your length, breaking down your resistance.\n" +
                "\n" +
                "You squirm underneath her, pre begins to leak from your shaft in arousal.\n" +
                "\n" +
                "She lifts her head back, without breaking eye contact. Circling her index along the tip of your penis, she drags up your pre with her furred fingers. She coats the precum along the top of her breasts, giving you a seductive stare before licking her finger clean.\n" +
                "\n" +
                "You can feel your orgasm impeding, her seductive stare only works to enhance your arousal.\n" +
                "\n" +
                "The woman before you cups the underside of her breasts as she presses them together, covering your length with her bust. She works up and down your length with slow ministrations.\n" +
                "\n" +
                "You can feel your shaft twitch beneath her, ready for release.\n" +
                "\n" +
                "Yenza squeezes her full breasts on you tighter, \"<i>That’s a good boy… cum for me.</i>\"\n" +
                "\n" +
                "You moan in pleasure as your orgasm hits, cumming all over her full breasts.\n" +
                "\n" +
                "She drags a finger to her cum coated breasts, licking up the residue. \"I’ve had better… Now you better lick me clean.</i>\"\n" +
                "\n" +
                "The troll woman crawls over your body, bringing her breasts closer to your face. You lean up to get closer to her, licking up your cum from her breasts and cleaning her off.\n" +
                "\n" +
                "\"<i>This is your reward for being a good boy this time. Go along now, I need not waste any more time with you for now…</i>\"\n" +
                "\n" +
                "You leave her room in a stupor, her scent lingers in your nostrils. You make sure to pick up all your belongings before exiting.\n");
        TrollVillage.YenzaUnlocked += 1;
        doNext(camp.returnToCampUseOneHour);
    }

    private function YenzaCowgirl():void{
        outputText("You tell her that you’re ready, after all, that’s why you’re here.\n" +
                "\n" +
                "She smirks as she guides you to the bedroom.\n" +
                "\n" +
                "\"<i>Let’s get out of these clothes…</i>\" She states as she unbuttons her blouse, letting it drop to the floor as she shimmies out of her panties. [(pc not nudist) She approaches you and quickly makes way with your [armor] setting all of your clothing aside, making sure she has a full view of your body.\n" +
                "\n" +
                "\"<i>Lie down, my little plaything…</i>\" She instructs once she’s ready.\n" +
                "\n" +
                "You oblige to her wishes, splaying your body over the bed for her.\n" +
                "\n" +
                "She straddles your legs, cupping your length in her soft hands. Her tender fingers coax your length to full mast.\n" +
                "\n" +
                "She brings up her fingers to her mouth, lewdly sucking on her hand as she lubricates it with her tongue. She brings her hand back down, now covered in her wet and sticky saliva. Once she’s thoroughly coated your length in her spit she lifts herself above your throbbing erection.\n" +
                "\n" +
                "You can feel her nether lips graze the tip of your length, taunting you with her denial of entry. You squirm beneath her, desperate for more of her soft presence, eager for entry. You buck against her, trying to fit your length in yourself.\n" +
                "\n" +
                "She pushes you back down, \"<i>Now, now, naughty boys must wait for their turn.</i>\"\n" +
                "She gropes at your chest, fondling your pectorals before she begins to lower herself around your girth.\n" +
                "\n" +
                "She moans softly as he penetrates herself on you. Her sweet, refreshing scent coats your nostrils as your vision blurs. The only thing you can concentrate on is her presence before you as she grips your length with her inner walls.\n" +
                "\n" +
                "You moan softly, bucking slightly against her, she doesn’t reprimand you this time as she bounces herself atop your length, her full breasts jiggling softly from the force of her bouncing.\n" +
                "\n" +
                "Her grip on your erection tightens as she moans louder. She places her hands on your shoulders, holding onto you to keep her balance. You can feel yourself nearing the edge as well, her vice-like grip on your shaft tightens as she squeezes onto you, trying to coax you further to the edge.\n" +
                "\n" +
                "You try to hold onto her hips so you can thrust into her with ease, but she swats your hand away.\n" +
                "\n" +
                "\"<i>Does my toy want my hips? Perhaps if you’re a good boy I’ll let you touch me…</i>\" She mutters as she continues grinding against you.\n" +
                "\n" +
                "You can’t take her constant teasing anymore. The combined pleasure from her tight grip against your girth finally pushes you over the edge. You thrust into her awaiting womb, cumming with pent up intensity. She moans again, softer this time as she reaches her climax. You can feel her cool girlcum coat your length, combining with your fluids as she slips out of you with ease.\n" +
                "\n" +
                "\"<i>Not the best... I can tell you’re not from around here… Ah, well, perhaps I’ll just need to train my pet a little more.</i>\" She says with a snicker.\n" +
                "\n" +
                "The air grows thicker as her sweet scent becomes overpowering. Her smug aura mocks you as you black out.\n" +
                "\n" +
                "You wake up with all of your possessions at your camp. You’re unsure what happened, but you’re not missing anything.\n");
        TrollVillage.YenzaUnlocked += 1;
        doNext(camp.returnToCampUseOneHour);
    }

    private function YenzaSubmit():void{
        outputText("Her scent is enthralling as her gravity begins to surmount you. Her presence is overwhelming as if the only thing you could ever think about is her. Her hands roam over your figure, the only thing you’re able to concentrate on is her silky dark green hair.\n" +
                "\n" +
                "You stagger about in your stupor, drunk on lust and her sweet scent. Your vision blurs and before you know it you’re naked on her bed, she’s straddled on top of you.\n");
        if (ZenjiScenes.ZenjiMarried){
            outputText("You hear the door to her bedroom burst open, Zenji stands at the frame infuriated. \n" +
                    "\n" +
                    "\"<i>YOU! GET AWAY FROM [name]! NOW!</i>\" he shouts\n" +
                    "\n" +
                    "\"<i>Oh, if it isn’t one of my pets coming back to me?</i>\" Yenza replies as she dismounts you.\n" +
                    "\n" +
                    "\"<i>I am not your pet, neither is he.</i>\" Zenji states, gesturing toward you\n" +
                    "\n" +
                    "Yenza stands at the side of the bed, arms folded over her breasts. \"<i>Just give in, Zenji. [name] already has. Make things easier on yourself, you know you want to.</i>\"\n" +
                    "\n" +
                    "Zenji roars before charges at her, ramming his head into her midriff. Yenza screams as she’s knocked back against the wall. She falls over, dazed, and unable to pick herself up.\n" +
                    "\n" +
                    "Before she has time to react or say anything, Zenji quickly picks you up along with all your possessions.\n" +
                    "\n" +
                    "He carries you back to camp safely, once he makes sure the coast is clear he rests you on his bedroll.\n" +
                    "\n" +
                    "He speaks softly, gently caressing your face, \"<i>[name]... Are you okay..?</i>\"\n" +
                    "\n" +
                    "Zenji shakes his head before you can respond\n" +
                    "\n" +
                    "\"<i>Please, [name]... I can’t lose you, I figured wit all de time ya spent away from me dat it could only be one ting. Besides, word travels fast in de village, it was only a matta of time before I heard de news.</i>\"\n" +
                    "\n" +
                    "\"<i>You’re going to take a break from de village for now. I’ll make sure of it.</i>\"\n");
            TrollVillage.YenzaLockdown = model.time.days + 5;
            doNext(camp.returnToCampUseOneHour);
        }
        else{
            outputText("Your length aches, throbbing desperately from between her plush backside. She grinds softly against you, pressing your shaft against her backdoor. She slowly slides against you, coaxing more pre to emerge from your length.\n" +
                    "\n" +
                    "\"<i>That’s a good boy,</i>\" she croons, \"<i>I think maybe it’s about time I gave you some… proper treatment.</i>\"\n" +
                    "\n" +
                    "She lifts her body, penetrating herself on your shaft, grinding against you gently. Your wit dims and vision clouds further, the only thing you can concentrate on is the pleasurable feeling of her cunt clamping down on your length, squeezing you gently and trying to milk you of everything you’re worth.\n" +
                    "\n" +
                    "You buck against her and she doesn’t reprimand you. It’s but mindless fucking and she’s the only thing that concerns you now. Yenza is your queen, your master, your goddess… The only thing that has any meaning anymore.\n" +
                    "\n" +
                    "You spend hours beneath her, filling her up with your seed, desperate for more of her warmth.\n" +
                    "\n" +
                    "Once she’s done with her toy she leaves you on the bed, tying you up for later use. You don’t resist, the gravity she has over you is insurmountable and the sweet scent she exudes is more than enough to keep you wanting more.\n" +
                    "\n" +
                    "This is your life now, nothing more than Yenza’s next pet.\n");
            EventParser.gameOver();
        }
    }

    private function YenzaApology():void{
        clearOutput();
        outputText("You apologize, you’re not sure what happened or why she was so hostile.\n" +
                "\n" +
                "Zenji growls, \"<i>[name]. Why?! Why would you do dat when I specifically told ya not to?! I told you not to talk to her, and follow me. You didn’t listen. Look, I dunno if tings are gonna work out if you’re gonna be like dis.</i>\"\n" +
                "\n" +
                "You tell Zenji to take a deep breath and relax, you’re sorry to have provoked him, you didn’t mean to hurt him.\n" +
                "\n" +
                "\"<i>I AM CALM!</i>\" he shouts, \"<i>YOU ARE THE ONE WHO’S DOING MORE HARM THAN SHE IS!</i>\" His face is turning red, tears are streaming down his face. \"<i>SHE IS JUST A BITCH THAT RAPED ME. WHOM OF WHICH YOU NEVER SHOULD’VE TALKED TO! YOU DISOBEYED ME, I TOLD YOU TO COME WITH ME! YOU’VE TAKEN IT TOO FAR! I TOLD YOU NOT TO TALK TO HER! WHAT DID I SAY?! ¡CALABAZA! WHAT DID I SAY?!</i>\"\n" +
                "\n" +
                "You’re taken aback, you’ve never heard Zenji raise his voice before. You’re not sure what to say right now.\n" +
                "\n" +
                "Zenji notices the look on your face before his expression turns from rage to sorrow as he collapses to the ground after making such a scene. He’s curled up into a fetal position with his tail tucked between his legs, bawling his eyes out.\n" +
                "\n" +
                "\"<i>I… I am so sorry, [name]... I didn’t mean to say dose tings… I just… I… I...</i>\"\n" +
                "\n" +
                "You kneel close to him, gently stroking his back, telling him that it’s okay, he just had a lot of emotions to work out. You can tell that’s been bottled up for who knows how long.\n" +
                "\n" +
                "Zenji continues crying, tears are still streaming down his face. He wipes his nose with his arm, unable to make out a coherent sentence.\n" +
                "\n" +
                "After a minute of crying it out, Zenji finally speaks up through the sniffling. \"<i>Please, [name]... go home, leave me alone... I’ll… I’ll be back later…</i>\"\n" +
                "\n" +
                "If that’s what he wants you’ll leave him be.\n");
        outputText("<b>Zenji has temporarily left the camp.</b>");
        SceneLib.zenjiScene.zenjiHenchmanOption2(true);
        TrollVillage.ZenjiFollowing = false;
        TrollVillage.ZenjiVillageStage = 2;
        if (flags[kFLAGS.SLEEP_WITH] == "Zenji") {
            flags[kFLAGS.SLEEP_WITH] = "";
            TrollVillage.ZenjiSleep = true;
        }
        TrollVillage.ZenjiTrollVillageTimeChk = time.days + 1;
        doNext(camp.returnToCampUseOneHour);
    }

    private function YenzaBeratePart1():void{
        clearOutput();
        outputText("You tell Zenji to grow a thicker skin, she’s just trying to peev him and he shouldn’t take it so seriously. He needs to man up.\n" +
                "\n" +
                "Zenji grows furiously, \"<i>I WILL NOT TOLERATE THIS! APOLOGIZE. NOW! YOU ARE BEING A BIGGER BITCH THAN SHE IS!</i>\"\n" +
                "\n" +
                "You fold your arms and refuse, not until he calms down.\n" +
                "\n" +
                "Zenji curls his fist into a ball, punching your face in one swift motion.\n" +
                "\n" +
                "You feel disoriented by how brutal his punch is before shaking it off.\n" +
                "\n" +
                "Zenji shouts at the top of his lungs, \"<i>GET OUT OF MY SIGHT, [name]! GET OUT! GET OUT! GET OUT!</i>\"\n" +
                "\n" +
                "Zenji is throwing a tantrum, slamming his foot repeatedly against the floor as tears stream across his face.\n" +
                "\n" +
                "You sigh and roll your eyes as you take your leave, if he’s mature about this then he’ll realize what went wrong.\n" +
                "\n" +
                "You decide to head back to camp\n" +
                "\n" +
                "You begin to wonder if Zenji is ever going to return to you after that scene.\n")
        outputText(" <b>Zenji has been removed from the game.</b>");
        TrollVillage.ZenjiBerated = true;
        if (flags[kFLAGS.SLEEP_WITH] == "Zenji") {
            flags[kFLAGS.SLEEP_WITH] = "";
        }
        flags[kFLAGS.ZENJI_PROGRESS] = -1;
        doNext(camp.returnToCampUseOneHour);
    }

    public function YenzaBeratePart2():void{
        clearOutput();
        spriteSelect(SpriteDb.s_zenji);
        outputText("While taking a moment to relax, you hear heavy footsteps approaching. You look over and see Zenji with a solemn look on his face.\n" +
                "\n" +
                "\"<i>[name]... I’m… I’m sorry for dat… for what happened yesterday… I just… Dat girl, she’s put me through a lot and seeing her talk ta ya just broke me… It hurt a lot to see you wit her… It was as if she were coming after you as well… I guess I’m still an immature baby like she said. I can’t even control myself when I’m around her.</i>\"\n" +
                "\n" +
                "You assure Zenji that he is not immature, he is your lover and he means the world to you. She was the immature one by purposefully trying to get under his skin.\n" +
                "\n" +
                "\"<i>I guess you’re right, [name]. I was just scared that I’d see her again. Part of de reason why I left was that every time I saw her she’d give me dat stare… I was afraid you’d see me as less of a man when I was near her. I’m just… It’s scary to know dat people are out dere dat only want what dey want wit no care fa others. I always fear dat I may lose you or get hurt again, I don’t want to be hurt, I don’t want you to get hurt. I guess de only thing I felt like I could do was run away from my problems... We can talk about dis later, I’m just glad to be here wit you again. Please don't see me as less of a man for sharing my feelings.</i>\"\n" +
                "\n" +
                "You assure him that he's not less of a person for talking to you about himself.\n" +
                "\n" +
                "Zenji pulls you in for a warm hug, holding you tightly as if he were to let go you’d be lost from him forever.\n" +
                "\n" +
                "\"<i>When I’m with you it’s not so scary because I know you won’t hurt me. I love you, [name]. I love you so much...</i>\"\n");
        TrollVillage.ZenjiTrollVillageTimeChk = -1;
        TrollVillage.ZenjiVillageStage = 3;
        if (!TrollVillage.ZenjiFollowing){
            SceneLib.zenjiScene.zenjiHenchmanOption2(true);
        }
        if (TrollVillage.ZenjiSleep && flags[kFLAGS.SLEEP_WITH] == ""){
            flags[kFLAGS.SLEEP_WITH] = "Zenji";
        }
        doNext(camp.returnToCampUseOneHour);
    }
}
}
