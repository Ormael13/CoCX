package classes.Scenes.NPCs {
import classes.BodyParts.Face;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumables.VampireBlood;
import classes.Scenes.Camp;
import classes.PerkLib;
import classes.Races;
import classes.StatusEffects;
import classes.display.SpriteDb;

import coc.view.ButtonDataList;

import flash.utils.getQualifiedClassName;

public class DivaScene extends XXCNPC {
    private static var _instance:DivaScene;

    public var status:int;
    private var firstLoss:Boolean = true;
    public var tookVialToday:Boolean = false; // true if took her vial today
    private var timesReduced:int = 0;
    private var _talkMenu:ButtonDataList = new ButtonDataList();
    private var _sexMenu:ButtonDataList = new ButtonDataList();

    public function DivaScene() {
        if (!_instance) {
            super("diva");
            _instance = this;
            Camp.addFollower(this);
            addSavedNPC(this);
        } else {
            throw new Error("Singleton class. Use instance to access");
        }
    }

    public static function get instance():DivaScene {
        if (!_instance) {
            new DivaScene();
        }
        return _instance;
    }

    public override function unload():void {
        Camp.removeFollower(_instance);
        _instance = null;
    }

    public override function save(saveto:*):void {
        saveto.diva = {
            myClass: getQualifiedClassName(this),
            status: status,
            firstLoss: firstLoss,
            tookVialToday: tookVialToday,
            timesReduced: timesReduced,
            bloodUsed: VampireBlood.first
        }
    }

    public override function load(loadfrom:*):void {
        if (loadfrom == undefined || loadfrom.diva == undefined) {
            VampireBlood.first = true;
            unload();
        } else {
            status = loadfrom.diva.status;
            firstLoss = loadfrom.diva.firstLoss;
            timesReduced = loadfrom.diva.timesReduced;
            tookVialToday = loadfrom.diva.tookVialToday;
            VampireBlood.first = loadfrom.diva.bloodUsed;
        }
    }

    public override function isCompanion(type:int = -1):Boolean {
        if ((type == LOVER || type == COMPANION) && !player.hasStatusEffect(StatusEffects.DivaOff)) return status == -1;
        return false;
    }

    override public function campDescription(buttons:ButtonDataList, menuType:int = -1):void {
        if (isCompanion(menuType)) {
            if (time.hours >= 20) outputText("Diva is quietly doing things next to her tent, readying for the nighttime.");
            else if (time.hours < 7) outputText("Diva is likely hunting a fair the distance away from the camp, though you could call her back at any time.");
            else outputText("Since it's daytime, Diva is likely sleeping in her coffin.");
            buttons.add("Diva", campInteraction).disableIf(time.hours >= 7 && time.hours < 20,
                "Don't bother vampires during the day!");
        }
    }

    private function talkMenu():void {
        clearOutput();
        outputText("\"<i>Oh? What thou want to talk about? I have things to do but I can take a few minutes.</i>\"");
        setupTalkMenu();
        submenu(_talkMenu, campInteraction, 0, false);
    }

    private function sexMenu():void {
        clearOutput();
        outputText("\"<i>I agree, and I'm in the mood for a few exchanges if they are. What thou propose?</i>\"")
        setupSexMenu();
        submenu(_sexMenu, campInteraction, 0, false);
    }

    private function vampirism():void {
        clearOutput();
        outputText("Seriously, why does she need blood to survive, anyway? Couldn't she just eat a steak like everyone?\n"
            + "\n"
            + "\"<i>Thou may not know but my very fragile stomach does not allow any other form of nutrition. I wouldn't be able to eat like the others even if I wanted to.</i>\"\n"
            + "\n"
            + "So she literally gets sick when eating normal food... well that's sad for her. What about garlic?\n"
            + "\n"
            + "\"<i>Simple allergy, nothing more.</i>\"\n"
            + "\n"
            + "Is her issue contagious?\n"
            + "\n"
            + "\"<i>Not unless you drink some of my blood or blood I drank from. My bite is not viral but can leave my prey weak and sometimes close to death from blood loss. Now if thou would excuse me I need to prepare for tonight.</i>\"\n"
            + "\n"
            + "You nod and let the vampire to her thing going back to yours.");
		if (player.racialScore(Races.VAMPIRE) >= 20) {
			if (!player.hasStatusEffect(StatusEffects.Familiar)) player.createStatusEffect(StatusEffects.Familiar, 0, 0, 0, 0);
			if (!player.hasPerk(PerkLib.Familiar)) player.createPerk(PerkLib.Familiar, 0, 0, 0, 0);
		}
        doNext(talkMenu);
    }

    private function sunlight():void {
        clearOutput();
        outputText("So, something came to your attention... why exactly does she hate sunlight?\n"
            + "\n"
            + "\"<i>It’s bad for my skin... also bright light just outright hurt my eyes. I’m almost blind at day and I have to constantly cover my eyes to be able to see anything ahead of me.</i>\"\n"
            + "\n"
            + "So it's not because she will turn to ashes or anything of the stories.\n"
            + "\n"
            + "\"<i>If you’re talking about vampire tales from foreign lands, I will have you know I’m alive just like you are. I just happen to have a body closer to bats and nocturnal creatures, than I do to the daywalkers. As far as it goes, the only trait I share with your so-called 'mythical vampire' is that whenever I drink a lot of blood, I begin to develop magical powers and tremendous strength. I know for a fact I age at a slowed rate, although I will likely still die when I get too old, I only have an extended lifespan rather than true immortality. Furthermore drinking heals my wounds quicker thanks to my ability to swiftly metabolise food to repair my damaged tissue.</i>\"\n"
            + "\n"
            + "Well, now that you think of it, you wonder if meeting a vampire who has none of the standard weaknesses but the strength of a woman five time her size is any better than the monster of legends told of in Ingnam. You leave to ponder on this somewhat creepy question.");
        doNext(talkMenu);
    }

    private function her():void {
        clearOutput();
        outputText("Now, that you think of it, was she always a vampire?\n"
            + "\n"
            + "\"<i>No... In the same way as most adventurers, I used to be a human and came here by accident about 30 years ago. Truth be told Mareth was already a hell of a mess back then.</i>\"\n"
            + "\n"
            + "So what happened anyway?\n"
            + "\n"
            + "\"<i>The demons happened, some crazed freak with horns caught me while I was sleeping and brought me to his laboratory to experiment on me. Said something along the line of creating a new variety of demonic servant for Lethice as he toyed with my body for an entire month using both corruptive material and modified transformative items. Regardless, the incubus messed up badly, because not only I awoke in a bloodcrazed rage, but I pretty much drank him dry along with his other test subjects. He had three orgasms by the time I was done, and I was not going to hold back after being starved for food for an entire month.</i>\"\n"
            + "\n"
            + "This explains the aphrodisiacs in her bite and her fleeting magical talents, if not absurd strength. Well, at least, she didn’t get her vampirism out of nowhere.");
        doNext(talkMenu);
    }

    private function vialofliquid():void {
        clearOutput();
        outputText("You ask Diva if she would mind giving you some blood.\n\n");
        if (player.isRace(Races.VAMPIRE))
            outputText("She blushes with embarrassment and replies \"<i>Thy know, if thou just asked to drink straight from the tap I wouldn't mind too. Perhaps another time.</i>\"");
        else
            outputText("\"<i>I wouldn't mind, [name], but be warned that it is highly infectious.</i>\"");
        outputText("She hands to you a vial right away.");
        tookVialToday = true;
        inventory.takeItem(consumables.VAMPBLD, talkMenu);
    }

    private function setupTalkMenu():void {
        _talkMenu.clear();
        _talkMenu.add("Vampirism", vampirism);
        _talkMenu.add("Sunlight", sunlight);
        _talkMenu.add("Her", her);
        _talkMenu.add("Vial", vialofliquid).disableIf(tookVialToday, "You asked for blood already, wait for tomorrow.");
    }


    private function setupSexMenu():void {
        _sexMenu.clear();
        _sexMenu.add("Moonlight Sonata", moonlightSonata);
        _sexMenu.add("Share A Meal", shareAMeal).disableIf(!player.isRace(Races.VAMPIRE, 1, false) || player.faceType != Face.VAMPIRE,
            "Req. you to be a vampire and have a vampiric face.");
        _sexMenu.add("Bloody Rose", bloodyRose).disableIf(!player.isRace(Races.VAMPIRE, 1, false) || player.faceType != Face.VAMPIRE,
            "Req. you to be a vampire and have a vampiric face.");
    }

    override public function campInteraction():void {
        clearOutput();
        spriteSelect(SpriteDb.s_diva);
        if (time.hours >= 20) {
            outputText("Diva hears your call and flies back to you in a heartbeat.\n"
                + "\n"
                + "\"<i>Oh, hello, [name], thou aren't going to sleep or can't go to bed yet?</i>\"");
        } else {
            outputText("Diva hears your call and flies back to you in a heartbeat.\n"
                + "\n"
                + "\"<i>The sun is out, it's time to fly. What about thou, [name]? Would you like to hunt with me, or are thou interested in something else?</i>\"");
        }
        menu();
        addButton(0, "Talk", talkMenu);
        addButton(1, "Sex", sexMenu);
        addButton(14, "Back", camp.campLoversMenu);
    }

    public function moonlightSonata(fromCombat:Boolean = false):void {
        if (status == 0) status = 1;
        clearOutput();
        if (fromCombat) {
            outputText("You fall to the ground unable to fight further as Diva declares:\n"
                + "\n"
                + "\"<i>Thou have lost, therefore thou have to surrender to me both heart and body. Thy shall pay the blood price first.</i>\"\n"
                + "\n"
                + "Diva closes her wings and wraps her arms around you in an almost maternal way, you can feel her E cup breasts press gently against your chest, the temperature between you increasing steadily as she bites your neck. Her kiss is oddly pleasurable, like a warm bath after a rough day of work and you somehow feel at peace while letting the vampire drink on your blood. You're not the only one aroused however as the pale woman's cheeks redden and her eyes droop in a fawning deep love expression. Diva breaks the embrace, her cheeks as red as the blood that she took, and her hand slowly moves downward.");
        } else {
            outputText("Both of you head back to her castle for a more comfortable bedroom. Once you are sitting on the bed,you two enjoy some idle chat before moving on as Diva closes her wings around you in an almost possessive way and bites your neck gently. Her bite is as pleasurable as ever and you feel at peace while letting her drink your blood. You're not the only one aroused as the vampire clearly seems to also get off on this, looking redder by the second. Diva breaks the embrace, her face red as a tomato as her hand slowly move downward.");
        }
        outputText("\n\n");
        sceneHunter.selectGender(dickF, vagF, null, null, 0);

        //=========================================
        function dickF():void {
            var x1:int;
            if (player.cockThatFits(24, "length") < 0) { //check if ANY is fitting, otherwise this is trash
                x1 = player.smallestCockIndex() + 1;
                outputText("Diva sees the size of your already erect [cock "+x1+"] and sighs in annoyance.\n"
                    + "\n"
                    + "\"<i>This thing is unsightly. I think thou will almost thank me for what I will do now.</i>\"\n"
                    + "\n"
                    + "Diva forces you to the ground and you scream as she literally bites your cock! The sharp pain is only temporary, however, and as blood flows out of your dick, you begin to moan from the pleasure forced unto your cock by some sort of aphrodisiac contained in her saliva. You watch stunned both by horror and pleasure as your dick progressively decrease in size down to 18 inches. Diva pulls her lips away from your cock as the wound slowly closes itself."
                    + "\n");
                timesReduced++;
                if (timesReduced >= 5) outputText("\"<i>It's the fifth time I have to fix thou, are thou seriously enjoying this?</i>\"\n");
                else outputText("\"<i>And now for the main course...</i>\"\n");
                outputText("\n");
                player.cocks[x1 - 1].cockLength = 18; //much better
            }
            else x1 = player.cockThatFits(24, "length") + 1;
            if (player.isRace(Races.BAT, 1, false) || player.isRace(Races.VAMPIRE, 1, false)) {
                outputText("You let her bite you first, but it would be unfair if you didn't have your share. You bite her back, sharing the blood with her, as the two of you do a consanguine exchange. She tastes quite good actually, like a mix of roses and strawberry, and, before long, you're both red with lust and ready to get down to business as her hand is already at your crotch and is finally reciprocated by yours to her pussy. Both of your necks are bleeding but you don't care, you are way too focused on getting your respective partner off to do so.\n"
                    + "\n"
                    + "Aside from her blood you are quite interested in her other fluids, namely her milk. You move your head to Diva's E-cups and gently start suckling. She moans delighted at your attention holding your head next to her nipples as she nurses you. Her milk is delicious, it's a welcome alternative to blood, really. Done drinking, you open your mouth with a ‘pop!', finished with the foreplay as you move on to the main course."
                    + "\n");
                player.sexReward("milk", "Lips");
            } else sceneHunter.print("Check failed: vampire/bat race");
            outputText("Diva slowly starts to cup your [balls] then moves down to take care of your now raging erection, spitting on your [cock "+x1+"] and stroking it with her hand to properly lube it. You moan as she engulfs your tip one of her canine running along your length. She takes great care not to bite your cock as she prepares it for later.\n"
                + "\n"
                + "As it appears, Diva does not favor undergarments, which is quite lewd on her part, but you're quickly pushed out of your daydreams as she proceeds to slide your cock, still covered with drool, out of her mouth. She moves up to you and closes both her arms and wings around your body as she gets in position. You can feel her cunt right at your [cockhead "+x1+"].\n"
                + "\n");
            if (fromCombat) outputText("\"<i>Thou get to taste my second mouth, so thou should feel honored. It's more than you deserve.</i>\"\n");
            else outputText("\"<i>Your neck tastes good, [name], but I will need more than that to be satisfied.</i>\"\n");
            outputText("\n"
                + "Diva slowly slides down on your slick [cock "+x1+"], giving you a fanged smile of bliss as she slowly takes your length in. She feels similar to what you think a succubus would and her pussy clearly has something inhuman about it. She's now riding you, wings closed around your torso, arms and around your shoulders, as she milks your [cock "+x1+"] thoroughly. You moan in pleasure as the vampire bites your neck in the middle of the act only making you more erect and ready, your [cock "+x1+"] harder than ever. She unplugs her mouth only for a moment, just to whisper in your ear.\n"
                + "\n"
                + "\"<i>How does my kiss feel like? Devilish, isn't it? I will bring thou to heaven seven time fold so go ahead and feed both of my mouths, I know thou wants it, so consider thyself to have my permission.</i>\"\n"
                + "\n"
                + "The feeling of her biting you and working your cock is like penetrating and being penetrated at the same time and your eye rolls at the pleasure. Unable to hold any longer, you flood her pussy with your cum, orgasming from both your pierced neck and madly twitching cock. It continues for several hours until sun begins to rise, at which point Diva bids you farewell.");
            player.sexReward("vaginalFluids", "Dick");
            sharedEnd();
        }

        function vagF():void {
            sceneHunter.print("Fork: vampires get more!");
            if (player.isRace(Races.BAT, 1, false) || player.isRace(Races.VAMPIRE, 1, false)) {
                outputText("You let her bite you first, but it would be unfair if you didn't have your share. You bite her back, sharing the blood with her as the two of you do a consanguine exchange. She tastes quite good actually, like a mix of roses and strawberry, and before long, you're both red with lust and ready to get down to business as her hand in your wet fold is finally reciprocated by yours.\n"
                    + "\n"
                    + "Both of your necks are bleeding, but you don't care, you are way too focused on getting your respective partner off. You gasp as her hand teases your already moistening fold. You moan as she starts to slowly finger you, grabbing one of her breasts through her dark dress to return the favor. The vampire girl doesn't stop you, it seems she's as aroused as you are. You get under her skirt and insert your fingers in her pussy to return the favor, making her moan in delight. Soon the splashes of blood on the ground are mixed with girl cum, creating a larger puddle as you orgasm together.\n"
                    + "\n"
                    + "Having sex in a single position would not be enough for you both, however, and you pull her to the ground as you begin to actively slurp on her pleasure palace. She rewards your attention by doing the same, filling your [pussy] just perfectly with her tongue. However, you realise, both of you are still thirsty as she moves her head to your chest smiling with a lusty gaze, gently caressing your [breasts]. Of course her bite caused your breast to swiftly inflate with the telltale presence of milk.\n"
                    + "\n"
                    + "\"<i>Milk is highly nutritious too, I think I will take my share there as well. Thou can enjoy.</i>\"\n"
                    + "\n"
                    + "Before you know it, Diva kisses your areola and begins to gently suckle on your left teat. She has experience in this, as not only she nurses from you without effort, but she even manages to avoid piercing your nipples with her sharp canines. The feeling in your chest is delightful but she is not alone here to be hungry, so both of you switch position so you can have access to her shapely E-cup breasts and start suckling her.\n"
                    + "\n"
                    + "Diva moans in appreciation and grabs your other breast with her hand, squeezing and tweaking your nipples to your enjoyment.  The two of you are barely getting started as you slide her finger inside her already sopping wet cunt. Diva unplugs herself and smiles wide at your interest.\n"
                    + "\n"
                    + "\"<i>Want to proceed to step three?</i>\"\n"
                    + "\n"
                    + "Of course, you do, and fingering her to orgasm will be your pleasure. Diva gasps as you begin to play inside her wet cunt. She, however, won't leave you unattended, sliding her fingers straight to your [cunt] in order to equalise the score. You moan appreciatively of the attention and begin fingering her in earnest. You both pant in delight as you slowly finger each other to orgasm, your clear and sticky fluids splattering on your hands.\n"
                    + "\n"
                    + "Still, even after that, you continue having sex the whole night long. Time passes and the sun start to rise. You step away from the window, and she does the same.")
            } else {
                outputText("You gasp as her hand teases your already moistening fold. Diva suddenly kisses you. She feeds you a little of your own blood through the kiss, and while normally you would find the idea of tasting your own blood a complete turnoff, aroused and messed like you are by the aphrodisiac, it only gets you even more in the mood.\n"
                    + "\n"
                    + "You moan as she starts to slowly finger you, and you grab one of her breasts through her dark dress to return the favor. The vampire girl doesn't stop you, it seems she's as aroused as you are. You get under her skirt and insert your fingers in her pussy to return the favor, making her moan in delight. She moves her head to your chest, smiling with a lusty gaze as she gently caresses your breast. Strangely, the bite from earlier caused them to slowly inflate with milk while you weren't looking.\n"
                    + "\n"
                    + "\"<i>I think I will take my share here too. Thou can enjoy.</i>\""
                    + "\n"
                    + "Before you know it, Diva kisses your areola and begins to gently suckle on your left teat. She has experience in this, as not only she nurses from you without effort, but she even manages to avoid piercing your nipples with her sharp canines. The feeling in your chest is delightful and you let the vampire slowly empty you of your milk reserves, her expert hands slowly bringing you to the edge. You decide to help her out to by fingering her under her skirt, making her moan on your breast.\n"
                    + "\n"
                    + "Both of you are too busy to notice the time passing until suddenly the coming dawn pierces through a window. Her mouth regretfully moves away from your chest with a small pop as she breaks away from you.");
            }
            player.sexReward("vaginalFluids", "Vaginal");
            sharedEnd();
        }

        function sharedEnd():void {
            outputText("\n\n");
            if (fromCombat) {
                if (firstLoss)
                    outputText("\"<i>It's late and I ought to go before sunrise... thou welcome to come back some time again.</i>\"\n"
                        + "\n"
                        + "Diva jump off taking flight as she disappears through a trap door in the roof. You are a little dazed from the blood loss, but for some reason you still feel all right. She has even left an item for you.");
                else
                    outputText("Diva prepares to leave again but gives you a last kiss, making you blush, and hands you over what looks like a strange red vial before flying through a hole in the roof.");
                firstLoss = false;
				flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = consumables.VAMPBLD.id;
                cleanupAfterCombat();
            } else {
                outputText("Diva regretfully breaks the embrace before going back to her coffin. Strangely, you don't feel tired from mating with her all night long.");
                endEncounter();
            }
        }
    }

    private function shareAMeal():void {
        clearOutput();
        outputText("You offer to share a midnight meal with Diva - something the vampire immediately grins to.\n"
            + "\n"
            + "\"<i>Thou invite me to dine tonight? How galant.</i>\n\""
            + "\n"
            + "Both of you move in the darkness this night, looking for an easy meal. Not so surprisingly, the mountain range is full of minotaurs and a sleeping minotaur is indeed the first thing the pair of you find. Diva, having more experience than you in that domain, closes her wings around the minotaur's left arm, taking aim, and immediately goes for his carotid.\n"
            + "\n"
            + "The bull man wakes up, but it's too late for him to resist as Diva's naturally pleasurable embrace is already soothing him into submission. Truth be told, the raging boner of his bull cock is enough of a tell for anyone to figure how he feels about having his blood sucked. You proceed to settle on his right side biting his large collar for your own food source. The pair of you moans in delight at the taste of fresh warm blood flooding your mouthes while the minotaur's pleasure reaches its peak and his cock starts erupting cum like a fountain.\n"
            + "\n"
            + "Diva, considerate of your unwilling victim, gives him a handjob to keep his pleasure growing while she keeps sucking more and more of his blood, the minotaur's hips buck the air mechanically as he loses the control of his dick. Soon, the minotaur rolls back his eyes and falls unconscious. Whether it's from the blood loss or from the consecutive orgasm both of you have been forcefully inflicting on him, is unknown. Diva and you break out from the embrace for a long coppery kiss, exchanging blood and saliva.\n"
            + "\n"
            + "\"<i>Not the highest quality... I prefer yours, [name]. Still the feast is more enjoyable together than alone, don't you think?</i>\""
            + "\n"
            + "This carry on for the whole night, the pair of you making love and feasting on numerous consecutive victims at the same time. It's only outside on the prowl that you notice how gracefully and efficiently she hunts at night, her technique both at lovemaking and hunting is simply flawless. Both of you head back to camp, highly satiated, as the sun begins to rise again. Diva bids you good day as she heads to her tent and coffin. As for yourself, you think your job is done when you walk at day, skip the sleep this time around. Not so surprisingly, your nightly vampiric meal offsets this issue, granting you the energy to go without rest today.\n");
        player.sexReward("cum");
        endEncounter();
    }

    private function bloodyRose():void {
        clearOutput();
        outputText("You point out to Diva's tent, and both of you head in.\n"
            + "\n"
            + "Once inside, you give her a seductive gaze, putting your neck on display and removing your clothes. The vampire needs no further invitation as she tosses hers at the back of her tent before snuggling up to you, kissing your neck, and then bites in. The feeling of the blood running out of your neck is a delicious mix of pain and pleasure, arousing you to no end. In the delight of the moment you also bite Diva, tasting her blood. It never occurred to you before how powerful the link between both of you are when feeding from each other's necks... were you two any closer than that, you would be able to communicate through telepathy. You feel her pleasure through your neck as she can feel yours through her own.. or perhaps you both feel each other more clearly?\n"
            + "\n");
        sceneHunter.selectGender(dickF, vagF, null, null, 0);


        //====================================
        function dickF():void {
            outputText("Your [cock] begins to harden from the overstimulation of your sensible vampire neck and the excitement of blood. Diva's pussy seems to agree as she's practically wetting the ground below the pair of you. Giving in to your instinct, you slowly insert yourself in her like your fang in her neck as your increasingly hardening [cock] begins to pulse synchronously with your heartbeat. Her pussy reacts similarly to the penetration, she's more than ready to go.\n"
                + "\n"
                + "You both moan in each other's necks as you begin to hugfuck her. Diva's pussy is like a living creature, clenching strongly on your [cock] and pulsing as if to milk you dry. You, however, aren't going to simply lay back and let the devilish pussy do all the work as you begin to piston in and out of her. Diva's wings are flapping wildly behind her" + (player.wings.type == Wings.VAMPIRE ? ", yours too, and you try not to take flight as the winds created by your combined flapping start shaking the tent" : "") + ".\n"
                + "Both of you scream in ecstasy, breaking out of the bite, blood still dripping from your chin as you shoot your load in her greedy vagina" + (player.cumQ() >= 200 ? ", the excess dripping to the ground" : "") + ". Y");
            player.sexReward("vaginalFluids", "Dick");
            sharedEnd();
        }
        function vagF():void {
            outputText("You begin to feel more than blood oozing out of you - your  pussy lips are drooling and you can feel Diva's juices slowly running down your leg too. You are panting from the feeling in your neck, and you desire more. Diva wants it too, so on a common nod you get to step two, starting to grind your wet cunt against Diva's, moaning in each other's necks. Blood is good but blood and sex is simply divine.\n"
                + "\n"
                + "Your pussies are literally eating each others, seeking for a cock that is not there, as you feel your vagina pulse with delightful pleasure, every single nerve aflame. Both of you slide against each other for several minutes, never parting away as a constant fountain of female fluids runs down your respective legs.  Diva's wings are flapping wildly behind her" + (player.wings.type == Wings.VAMPIRE ? ", yours too, and you try not to take flight as the winds created by your combined flapping start shaking the tent" : "") + ".\n"
                + "\n"
                + "Both of you scream in ecstasy, breaking out of the bite, blood still dripping from your chin as you and Diva reach your orgasm. Unsatisfied, both of you keep at it for several hours. After about the sixth orgasm, y");
            cheatTime(2); //several hours :)
            player.sexReward("vaginalFluids", "Vaginal");
            sharedEnd();
        }
        function sharedEnd():void {
            outputText("ou start to doze off tired as Diva pulls you down in her coffin. You wake up in the morning, still in Diva's embrace. She's fast asleep but still wears a content smile.");
            endEncounter();
        }
    }

    public function encounter():void {
        clearOutput();
        spriteSelect(SpriteDb.s_diva);
        switch(instance.status) {
            case 0:
                outputText("You are taking a walk through the mountain area when, much to your annoyance, a thunderstorm begins. However, unlike the ones you hear of back home, this thunderstorm has no rain.. peculiar. Ever since you shut down the factory the weather has been erratically switching from clear to a full-fledged thunderstorm randomly. Deciding not to head back to camp yet, more out of spite than anything else, you seek shelter instead.\n"
                    + "\n"
                    + "Your efforts are rewarded when you spot a large abandoned castle atop a particularly steep hill. Thankfully, it's not so steep as to require climbing, since the regular lightning bolt would have made that a rather dangerous task, creating a risk of a rocky avalanche! As is, you manage to make your way to the front gate without much effort, at least not when compared to some other climbs you had to do on occasion while exploring this zone. The aforementioned massive wooden doors open to reveal a rather large vestibule, fitting for a castle this size. Sadly, there's no lighting.\n"
                    + "\n"
                    + "While you were expecting as much, since the castle did look abandoned and thus has probably been looted down to the bedrock already, it's still a bother. At least the chances of demons being here has gone down considerably, since it's unlikely one powerful enough to have gotten themselves night-vision worth a damn would stoop so low as to make their residence look abandoned just to get a cheap shot in. Something else with night vision making this their home, however, still remains a distinct possibility. So either spiders or bats, probably.\n"
                    + "\n"
                    + "The gate should make a good choke point, so you pick some debris as silently as you can and get back there, leaving it in a small pile by your side.\n"
                    + "You prepare your [weapon], square your shoulders and enter a combat-ready stance, then pick from the little pile of debris whatever looks like it will make the most noise. A metal scrap rusted beyond recognition will do nicely. Your pick made, you proceed to throw it as hard and far as you can into the castle's depths, ready for anything to jump at you. Nothing jumps out, which scratches out the possibility of anything feral living here, at least in this part of the castle. Sadly, with all the noise the storm is making, something could have been startled and, so long as it was far away enough, you wouldn't have heard it, and since nothing charged at you, it means that if that's the case, it's either an ambush or someone hiding.\n"
                    + "\n"
                    + "With an annoyed sigh, you move deeper into the castle, keeping an eye on your back and repeating the same tactic you used at the gate to check for possible traps or ambushes. As you go deeper, you start noticing something moving on the edges of your peripheral vision every now and this, coupled with the feeling of being watched, makes you increasingly paranoid. The fact that whatever or whoever it is makes no noise, or none that you can hear above the storm's, doesn't put you at ease either.\n"
                    + "\n"
                    + "You eventually find yourself in what you assume was used as a ballroom. As you move to the other end of it to check for anything worthwhile to loot (while you assume everything here has already been looted, you'll be stuck here until the storm eases, so you might as well try), the door suddenly slams shut behind you, followed by the familiar click of a lock.\n"
                    + "\n"
                    + "Between you and the door stands an odd woman, sporting a large leathery cape which covers her entire body. What little you can see of her looks surprisingly human, with her pointy ears being the single exception, then again, you have seen more than one demon use capes like that to “flash” others with their assets, so what she has under her neck is anyone's guess. Her smile reveals a pair of sharp canines as she announces her intentions.\n"
                    + "\n"
                    + "\"<i>Fufufufu... foolish mortal! Thou hast walked into mine trap! Abandon all hope of escaping mine castle unscathed, for I am Diva, the grand Countess of Dusk! " + (silly() ? "You were expecting Dio, but it was I, Diva! " : "") + "Prepare to forfeit thine blood and body to me! <b>TREMBLE BEFORE MINE POWER!</b></i>\"\n"
                    + "\n"
                    + "She opens her cape, or rather her pair of very large bat wings, and makes what you assume she thinks is a dramatic leap, diving toward you.");
                startCombat(new Diva);
                break;
            case 1:
                outputText("It doesn't take long before a thunderstorm, yet again, begins.\n"
                    + "If anyone had told you shutting down the factory would fuck up the weather this much, you would have had second thoughts before taking a wrench to that contol panel. Granted, you would probably have done so anyways, that fucking hellhole deserved no less. Anyhow, knowing the drill already, you march your ass back to Diva's castle.\n"
                    + "\n"
                    + "No sooner you enter that you can already feel movement on the edges of your peripheral vision. Diva is already stalking you, it seems. For one so arrogant and hungry for attention, she sure is good at stealth. However, as you expected, the power of drama compels her, so she won't be showing up until you get somewhere suitable for a dramatic fight. You steel your resolve and push down your exasperation as you decide to just bite the bullet and head to the ballroom already, otherwise she will just keep staring at your back from shadows like a lovestruck, socially awkward village girl for hours on end.\n");
                if (silly()) outputText("  Huh, you might be onto something. Is this that 'chuunibyou' thing the mechanic at the factory kept raving on about? He also said something about 'Senpais' noticing things and some creature called 'tsundere'.\n");
                outputText("\n"
                    + "Just as you get inside, a triggering mechanism makes itself known, as the doors lock themselves with a click. Huh, she got up to some tinkering between visits, it seems. Neat. You might ask her about how she pulled off that automatic lock trick after you finish the fight" + (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10 ? ", would be nice to have in your cabin" : "") + ". Diva, unwitting of your musings, appears in a cloud of smoke at the center of the room. She prepared some special effects, too. You would give a polite clap if you didn't know she would bitch at you for breaking the mood.\n"
                    + "\n"
                    + "\"<i>Fufufu... thine foolishness knows no bounds, coming yet again to try and defeat the almighty Countess of Dusk. Dost thou not comprehend such thing is an exercise in futility? No matter, I shall vanquish thee once again and take thy blood and body as mine, hero! Prepare for thy demise!</i>\"\n"
                    + "\n"
                    + "It takes all of your willpower to keep your palm from having an intimate reunion with its lover, your face. Let's get this over with before you accidentally sigh and hurt her feelings.");
                startCombat(new Diva);
                break;
            case 2:
                outputText("This time you don't even wait for a thunderstorm, you just head straight to Diva's castle for another match. Truth be told, you are beginning to get endeared to her, somewhat. Also, you don't begrudge having a good sparring partner, it's nice having someone strong to practice against without any real risks should you lose.\n"
                    + "\n"
                    + "Since there's no storm, Diva can't really sneak around as easily, since there is no thunder to drown out the sound of her movement, so for once you will have to find her yourself. It takes you about three seconds to guess that she will probably be cooped up in the highest tower of the castle. The boarded windows are a bit of a giveaway, to be honest. Now the question is whether she will be sleeping or waiting for you while sitting in the single gaudiest chair on the whole castle.\n"
                    + "\n"
                    + "You eventually reach the room, approaching whose gaudiness is nearing its critical mass, everything is covered in red and gold, the drapes, the carpet, the coffin and even the fuckhuge throne Diva is sitting in. Unsurprisingly, your guess was right. What you didn't expect, however is the deer-in-headlights look she is giving you. In that very moment you decide that you are going to learn, or make from scratch if you must, a spell to turn memories into pictures, then fucking frame this moment in the gaudiest frame you find in the castle.\n"
                    + "\n"
                    + "\"<i>Aaaah...so the prey fancies itself as a vampire hunter and dares come up to my very lair to slay me?! Thou shalt be found wanting for I will not go down easily! Prepare thyself, I shall not hold back this time!</i>\"\n"
                    + "\n"
                    + "And the drama queen fancies herself as a dungeon boss, doesn't she? Seems like either she just keeps away from the sun due to the power of drama compelling her, or she is more powerful than you initially thought.\n"
                    + "\n"
                    + "\"<i>Enough! Cease this foolishness and surrender thine blood and body to me!</i>\"\n"
                    + "\n"
                    + "She throws a glass cup filled with what's probably blood to the ground, in what you assume she thinks is an elegant way, as she takes flight, in as much as she can while indoors, high ceilings or not. Aaaaaaand she has gotten herself a battle aura of darkness, of course she has. " + (silly() ? "Such is life in the zon- Mareth. " : "") + "But seriously, she is clearly stronger now. Well, it seems she is not holding back this time around.");
                startCombat(new Diva(true));
                break;
        }
    }

    public function defeatedFirstSecond():void {
        clearOutput();
        if (player.isGargoyle() || player.isAlraune()) {
            outputText("You fall to the ground unable to fight further as Diva declare.\n"
                + "\n"
                + "\"<i>Look, I will be honest with thee, thou are completely inedible! Do me a favor and get out. I’m not interested in something I can’t drink from.</i>\"\n"
                + "\n"
                + "Well, you can’t believe your luck. Guess, you might as well get going.");
        } else {
            outputText("\"<i>Wait, that wasn’t in the script! The hero was supposed to lose to the almighty vampire, be bitten, know love, marry, have children... no no no no and NO!</i>\"\n"
                + "\n"
                + "Is she for real... Does she really think this all was an elaborate play with her as the main character of some romance story?\n"
                + "\n"
                + "She takes on an annoyed expression then declares <i>“Cough cough... ahem..Oh how terrible, I, the almighty queen of darkness lost to the hero! What will happen of me, will thy hero rape me and make me his bride by force or will I be left alone in this castle as [he] goes on for a new quest.“</i>\n"
                + "\n"
                + "Tired of her nonsense, you decide to give her exactly what she asked for, but the girl screams a spell that clearly doesn’t exist and disappears in a cloud of smoke from what is obviously a smoke bomb leaving one last warning.\n"
                + "\n"
                + "\"<i>I shall have my vengeance hero for I am the immortal invincible night terror Diva and believe me, I shall never be defeated again by the likes of thou!</i>\"\n"
                + "\n"
                + "It’s only when the smoke disappears that you notice a trap door under the carpet where she was standing. When you try to open it you discover it’s locked. You decide to head back to camp before the weird bat woman show up again.");
            DivaScene.instance.status++;
        }
        cleanupAfterCombat();
    }

    public function defeatedFinalFight():void {
        clearOutput();
        outputText("Diva recoils defeated and falls to the ground on her knee.\n"
            + "\n"
            + "\"<i>Thou are strong… defeating me despite the fact I was at my prime.\n"
            + "I would please ask mercy from thee for I have been drinking your blood out of love with thou and would like to become yours if thou would allow it.\n"
            + "Would thou be my " + player.mf("knight", "knightess") + "?</i>\"\n"
            + "\n"
            + "Do you declare mutual love?");
        menu();
        addButton(0, "Yes", finalChoice, 0);
        addButton(1, "No", finalChoice, 1);
        addButton(2, "Never", finalChoice, 2);
    }

    public function finalChoice(choice:int):void {
        clearOutput();
        if (choice == 0) {
            status = -1;
            outputText(" She's a good girl, despite her excessive love for acting.\n"
                + "You decide to bring her with you back to camp declaring your love for her.\n"
                + "Diva nods and, still blushing, she gathers a few important item namely a tent and her coffin.\n"
                + "You ask her why she's so keen on bringing a coffin with her anyway, can’t she just sleep in a bedroll like everyone else?\n"
                + "\n"
                + "\"<i>Proper lords only sleep in coffins, I would not have it any other way. As for the tent, thou may have figured, I dislike bright light.</i>\"\n"
                + "\n"
                + "You shrug and just help her carry the heavy thing back to camp <if test=\"player.str lt 40\">although Diva with her unholy strength still do most of the work</if>.\n"
                + "She settles not so far from you, under the shade of a dead tree.\n"
                + "She sets up the tent then installs the coffin inside.\n"
                + "She works all night and by the time she's done dawn is about to break.\n"
                + "She yawns, tired.\n"
                + "\n"
                + "\"<i>I bid thee a good day for I must rest now. Should thou want to see me just wake me up or call my name after sunset.</i>\"\n"
                + "\n"
                + "On these words she enters the tent and heads to sleep.");
            outputText("\n\n<b>Before leaving for your camp, as if remembering something, Diva pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
            if (player.hasKeyItem("Radiant shard") >= 0) {
                player.addKeyValue("Radiant shard", 1, +1);
            }
        } else if (choice == 1) {
            outputText("You will think about it but for now you decide to leave.\n"
                + "You guess you will likely need to fight her again and redo her silly play should you want to voice a different choice.\n"
                + "In the background you can hear Diva pestering angry about something wrong in the script.");
        } else {
            status = -2;
            outputText("No, you're sick of the games of this bloodsucker. herefore you decide to leave, heading back to camp, and never come back.");
        }
        cleanupAfterCombat();
    }



    public function DivaPregAnnouncement():void {
        clearOutput();
        outputText("The moon shines bright on your camp. As you enter, you feel wind on your back. You turn…But there’s nothing there. You swore you felt something…Shrugging, you turn back around, heading towards your cabin, when you feel that same gust, but stronger. You spin, trying to catch the person you know is behind you, but by the time you turn around, they’re already gone.  \n\n");
        outputText("Between the late hour, and the disappearing act, you’re pretty sure you know who’s messing with you, but you aren’t really in the mood for any shenanigans. You head into your [cabin], and lie on your [bed], waiting. The night around you darkens, and you feel your eyes closing… \n\n");
        outputText("No. You force your eyes open, and you catch a glimpse of Diva, ever the drama queen, floating above you. Despite her usual dramatic nature, however, you notice that she has a serious look on her face, red eyes wide.  \n\n");
        outputText("“My love, forgive mine intrusion…I must speak with you, urgently.”  \n\n");
        outputText("Slightly annoyed, you sit up, and yawning, ask Diva to explain what she’s doing in your [cabin]. You ask her to stop hovering around your head, and sit with you.  \n\n");
        outputText("“O-of course. Looking down upon thou…Tis inappropriate, here.” Diva sits in front of you, fidgeting nervously. You sigh, telling her to get on with it.  \n\n");
        outputText("“...Dost thou remember…What mine motivation was, for our battle?” She asks, both hands gripping her dress. “When thou defeated me in combat, what mine utterance was?”  \n\n");
        outputText("Blinking, you think back, recalling that Diva had mentioned something about “Knowing Love”, “being bitten by the great vampire”, blah blah. Like she wanted to whisk you away, marry you, have kids…Oh.  \n\n");
        outputText("“...Thou hast loved me, [name]. And in that love…Something wondrous has occurred.” Diva looks at you, her eyes wet with unshed tears. “While thou and me…Our relationship hast been so different from what I’d envisioned, one thing hast held true.” She takes your hands, looking deep into your eyes. “Thine seed hast taken root inside me, and the night will be less empty.” \n\n");
        outputText("Diva seems…Happy. Very happy… \n\n");
        outputText("A sudden image pops, unbidden, into your head. Diva, screaming her superiority into the night, surrounded by little copies of her, all parroting her cheesy lines and picking overly dramatic fights with random people. While the thought is funny, borderline hilarious, the aftermath of having more than one Diva running around?! Just the thought is giving you a headache.  \n\n");
        outputText("You take Diva’s hands in yours, and promise that you’ll be there for her, and your children. Diva, giddy, begins floating again, forcing you to gently pull her back down to earth. Thankfully, she doesn’t understand WHY you’re supporting her. Hopefully you can help your little ones not be as delusional as their mother. \n\n");
        //if you've done the lab dungeon
        outputText("Not that you can blame her, really. Considering everything she went through…maybe you can give her more of her fairy-tale ending than you thought.  \n\n");
        //split end
        outputText("You pull Diva into a warm embrace, and you can feel a single droplet hit your back. Diva sniffles, and gives you a rib-creaking hug. After a few moments, she pulls back, having regained her composure.  \n\n");
        outputText("“...My love…Thank you.” Diva drops her affected accent, her red eyes and rigid demeanour softening, a light behind her eyes appears, one you haven’t seen before. “Th…You don’t know how happy you hast…have made me.” She blinks. “I-I…” The light fades, her eyes returning to their usual flat red. “Thine love is a blessing in this dark heart of mine.” Her bearing returns to her usual regal facade. “I shall see you later tonight, I hope.” She leaves you to your devices, heading out of camp to hunt. \n\n");
        doNext(playerMenu);
    }

    public function DivaPregProgression1():void {
        clearOutput();
        outputText("Diva sits on top of her coffin, drinking a goblet full of blood. Unlike her usual dainty sipping, she opens her mouth, pouring the stuff down her throat. You notice that she seems…a little thirstier than usual. Apparently eating more during pregnancy extends to Diva as well. She sees you looking at her, and she raises one eyebrow.  \n\n");
        outputText("“Hast thou not seen a woman with child sating herself before?” She asks, before turning her back and flying out of camp.  \n\n");
        doNext(playerMenu);
    }

    public function DivaPregProgression2():void {
        clearOutput();
        outputText("As you get back to camp, you find Diva pacing, muttering angrily to herself. “Fate plays cruel jokes. The one time thou seeketh [name]’s company, thine searches in vain.” Her fangs are out, and despite the bloodstains on her fangs, she’s clearly hungry…Wait, was she looking to feed from you? You’ve heard of pregnant women having odd cravings, but this?! \n\n");
        //if you don't have blood she'll drink
        outputText("Wait…Did Diva forget that you don’t have blood that she’d drink? Such a weird situation…Poor woman.\n\n");
        menu();
        addButton (1, "SneakOut", DivaPregCravingsNope);
        addButton (2, "Feed", DivaPregCravingsAccept); //Only if you have blood Diva would drink
    }

    public function DivaPregCravingsNope():void {
        clearOutput();
        outputText("Nope. Whatever Diva’s going through right now, you have no intention of joining in on it. You sneak back out of camp for a few hours. By the time you return, Diva’s gone. You see that there’s a broken wine glass, thrown at the entrance to your (cabin/tent). You look around, hoping nobody’s seen it, before gently scraping the glass up and disposing of it.   \n\n");
        doNext(playerMenu);
    }

    public function DivaPregCravingsAccept():void {
        clearOutput();
        outputText("You told Diva you’d support her through this…No sense backing out on your word now. You approach Diva, asking her what’s wrong.  \n\n");
        outputText("“What’s…Wrong?” She tilts her head, throwing her hands into the air. “Thou hast the…the nerve? Thou art RESPONSIBLE!” She stalks toward you, and sighing, you let her approach. Her red eyes are angry, but as she reaches out, you wrap your arms around your delusional draculina, kissing her on the neck.  \n\n");
        outputText("“Wh-what?” Diva flails, but you hold on tight. You put a hand on the back of your pregnant vampiress’s head, keeping her jaw gently pinned between your shoulder and head, and you whisper into her ear, stroking her hair. After a few moments, she calms down a little, and you ask again, what seems to be wrong.  \n\n");
        outputText("“...Everything dost taste like ash in mine mouth”. Diva’s on the verge of tears. “None of the blood I sample appeal to mine taste, yet I hunger.” You feel her tremble. “I hunger…so very much.” \n\n");
        outputText("You ask her what she’s tried, and she lists off a few species, then starts to cry again. “But when I think of thou, my fangs…They grow, my stomach growls…and I…I…” You hold her at arm’s length, and her lower lip wobbles, red eyes wide. “Tis you I crave, more than any other.” She looks down at her stomach. “Forgive me, my (lord/lady)…But…I must feed…For them.”  \n\n");
        outputText("You sigh, telling Diva that you had seen her pacing. Now that you know the problem, you can help. You motion to your (cabin/tent), telling Diva to come on, she can join you inside \n\n");
        outputText("“Art…Thou sure? Thine face danger every day…And I…Need much.” Now that she’s with you, Diva seems rather apprehensive, despite the clearly predatory glances she’s giving your neck. You remind Diva that you promised to be there for her. Besides, you wouldn’t mind some private time with her anyways.  \n\n");
        outputText("This gets a genuine smile from Diva, who gives you an elegant curtsey. “Lead on, my (Lord/Lady).”  \n\n");
        outputText("Inside your [cabin], you begin to undress, and Diva sits on your [bed], folding her cape and placing it beside. She removes her broach and bow, letting her long blonde hair down. Noticing that you’re done, she puts a smooth, pale hand on your shoulder. “Would thou…assist me with mine dress?” You nod, and she turns her back to you. You gently untie the lacy threads holding Diva’s dress up, and let the garment slide to the floor with an oddly loud thump. Diva turns on one foot, takes your hand, and steps out of the discarded garment.  \n\n");
        outputText("She looks (if less than 5’6) down (if 5’6) across (if taller) up into your eyes, fangs sticking over her bottom lips. There’s only the tiniest bump on her stomach, and she notices your attention, she covers her stomach with her arm, blushing and looking away. Her perfectly smooth, pale skin practically glows in the darkness, and you take her cheek in one palm, guiding her to look at you.  \n\n");
        outputText("Without her fancy dress, constant noble-speech nattering, or display of her strength, Diva looks far more vulnerable than you’ve ever seen her. She’s practically drooling from the corner of her mouth, eyes drawn to your neck, but she’s forcing herself to look into your eyes.  \n\n");
        outputText("You take her hand, the one she’s covering her stomach with, and gently pull it away. Spreading your fingers, you rest your hand on her belly, getting a shudder from your expectant lover.  \n\n");
        outputText("“M-may I feed?” She asks, and you lean in, wrapping your other arm around her waist, her smooth, pale ass just below your hand. You kiss her on the forehead, telling her to go ahead.  \n\n");
        outputText("Hesitantly, as if testing, she leans in, and you feel her teeth scrape your [skin]. Slowly, she sinks her teeth in, letting out an almost orgasmic moan as she does so. You feel her tongue lap at the wounds, heat spreading from the bites in waves. Diva closes her eyes, and you pull her in. With every pull of blood, every lap of her tongue, Diva lets out another moan.  \n\n");
        outputText("You can feel her body draining of all tension, the curvy draculina practically melting into your arms as she greedily laps at your neck. Oddly, you don’t feel drained at all, or anything but an odd, relaxed heat…That has nothing to do with sex.  \n\n");
        outputText("More and more of Diva’s weight rests upon you, until you’re practically carrying her. Finally, you decide to lower yourselves to the [bed], holding her head and waist. Diva’s barely responsive, eyes closed and body slack as she continues to feed.  \n\n");
        outputText("You shift, getting as comfortable as you can with Diva’s fangs still in your neck. You’re holding her breasts to yours, one of her legs draped over your [legs]. You feel her arms and wings wrap around you, and you sigh, finally starting to feel a little drained, but Diva’s heartbeat, the fluffy bat wings, and the delightfully sexy figure of Diva cuddling up to you like this more than make up for it.  \n\n");
        outputText("“Mmm…” Diva moans, and you can feel her fangs leave your neck. She pulls her head back, and her eyes shine with emotion. She leans in, and your lips meet, her mouth surprisingly sweet. You run your hand through her hair, and Diva nuzzles your hand, shivering slightly in your arms.  \n\n");
        outputText("“Thank you.” Diva says simply. The noble accent she usually puts on is gone again. “Thank you…for everything.”  \n\n");
        outputText("Running a hand from her cheek, down the side of her neck, you tell Diva that she doesn’t need to thank you, and she puts a finger over your mouth. “Shh…” She slides up until she’s firmly in your lap, gently touching the place where she’d fed from you. “Just…Hold me close. Hold me until morning.”  \n\n");
        outputText("Diva rests her head against your [chest], and you follow her lead as she entwines her legs with yours, lying down with you. Pulling the covers over you, her head resting on your shoulder, you just hold your expecting draculina close. \n\n");
        outputText("Slowly, you let your eyes close, Diva’s shallow breathing the only sound in your ears. As you drift off, you hear a sleepy giggle, and Diva’s lips against your ear.  \n\n");
        outputText("“Mine.” \n\n");
        outputText("You wake to the sound of a crow’s caw. Opening your eyes, you can still feel the soft warmth of Diva next to you, head on your [chest] and one of her soft palms underneath your head. You can feel her stomach pressed against you, and as you shift yourself slightly, she opens one eye, rolling her head to look at your face. \n\n");
        outputText("“Good morning.” Diva says simply, no trace of her usual aristocratic accent. “I hope you slept well.” \n\n");
        outputText("You ask her if she’s still hungry, and she shakes her head. “No. You fed me plenty last night.” Diva smiles lazily, patting her stomach. “Your blood was what they needed, apparently.” You ask her about the rest of the night. Didn’t she need to hunt? You know she doesn’t do well in the day. \n\n");
        outputText("“I’ll be fine.” Diva says slowly, lazily. She stretches one of her bat wings, throwing the blankets off you, but doesn’t move further, apparently not willing to roll over and stretch the other. “I can still somewhat function in the daylight.” She opens her eyes, realising that she’s completely nude, and in your bed. Eyes wide, she suddenly bolts up, looking for her dress. As she sees it, you take her hands, asking her what the problem is. Her wings unfurl, and she begins to breathe heavily, starting to shake. You let go, and Diva runs over to her discarded dress, slipping it over her head. As it settles, she slips her arms in, hugging herself tightly.  \n\n");
        outputText("Standing, curious as to this…odd behavior, you get up and slowly move towards the clearly distressed Diva. Calmly, you ask her what’s wrong, and she looks at you, blinking twice. \n\n");
        outputText("You groan, oddly stiff, but as Diva turns her back, you lace up the back of her dress. She seems…oddly nervous until her dress is completely laced up, and you hear a barely audible sigh of relief from Diva as she turns around to face you again. She draws herself up into her usual haughty stance, covering her mouth as she yawns. “Despite our…Relaxing evening, Mine vigour is still diminished.” She dons her cape, then gently leans against you. “Wouldst thou walk with me, so far as mine coffin?”  \n\n");
        outputText("You nod, and exit your [cabin] with Diva. The walk is slow, but as Diva opens her coffin, she looks back wistfully past you, at the rising sun.  \n\n");
        outputText("“How beautiful the light…That mine body hast forsaken.” Her eyes come back to you, and she smiles. “And so art thou.” She closes the coffin, locking it from within.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
//set the time to the next day, at 7:00
        doNext(playerMenu);
    }

    public function DivaPregProgression3():void {
        clearOutput();
        outputText("Diva’s pregnancy is showing, only a little more than before. Some women don’t show pregnancy much, and Diva seems to be one of those…either that, or it’s the dress. Dive sees you looking, and she flies over, clearly happy to see you.  \n\n");
        outputText("“My (Lord/Lady), how fortunate thou hast come!” Diva’s beaming from ear to ear. “Our child will come soon. I can…I can feel them kick.” She literally floats in a circle around you, hands clasped together. “I can hardly wait to hold our little one.” Diva kisses you on the top of your head, before floating away.  \n\n");
        outputText("Huh…That was odd. \n\n");
        doNext(playerMenu);
    }

}
}
