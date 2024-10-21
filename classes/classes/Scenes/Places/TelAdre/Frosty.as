package classes.Scenes.Places.TelAdre {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class Frosty extends TelAdreAbstractContent {
    //[Deciding to talk to her]
    public function approachFrosty():void {
        clearOutput();
        if (flags[kFLAGS.MET_FROSTY] == 0) {
            flags[kFLAGS.MET_FROSTY] = 1;
            outputText("You approach the pink girl and as she sees you walking towards her, she immediately makes a beeline for you. Before you know it, the girl is right in front of you, jamming one of her fliers right in your face and speaking fast and hyperactivily to you. \"<i>Hello " + player.mf("sir", "madam") + ", would you like to come to ‘Frosty Cake’s Cupcake stand’? I’m Frosty- Nice to meet you- I recently opened a sweets-stand and can’t wait to have loyal customers such as you coming to my stand every day and buying all kinds of super delicious cupcakes!\"</i> You have to take a step back to process everything she just blurted out; you also take the flyer from her just so she stops pushing it against your face. \"<i>So do you wanna come to my stand, do ya, do ya, do ya!?</i>\" You answer her with an uncertain \"<i>yes</i>\", still wondering what she just said.");
            outputText("\n\nHowever, you can’t think for long as she grabs you by the hand to lead and whisk you out the front door of the bakery and to her food-stand that is just outside. It’s a tiny little booth, decorated in bright happy colors and streamers. A sign on the front reads:\n<i>\"Frosty Cake’s Cupcake Stand!!!!\"</i> in a bubbly rainbow colored chalk writing. She positions you right in front of it and jumps over the counter to the cashier side of it. \"<i>Hello customer, how may I help you? My first customer!</i>\" The last part comes out as a whispered squeal that doesn't do much to hide her excitement.");
            outputText("\n\nYou both share a moment of silence, her big pink eyes looking at you with a hopeful smile, then she looks down at the counter and sees that it's empty.  Letting out a little \"eep\" she quickly ducks down under the counter, coming back up with a bunch of silver platter displays with glass lids, so you can see the tasty cupcakes on the inside, and in a blur the displays are organized right in front of you. All sorts of cupcakes are displayed with various frostings, toppings, colorful wrappings and all different kinds of flavors. Your mouth is just watering as your eyes wander across this colorful display of cupcakes but quickly dries up as your gaze comes to rest upon the pricing for these delicacies.");
            outputText("\n\n\"<i>30 GEMS A CUPCAKE!!!</i>\" Your shock causes you to yell this outrageous price out loud.");

            outputText("\n\n\"<i>Well duh-</i>\" she crosses her eyes with that last word. \"<i>-how else do you think the bakery would let someone run a stand outside their store, I give them 10% of my profits and they let me run this booth.</i>\" Her explanation still makes you uncertain whether you should buy a cupcake or not and it shows like marker written across your face. She sees your look of uncertainty and now looks a bit hurt at your hesitance, but she does see where you’re coming from.");
            outputText("\n\n\"<i>Well, " + player.mf("sir", "madam") + ", I was thinking of a new business plan last night. You could... be a... beta tester for it. All you have to do is sign these agreement papers.</i>\"");

            outputText("\n\nShe recklessly makes room on the counter to drop down a huge stack of papers with a loud pound and, with a flick of her wrist, a pen appears in her hand, being held up to your face with zeal. Whoa whoa whoa, you at least would like to know what you’re getting into before you sign any piece of paper.");
            outputText("\n\n\"<i>To be simple: You get to fuck me.</i>\"");

            outputText("\n\nWith how bluntly she said that you probably would have spat a mouthful of water if you had some. How could she be so comfortable with that idea and seem so innocent too.");
            outputText("\n\n\"<i>Oh you couldn’t tell?  I’m a Nymph.</i>\"");

            outputText("\n\nShe brushes her big pink hair to the back of her ear and you can see it’s long and pointed.");

            outputText("\n\n\"<i>I’m surprised you couldn’t tell earlier, look at me, I'm just so adorable.</i>\"");

            outputText("\n\nShe stands up to show off her \"adorable\" features. The cupcake hat didn’t make you see her as someone who was interested, or even knew, about sex but now that she’s giving you a display of her \"sweets\" you can see past the ridiculous thing now. She wears short-heeled sandals that lend a little swag to her step, her legs are long and elegant like a ballerina’s. She does a little twirl and you get a quick glance at her gum pink bubble butt. Your gaze wanders up across her toned stomach and stops at her breasts; they look like two pink melons hanging comfortably in a hammock.");

            outputText("\n\n\"<i>Do we have a deal?</i>\" She waves a hand next to her breast to bring your attention back to her face.");
            menu();
            addButton(0, "Yes", yesFrostyLetsHaveSexForCupcakesWhoThoughtThisWasAGoodIdeaIMeanSeriously);
            addButton(1, "No", noContractForMeSloot);
        } else {
            outputText("You go out to Frosty’s stand; she’s there manning it with a huge smile on her face. \"<i>Hello there customer, how may I help you?</i>\" You greet her with your own smile and hello and take a look at her menu:\n");
            outputText("1. Cupcake x 1 = 15gems\n");
            outputText("2. Cupcake x 5 = 60gems\n");
            outputText("3. Cupcakes x 10 = 110gems\n");
            outputText("4. Cupcakes x 20 = 200gems\n");
            outputText("\nAt least they go down in price if you buy in bulk, that or she’s bad at math.");
            frostyMainMenu();
        }
    }

    public function frostyMainMenu():void {
        //Original prices, lol
        /*Specials
        Cunnalings - 1pt.
        Anal - 10pt.
        Spankings - 100pt
        Party - 500pt*/
        menu();
        addButton(0, "x1", cupcakeBuy, 1).disableIf(player.gems < 15, "Not enough gems (15)!");
        addButton(1, "x5", cupcakeBuy, 5).disableIf(player.gems < 60, "Not enough gems (60)!");
        addButton(2, "x10", cupcakeBuy, 10).disableIf(player.gems < 110, "Not enough gems (110)!");
        addButton(3, "x20", cupcakeBuy, 20).disableIf(player.gems < 200, "Not enough gems (200)!");
        if (flags[kFLAGS.SIGNED_FROSTYS_CONTRACT] == 0) addButton(8, "Contract", getAFuckingFuckContractFromFucks);
        else addButton(8, "Specials", frostysLimitedSpecialMenu);
        addButton(14, "Leave", SceneLib.telAdre.telAdreMenu);

    }

    public function frostySpecialsMenu(free:Boolean = false):void {
        if (free) outputText("\n\n\"<i>Only one service is available as a free sample!</i>\" she smiles, pointing at the first item.");
        menu();
        addButton(0, "Hand", frostysHandsAreColdHolyShitWhyDontYouWarmTHoseMitsUp).disableIf(flags[kFLAGS.FROSTY_POINTS] < 5, "Not enough points (5)!");
        addButton(1, "Mouth", useFrostysMouth).disableIf(flags[kFLAGS.FROSTY_POINTS] < 15, "Not enough points (15)!");
        addButton(2, "Ass", analWithACupcakeSloot).disableIf(flags[kFLAGS.FROSTY_POINTS] < 30, "Not enough points (30)!");
        addButton(3, "Spanking", frostySpanking)
            .disableIf(flags[kFLAGS.FROSTY_TIMES_SPANKED] == 0 && flags[kFLAGS.FROSTY_POINTS] < 100, "Not enough points (100)!")
            .disableIf(flags[kFLAGS.FROSTY_TIMES_SPANKED] > 0 && flags[kFLAGS.FROSTY_POINTS] < 200, "Not enough points (200)!");
        addButton(4, "EatHerOut", cunnilingateFrosty).disableIf(!free && flags[kFLAGS.FROSTY_POINTS] < 1, "Not enough points (1)!");
        addButton(14, "Back", approachFrosty);
    }

    public function cupcakeBuy(arg:int = 1):void {
        clearOutput();
        outputText("You make your purchase and swiftly devour the cupcakes. They're surprisingly delicious!");
        if (arg == 1) player.gems -= 15;
        if (arg == 5) player.gems -= 60;
        if (arg == 10) player.gems -= 110;
        if (arg == 20) player.gems -= 200;
        if (flags[kFLAGS.SIGNED_FROSTYS_CONTRACT]) frostyPoints(arg);
        player.refillHunger(5 * arg);
        menu();
        addButton(0, "Next", approachFrosty);
    }

    //[Yes]
    public function yesFrostyLetsHaveSexForCupcakesWhoThoughtThisWasAGoodIdeaIMeanSeriously():void {
        clearOutput();
        flags[kFLAGS.SIGNED_FROSTYS_CONTRACT] = 1;
        outputText("Being rewarded with sex for buying cupcakes, what could be better? You take the pen from Frosty’s hand and ask where to sign. She lets out a joyful \"<i>YAY!</i>\" and does a little jump in the air. She zooms back behind the stand and points at the lines where your name, last name, initials, date of birth, mother’s maiden name and even your pet's name should be written. You sign all these areas until you’re finally on the last page of the contract. Thank goodness too, your hand is beginning to cramp up. You put the pen down and rub your wrist. Frosty spins the stack a 180° with the tip of her finger, does a quick flipping through the papers, nods her head, puts the stack in a lock-box under the counter and pops back up.");
        outputText("\n\n\"<i>Congratulations! You are now a beta tester in Frosty’s \"Sweets and Sex\" program. Here are the basics:\n1. You get a 20% discount on all final purchases.\n2. You get a point for each cupcake you buy.\n3. You can use these points to buy from my \"special\" menu.\n4. What points you use are, of course, subtracted from your total of points.\nThat’s all ya need to know, can’t wait to see you around to buy some tasty cupcakes and maybe give me a creampie!</i>\" She gives you a wink as you walk away, hoping you know what you got yourself into. Before you get too far, you hear Frosty calling your name. You turn around and see her running up to you, waving an arm out.");
        outputText("\n\n\"<i>I forgot to mention, customers who join the </i>beta<i> got one free sample of my services but the offer is only good right after you join... so right now.</i>\"");
        outputText("\n\nDo you accept?");
        menu();
        addButton(0, "Yes", yesIWantYourFreeSampleYouFuckingDiseasedCupcakeSlut);
        addButton(1, "No", noIDontWantAFreebieDiseaseYouSlut);
    }

    //[Yes]
    public function yesIWantYourFreeSampleYouFuckingDiseasedCupcakeSlut():void {
        clearOutput();
        outputText("You follow Frosty to her booth. She goes behind the counter and spins the menu with her fingertip and stops it with the palm of her hand. She goes back to her business while you look over the menu.  The lettering and style of it has changed into something more appealing and seductive.");
        //[Specials Menu is shown]
        frostySpecialsMenu(true);
    }

    //[No]
    public function noIDontWantAFreebieDiseaseYouSlut():void {
        clearOutput();
        outputText("You’re too busy right now, so you deny the free service. \"<i>Okeydokey, see you around, [name]!</i>\" Frosty does a twirl on one foot and runs back to her stand. Such a nice girl.");
        menu();
        addButton(0, "Next", SceneLib.telAdre.telAdreMenu);
    }

    //[No](for the contract)
    public function noContractForMeSloot():void {
        clearOutput();
        outputText("Something about signing a contract doesn’t seem right to you, especially one for cupcakes. You shake your head no; she looks a bit sad about being rejected but quickly perks back up.");
        outputText("\n\n\"<i>Well, you can still buy my tasty cupcakes. You just won’t get any perks for buying them, but eating them is a benefit in its own way. Join the BETA if you change your mind on the whole thing.</i>\"");
        outputText("\n\nYou nod at her suggestion and make your way back to the main street.");
        menu();
        addButton(0, "Next", SceneLib.telAdre.telAdreMenu);
    }

    //[Contract](If player hasn’t signed)
    public function getAFuckingFuckContractFromFucks():void {
        clearOutput();
        outputText("Frosty zooms around the counter, appearing next to you like a pink blur \"<i>OH! You changed your mind!?</i>\" she asks excitedly with her hands held up to her face like she’s praying.");
        //[Yes [No]
        //[Yes]
        //[Go to the \"Yes\" section when offered the contract the first time.]
        menu();
        addButton(0, "Yes", yesFrostyLetsHaveSexForCupcakesWhoThoughtThisWasAGoodIdeaIMeanSeriously);
        addButton(1, "No", noIDontWantToSignYourFuckingContractGoddamned);
    }

    //[No]
    public function noIDontWantToSignYourFuckingContractGoddamned():void {
        clearOutput();
        outputText("Frosty lets out a discouraged \"<i>Oh</i>\" and slowly walks back to her side of the counter.");
        //[Back at Frosty’s Main menu]
        frostyMainMenu();
    }

    //[Specials](If the player has signed the contract)
    public function frostysLimitedSpecialMenu():void {
        clearOutput();
        outputText("Frosty spins the menu with a fingertip and stops it with the palm of her hand. She goes back to her business while you look over the menu.  The lettering and style of it has changed into something more appealing and seductive:\n\n"
            + "1. Hand – 5 points\n"
            + "2. Mouth - 15 points\n"
            + "3. Ass - 30 points\n"
            + "<i>4. Spank - 100 points</i>\n"
            + "SPECIAL: Eat Me Out - 1 point\n\n<b>Current points: " + frostyPoints() + "</b>");
        frostySpecialsMenu();
    }

    private function frostyPoints(arg:int = 0):int {
        if (arg == 0) return flags[kFLAGS.FROSTY_POINTS];
        //If any change, add it in.
        flags[kFLAGS.FROSTY_POINTS] += arg;
        //Make sure it aint negative
        if (flags[kFLAGS.FROSTY_POINTS] < 0) flags[kFLAGS.FROSTY_POINTS] = 0;
        return flags[kFLAGS.FROSTY_POINTS];
    }

    //hands
    public function frostysHandsAreColdHolyShitWhyDontYouWarmTHoseMitsUp():void {
        clearOutput();
        if (player.isGenderless()) genderlessCatchAllForFrosty();
        else sceneHunter.selectGender(dickF, vagF, null, hermF);

        //======================================================================
        function dickF():void {
            outputText("\"<i>Okay, one tug-and-pull comin' right up.</i>\" she giggles at her own name for a hand-job and ducks under the table, pulling up a big, fancy, cushioned chair that looks like it belongs to a noble. It barely fits in the tiny space under her booth. She throws the chair right next to her stand and it lands perfectly, hardly making a sound. In one moment Frosty disappears and reappears on the chair, sitting on its arm and waving her hand over to the seat, gesturing for you to sit. You follow her gesture and take a seat in the comfy chair. Just sitting there makes you feel like the ruler of a land. Placing your arms on the armrests, you feel like a boss.");
            outputText("\n\nYou didn’t even that notice Frosty has moved from the armrest and is now on her knees at level with your groin, her hands rubbing together, making a suggestive sound of rubbing flesh.");
            outputText("\n\n\"♪<i>As soon as I get my syrup rubbed all over my hands, we’ll begin.</i>♪\"");

            outputText("\n\nSyrup? Isn’t that stuff sticky, like, glue sticky? This isn’t what you had in mind when you thought of having a nymph glued to your cock. Frosty giggles like she can hear this thought going through your head. She explains that this syrup holds the \"sugary goodness, gooeyness, and warmth\" of regular syrup but is just a \"little tiny smidge\" sticky. Your minds slows down as she reassures you that this will not glue her hand to your cock. Her sticky hands fiddle with your [armor] and soon your [cock biggest] drops free, flaccid right now as you’re not too sure about this crazy nymph.");
            outputText("\n\n\"<i>Oh come, on Cocky, don’t be shy. I wanna see you get hard just for me.</i>\"");
            outputText("\n\nShe wraps her sticky fingers around your cock; the syrup on them is as warm as the desert sun, slick like a cunt and her grip is as tight as a virgin’s slit. Each finger takes a turn to squeeze down on your member like she is playing a flute, a cock flute. She even makes a musical \"doo-dah-lee-do\" sound as she continues to \"play\" her song. Your cock begins hardening in her hand, pushing against her grip, making you feel like your growing cock is being choked by a leather strap.");
            outputText("\n\n Only when it’s fully erect does she release you, strands of the syrup still connecting her fingers to the shaft of your [cock biggest]. She stares at her \"handy\" work and watches it pulsing and throbbing, just asking for her to give it the release it wants so much. She makes a little giggle, amused by your involuntary actions.");
            outputText("\n\n\"<i>Ooooh, your ");
            if (player.biggestCockLength() < 7) outputText("little");
            else outputText("big");
            outputText(" friend is just waiting for me to milk his cream out. Tee-hee.</i>\"");

            outputText("\n\nHer hands re-grip your [cock biggest] just as hard as before and she begins pumping one hand, coating your cock in the desert-hot syrup. It feels like your dick is in the hottest cunt ever and Frosty's hands are its pussy walls, squeezing down your entire length in hopes of getting you to release your hot cream all over them.");
            outputText("\n\nThis thought only makes you harder and has Frosty pumping her hands up and down your shaft faster, practically bouncing herself back and forth, giving her all to please your cock.");
            outputText("\n\n\"<i>Are you about to give me your cream, Cocky?</i>\" she’s talking directly to your [cock biggest] now. \"<i>I want to lick the cream off my face, come on. Give it to me, please?</i>\" She rubs your cock against her face, pushing it against her cheek and sliding it against her lips, making you feel their soft heat on the tip of your cock, but only just for a moment. She continues rubbing and pressing your [cock biggest] against her other cheek.");

            outputText("\n\nShe keeps rubbing your cock all over her face, painting herself with the special syrup. She only stops when you groan and your cock gives a big throb in her hand. Then she takes the cock off her face and aims the head straight at her mouth. She opens it with an \"<i>Ahhhhhh...</i>\", sticking out her tongue out and giving your cock a few more vigorous strokes before you shoot your hot cum directly into her mouth. She eagerly gulps it down with ease like your cum is just flowing directly in her stomach.");
            outputText("\n\nNot for one moment does she let the cum pool in her mouth. She moves her face in closer as the cum-stream begins to die down, just so she can continue to gulp all your sweet cream, moving her head closer and closer to your cock, stopping only when her lips are about to wrap around the head. She lets out a low \"phew\" against your cock and gives it a warm little peck on the head, then bounces back onto her feet.");
            outputText("\n\n\"<i>Thank you for your business, hope to see you again.</i>\"");
            outputText("\n\nYou ask her who's gonna clean the syrup off your cock. \"<i>Oh my, I guess I can’t leave your ");

            if (player.biggestCockLength() < 7) outputText("little");
            else outputText("big");
            outputText(" friend all covered in the sweet goo.</i>\" She licks her lips in a seductive manner. Sweet, you were able to get a free BJ from her. Frosty kneels back down, opens her mouth and puts two fingers inside of it. She makes a high-pitched sound that rings in your ears and in the next instant you’re both suddenly dosed in a waterfall of ice-cold water. You sit there wondering what just happened while Frosty looks up behind you and yells: \"<i>Thanks Terry!!!</i>\"");

            outputText("\n\n\"<i>You’re Welcome,</i>\" a low-toned voice replies. You stand up, dripping wet, while Frosty is still kneeling with a grin on face.");

            outputText("\n\n\"<i>Thank you again loyal customer, hope to see you again soon!</i>\" Giggling, she goes back behind her booth with a line of customers waiting. All of them are males or herms that all have hard-ons. You hear Frosty explain the contract to a busty and eager canine hermaphrodite. \"<i>Just sign here and you get a free sample of my special services.</i>\"");
            player.sexReward("no", "Dick");
            sharedEnd();
        }

        function vagF():void {
            outputText("\"<i>Okay, one dig-dug comin' right up.</i>\" she giggles at her own name for a fingering. She ducks under the table and pulls up a big, fancy cushioned chair that looks like it belongs to a noble and also shouldn’t be able to fit in the tiny space under her booth. She throws the chair right next to her stand and it lands perfectly, hardly making a sound. In one moment Frosty just disappears and reappears on the chair, sitting on its arm and waving her hand over to the seat, gesturing for you to sit. You follow her gesture and take a seat in the comfy chair; just sitting there makes you feel like the ruler of a land. Placing your arms on the armrests, you feel like a boss.");
            outputText("\n\nFrosty has moved from the armrest and is now pulling at the bottom half of your [armor]. With one quick hard tug, she exposes your [butt] and [vagina] to the busy city street; a few people stop to gawk at both of you. She places her thumbs on both sides of your cunt and stretches the lips wide and hard.");
            outputText("\n\nFrosty takes a peek inside you, wondering how far she can see inside, then hovers her mouth over your fuck-hole and yells \"<i>Hellllllllllllllo!!!</i>\" like she was expecting the sound of her voice to echo back from your cunt. But the vibrations of her voice do ring through your [clit], causing your [vagina] to get a little moist.");
            outputText("\n\nShe giggles, amused by her own antics. Then the nymph removes her thumbs from the sides of your pussy, returning it to its almost closed look, but the lips stay slightly parted like a hungry wet mouth.");
            outputText("\n\nFrosty reaches under the chair and pulls out a bottle of syrup from there. She looks at the bottle with a grin and opens it. The sweet smell invades your nostrils and reminds you of waking up in the morning at home for breakfast. You feel a bit nostalgic as you take deep breaths. You relax, slouching in the chair and not paying one bit of attention to Frosty. That is, until you feel a warm thick dampness dripping onto your [vagina]. You flinch out of your care-free state of mind, look down at Frosty and see that she’s tilting the bottle of syrup over your cunt, spilling its contents onto you.");

            outputText("\n\nThe syrup oozes down, and partially into, your pleasure hole; its hot gooey warmth covering the whole outside of your [vagina], making you dripping wet and causing the syrup to run faster down your pussy. Frosty lets her sweet liquid work its magic on you while she rubs what remains of the bottle onto her hands, rubbing them together until her pink soft hands are turned into sticky translucent light chocolate brown colored looking gloves. Then she brings her attention back to you, withering in teasing pleasure and moaning softly as the mass of syrup is now invading your cunt. Frosty giggles a little, again amused by her own actions, then she lifts a sticky finger up and presses it against your pleasure button.");
            outputText("\n\nShe moves her finger in tiny circles, sending electric waves of pleasure through your cunt. You groan and moan as you press your [clit] against her finger. She pushes back against you, forcing the erect clit slightly back into your body and then takes her finger back. The sticky syrup on your clit and her finger causes your sensitive bud to be pulled back with her finger. Every little centimeter makes you squeal and pant in a mix of pain and pleasure.");
            outputText("\n\nFarther and farther it gets pulled until the syrup breaks and your clit snaps back into place. You let out a great moan as an intense wave of pleasure hits you, starting from your cunt and spreading throughout your body. You feel like you’re on fire!");
            outputText("\n\nFrosty goes to spreading your cunt lips again and takes another look inside. Your walls are dripping with fuck juices and syrup, both mixing together and flowing out from you. Frosty collects a bit of the mix on the tip of her two fingers and sucks it off. A satisfied \"<i>Mmmmmmm!</i>\" comes from her as she tastes it. She plunges her finger back in and out of your [vagina] in rapid motion, covering the whole length of them in your sweet-mix and pushing the desert-hot syrup deeper into your burning pussy. She quickly pulls her fingers from your cunt and shoves them into her mouth, sucking all the sweet mix off as she pulls her fingers out with a *POP* and sticks them back into your sweet pot.");
            outputText("\n\nHer fingers move rapidly just as before but this time she adds another finger, shovels them in there a few more times and then adds another finger! Now thrusting all four fingers into you, Frosty then pushes her whole hand into your fuck-hole. All her fingers disappear, and then she pushes past her knuckles and very slowly inches deeper until she’s down to her wrist, her whole hand now buried in you, your cunt holding tightly around it. She moves her hand scarcely back and forth an while moving her wrist in half-circles clock-wise then, after some time, counter clock-wise. You rub and smack your [clit], groaning as Frosty keeps pumping her hand into you. Your own hips mimic her hand movements, rhythmically helping her to get you off.");
            outputText("\n\n\"<i>Oohhh, you're helping me to get your juices, I can feel some of it run down my hand, I can’t wait to lick all your hot sweet juices off my hand. It’ll be so sweet!</i>\"");
            outputText("\n\nShe licks up all the juices running down her arm, her head moving up and down the length of it, her tongue going back down just before it touches your [vagina]. Her breath only giving you a slight touch on your clit, you rub your teased button long and hard, moving your hand away just as a long wet orgasm floods on and down Frosty. You let out a long satisfied moan as Frosty laughs with glee, watching her arm and the ground get soaked in your love juice.");
            outputText("\n\nYou slouch in the chair then Frosty pops her hand out of your cunt and begins licking her arm, which is covered in a mix of your fuck juices, orgasm and her syrup, like it was a whisk just done mixing cookie batter.");
            outputText("\n\nShe lets you relax in the chair while she attends to a line of customers, all of them are females of various sizes. Frosty explains the contract to a centauress who is dripping wet \"<i>All ya have to do is sign here.</i>\" She’s still licking the syrupy mix off her hand while she explains the contract.");
            player.sexReward("no", "Vaginal");
            sharedEnd();
        }

        function hermF():void {
            outputText("\"<i>Okay, one stroke-and-poke comin’ right up</i>\" she snickers at her own name for using her hand to pleasure a herm. She ducks under the table and pulls up a big, fancy, cushioned chair that looks like it belongs to a noble and also shouldn’t be able to fit in the tiny space under her booth.");
            outputText("\n\nShe throws the chair right next to her stand and it lands perfectly, hardly making a sound. In one moment Frosty just disappears and reappears on the chair, sitting on its arm and waving her hand over to the seat, gesturing for you to sit. You follow her gesture and take a seat in the comfy chair; just sitting there makes you feel like the ruler of a land. Placing your arms on the armrests, you feel like a boss.");
            outputText("\n\nFrosty has moved from the armrest and is now pulling at the bottom half of your [armor]. With one quick hard tug, she exposes your hard [cock] and [vagina] to the busy city street; a few people stop to gawk at both of you.");
            outputText("\n\n\"<i>I should be charging you double points for this but hey, double the fun for me.</i>\"");

            outputText("\n\nShe lifts your cock up, giving it small strokes while holding it up, to get a look at your cunt, which is getting aroused and puffy from the stimulation from your dick. She gives your clit a light poke with one finger and holds it there, giving both your sensitive bits a light electric feeling of pleasure. Your cock growing hard in her hand and your cunt getting wet under her finger, she frees you from her teasing grip and poke.");
            outputText("\n\nYour [cock biggest] stands erect and your [vagina] drips wetness. Frosty reaches under the chair and pulls out a bottle of syrup from there. She looks at the bottle with a grin, opens it, swirls it around like a fine wine and sniffs its sweet aroma in. Then she holds the bottle over your skyward pointing cock and tilts the bottle, spilling the desert-hot syrup onto your [cockHead biggest].");
            outputText("\n\nIt pools a little bit on the head on then spills over, flowing down your shaft and onto ");
            if (player.hasBalls()) outputText("your [balls]");
            else outputText("your pussy lips");
            outputText(". Your cock throbs and your pussy twitches as the brown ooze pleasures both your sex organs. Frosty spills the entire bottle's contents over your pleasure bits and helps spread the masses of syrup as she grips your [cock biggest] and strokes it with enthusiasm. She lets out little giggles here and there as your cock gets messy and sticky with the sweet liquid. Faster and faster she keeps stroking you, covering your entire dick and bringing you to the edge of cumming, but then she quickly releases her grip. Your cock throbs like crazy now; you can almost feel the cum about to shoot out.");
            outputText("\n\nOne little touch would send you over the edge, but after a few seconds your hard throbbing slows down to nothing and your cum feels like it’s going back into your body.");
            outputText("\n\n\"<i>The fun would be over too soon if I just made your cock explode now and I don’t want your hungry pussy to feel left out.</i>\"");

            outputText("\n\nGeez, she could have at least not given you an intense case of blue balls.  Damn, this hurts SO much right now. \"<i>Ooooh...</i>\" Frosty sees the slight look of pain on your face. \"Here, let me make this all better.</i>\" Frosty licks the palm of the hand she used to jerk you, taking extra care to lick and suck on her fingers. She takes a look at her fingers then your cunt, then back to her fingers, back to your cunt then takes a final look at her fingers. The dim-witted nymph then launches two wet fingers into your syrup-covered pussy. So much pleasure hits you that a hard shot of pre-cum shoots from your cock.");
            outputText("\n\nIt would have ended up in Frosty’s curly hair, but she swiftly tilts her head back and catches the pre in her mouth, not missing a beat in pushing her fingers in and out of your cunt. She may act innocent but she is one grade A pleasure slut.");
            outputText("\n\nHer pushing two fingers into you combined with rubbing them against your G-spot makes your tongue loll out like ");
            if (player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties)) outputText("the bimbo you are");
            else outputText("a bimbo");
            outputText(". Your vision blurs as she continues, adding stroking your cock to the pleasure roll. Your [cock biggest] instantly sprays a gush of spooge out only after two strokes. You moan in ecstasy as the cum launches high into the air. Frosty quickly positions the empty syrup bottle where the cum would land and most of it spills into the bottle. She lets go of your softening member and pushes a finger against your [clit], pressing and rubbing the pleasure button while digging two fingers into your fuck-hole, rubbing them against your sweet spot.");

            outputText("\n\nShe keeps simultaneously rubbing both of your cunt’s weak spots until your cock grows hard again from the stimulation. Her clit-rubbing hand goes back to stroking your cock, which is now damp with a hot mix of your cunt juice and her sweet syrup.  Somehow the thought of being pleasured by your own fuck juice makes you raging hard and eager to cum again.");

            outputText("\n\nYou feel the pressure of sweet release build up again, but this time in both of your pleasure parts. You buck your hips in an uncontrollable fervor, waiting to cum from both your fuck stick and hole at the same time. Frosty seems more interested in your [vagina], looking at it instantly, like she can’t wait to see you orgasm from there. Well, she doesn’t have to wait long as you thrust your cunt as far as you can, moan like a bitch and release your second orgasm from your cunt. Frosty quickly grabs the bottle with cum and syrup dew and pushes it against your cumming hole, filling a good amount of the bottle with your sweet pussy mix. On the peak of that orgasm, you feel your cock twitching, about to shoot its load too.");
            outputText("\n\nFrosty directs all her attention to your [cock biggest] now and aims the head directly at the bottle. Giving you a few more hard strokes she makes you let loose all you have into her bottle of sex fluids. She caps the bottle before it overflows and uses her mouth to catch the rest of the cum.");
            outputText("\n\nYou sit there exhausted after cumming three times, watching Frosty give a shake to the bottle of your sweet sexy mix, then she pockets it in her cupcake hat, maybe saving it for a snack later. She gives you a quick pat on the head and goes back to manning her booth where a line of herms have formed, each of whom are hard and wet.");
            outputText("\n\n\"<i>YOU TOO CAN HAVE MIND CUMMING ORGASMS JUST LIKE THAT LOYAL CUSTOMER SITTING BLISSFULLY IN THAT CHAIR OVER THERE!</i>\" she yells her services to the crowd of already willing herms, rallying them up. \"<i>All you have to do is sign these papers.</i>\" You see Frosty instructing a Cat morph in where to sign before you get up and, still quite wobbly on your legs, make your way back to camp.");
            player.sexReward("no", "Dick");
            player.sexReward("no", "Vaginal");
            sharedEnd();
        }

        function sharedEnd():void {
            frostyPoints(-5);
            dynStats("sen", -1);
            doNext(camp.returnToCampUseOneHour);
        }
    }

    //[Mouth]
    public function useFrostysMouth():void {
        clearOutput();
        if (player.isGenderless()) genderlessCatchAllForFrosty();
        else sceneHunter.selectGender(dickF, vagF, null, hermF);

        //======================================================================
        function dickF():void {
            outputText("\"<i>One banana-licking comin' right up.\"</i> You roll your eyes at the comment as Frosty blurs away her display then vaults over the counter with ease and is suddenly behind you. You quickly turn around just as she pushes your backside against her stand and falls to her knees. She’s about to pull the lower half your [armor] off but decides not to. You wonder what she’s going to do as she stretches her jaw and sticks out her tongue for a few minutes. After she’s done with that, she cracks her neck and looks at your pants, like it’s a challenge. Then, in an instant, she’s able to undo your [armor] with just her tongue and teeth and has you standing waist-down naked. Now you have second thoughts of having any of your naughty bits near that mouth.");
            outputText("\n\nJust before Frosty starts her mouth sex, she raises a finger up like she’s remembering something and quickly crawls around to the back of the booth, wiggling her tush in the air. You hear her rummaging under the counter and then she’s suddenly back in front of you; did she even crawl back around? In her hands is a yellow bottle shaped like a bee-girl and a thin black rope. She plops back down on her ass with her boobs doing a little jiggle when she lands. She holds the black rope up and tells you what it’s for.");
            outputText("\n\n\"<i>Sometimes I forget to not use my hands when I do this, so I tie them behind my back. And the honey... well,</i>\" she giggles \"<i>you’ll find out soon.</i>\"");
            outputText("\n\nShe takes a deep swig of the bee-girl bottle, pooling up the honey in both her cheeks. She swishes it around in there and then gulps down a portion of the honey, though you can tell there’s still some of it left in her mouth. Now she’s putting both hands behind her back, one with the black rope in it. Her hands fiddle around there; one of her eyes is closed and her tongue sticks out between her lips as she tries to figure out how to tie herself up, but like the polar opposite of Houdini, she’s able to entrap herself in the most impossible way.");
            outputText("\n\n\"<i>See, nice and tight, just like my little pink pussy.</i>\" She does a little side-turn to show you her work. Both hands are tightly bound to each other with a complicated knot holding them there. If you hadn’t seen it, you wouldn’t believe she did this to herself.");
            outputText("\n\n\"<i>Now let’s get this party started!</i>\"");
            outputText("\n\nHer honey-soaked tongue runs laps up and down your [cock biggest], doing an extra few licks around your sensitive [cockHead biggest]. Her pink eyes look dreamily at it as she does so, covering your cock in her honey-spit mix. Your dick pulses with every lap of her tongue, wanting to plunge the whole way down her tight hot throat. She catches on to what you want and pulls back to open her mouth wide for you to see inside.");

            outputText("\n\nStings of honey connect the roof of her mouth to her soft tongue and other tiny strings fall from her teeth, her mouth looks like the inside of a honey bee hive, all wet and sticky. Your [cock biggest] eagerly throbs at this sight. She closes her mouth and smiles at you. Then her pink lips pucker up, giving her a blowjob face. She wraps them around your tip and circles her tongue around the head. You moan in satisfaction as you place a hand on top of her curly hair, giving her some guidance on where her tongue should be. The lip-seal around your cock loosens and Frosty has her mouth opened wide, your [cockHead biggest] just sitting on top of her honey soaked tongue. It takes you a moment to realize what she is doing or to put it in better words: What she wants you to do.");

            outputText("\n\nYou put both hands behind her head and ram your cock down her throat, causing a streak of honey to shoot out the corner of her mouth. You hold your [cock biggest] down her throat, feeling its hot sticky honey-walls constrict around it as she wiggles her tongue on the underside, honey drooling out. You hear, or more likely feel, her trying to talk as her throat vibrates with speech and hot air travels through it. You pull your [cock biggest] out of her mouth with a pop, Frosty doesn’t even look like she just had a dick in her throat, she looks like she normally does except for the spit and honey-mix glistening on her chest.");
            outputText("\n\n\"<i>Nymphs are made to be fucked [name], you can be as rough as you want and I’ll smile and take it. Just for a loyal customer like you.</i>\"");
            outputText("\n\n\"<i>Made to be fucked...</i>\" Let’s see how true that is. You shove your cock back down her throat and bob her head up and down your [cock biggest]’s shaft, forcing her to make loud wet slurping noises every time you pull her head back. She seems more uncomfortable from having her head tossed back and forth than from a dick being thrusting down her throat.");
            outputText("\n\nShe starts massaging the underside of your [cock biggest] with her tongue, moving it in waves, hoping this will make you cum sooner and stop treating her head like a ball but just like a ball, when you let go of her head she continues to slurp up and down on your cock. You lean back, relax and enjoy this delicious mouth-fucking.  Her wet noises are like sweet pleasurable music to your ears. You let her mouth bring you to the edge of climax and when you feel like you’re about to blow your load, you shove your dick in as far as you can and deposit all your cream directly down her throat, thrusting your [hips] a little in the afterglow.");

            outputText("\n\nYou let go of Frosty and she slides her mouth off your cock, a trail of gooey honey still connecting her lips to your [cockHead biggest]. She sits there dazed, looking more dizzy than short of breath. \"<i>Oh! Look at the little birdies flying around my head.</i>\" She looks wondrously at nothing over her head while trying to keep her balance as her head moves in circles. Her eyes locks onto one \"birdie\" and her spinning head tries to follow it. She keeps tracking it until she turns a full 180 degrees and sees that a queue of customers have formed behind her and she is now face-to-horse cock with one of the more \"happier\" ones. She lets out an \"eep\" and quickly worms her way behind her stand.");
            outputText("\n\nYou hear her nomming on something and a \"blah\" of disgust. \"<i>I hate black licorice... ahhh...</i>\" You hear her mutter, then she pops back up to set herself on display in less than a second. The customer pushes you aside and asks about \"<i>getting some of what you got.</i>\"\n\n \"<i>Well, all you have to do is sign here and you’ll get a free sample of my services...</i>\"");
            player.sexReward("saliva", "Dick");
            sharedEnd();
        }

        function vagF():void {
            outputText("\"<i>One sundae-eating coming right up!</i>\" You roll your eyes at the comment as Frosty blurs away her display then vaults over the counter with ease and is suddenly behind you. You quickly turn around just as she pushes your backside against her stand and falls to her knees. She’s about to pull the lower half of your [armor] off but decides not to. You wonder what she’s going to do as she stretches her jaw and sticks out her tongue for a few minutes. After she’s done with that, she cracks her neck and looks at your pants, like it’s a challenge. Then, in an instant, she’s able to undo your [armor] with just her tongue and teeth and has you standing waist-down naked. Now you have second thoughts of having any of your naughty bits near that mouth. Just before Frosty starts her mouth sex, she raises a finger like she’s remembering something and quickly crawls around to the back of the booth, wiggling her tush in the air.");
            outputText("\n\nYou hear her rummaging under the counter and then she’s suddenly back in front of you; did she even crawl back around? In her hands is a yellow bottle shaped like a bee-girl and a thin black rope. She plops back down on her ass with her boobs doing a little jiggle when she lands. She holds the black rope up and tells you what it’s for.");
            outputText("\n\n\"<i>Sometimes I forget to not use my hands when I do this, so I tie them behind my back. And the honey... well,</i>\" she giggles, \"<i>you’ll find out soon.</i>\"");

            outputText("\n\nShe takes a deep swig of the bee-girl bottle, pooling up the honey in both her cheeks. She swishes it around in there and then gulps down a portion of the honey, though you can tell there’s still some of it left. Now she’s putting both hands behind her back, one with the black rope in it. Her hands fiddle around there; one of her eyes is closed and her tongue sticks out between her lips as she tries to figure out how to tie herself up, but like the polar opposite of Houdini, she’s able to entrap herself in the most impossible way. \"<i>See, nice and tight, just like my little pink pussy.</i>\" She does a little side-turn to show you her work. Both hands are tightly bound to each other with a complicated knot holding them there. If you hadn’t seen it, you wouldn’t believe she did this to herself.");
            outputText("\n\n\"<i>Now let’s get this party started!</i>\"");

            outputText("\n\nShe launches her head directly at your [vagina] and gives your lips a smooch. A kiss here and a kiss there, her soft lips keep pressing against your tender ones, only touching your [clit] for a second with every little peck, making your love juices flow and your slit soaking, no, dripping wet from them. She turns these light kisses into a make-out session as she sticks her honey-coated tongue out and licks, moving across your lips and titters on thrusting its way to the inside, licking up all the moisture on you, with the honey pulling lightly on the sensitive skin. Soft moans of pleasure escape from you as she continues to lap and lick any little bit of wetness off you, her honey-tongue darting into every fold and little crevice, circling around just at the entrance of your fuck-hole. Your cunt clenches every time it passes over, almost like you're trying to force her to go in deeper, only to have it pull back to the outside, leaving your aching hole dissatisfied and yearning to be stuffed. But you get the next-best thing; she presses the broad side of her tongue onto your [clit], covering the bud in gooey honey, sending a burning feeling through your loins.");

            outputText("\n\nThe nymph licks it back up, then swipes her tongue over your clit again and locks her lips around it, hugging your clit into her mouth while her honey-coated tongue dances on it for a fleeting moment as she goes to licking your cunt in long rapid strides with her tongue. Her head goes in the same up and down motion of her tongue as she keeps her eyes like a cat lapping up a yummy saucer of milk. You moan in joy as you wrap your legs around her and place one hand on her head, holding a lock of her pink hair and pushing her face hard against your pleasure button. Letting out all your own pleasure-honey, it spills onto Frosty's face and hair, making her look like a bucket of water has fallen on her. Your hand letting go of her head, she removes her face from your [vagina] and shakes her face dry, flinging droplets of your love-honey all over the place. It reminds you of seeing a wet dog doing the same thing.");

            outputText("\n\n\"<i>Ooooh... I wanted to catch the honey in my mouth.</i>\" She sticks her bottom lip out and pouts. How cute, she has her sad face on. You try to cheer her up by commenting about all the customers she has. She looks confused by your comment and turns around to see a line of soaking-wet cunts. She lets out an \"eep\" and quickly worms her way behind her stand. You hear her nomming on something and a \"blah\" of disgust. \"<i>I hate black licorice... ahhh...</i>\" You hear her mutter, then she pops back up to set herself on display in less than a second. A horse girl pardons herself as she takes your place in front of Frosty’s stand and a stack of papers is presented to her. \"<i>All you have to do is sign here and you’ll get a free sample of my services.</i>\"");
            player.sexReward("saliva", "Vaginal");
            sharedEnd();
        }

        function hermF():void {
            outputText("\"<i>One banana split sundae special coming right up.</i>\" You roll your eyes at the comment as Frosty blurs away her display then vaults over the counter with ease and is suddenly behind you. You quickly turn around just as she pushes your backside against her stand and falls to her knees. She’s about to pull the lower half of your [armor] off but decides not to. You wonder what she’s going to do as she stretches her jaw and sticks out her tongue for a few minutes. After she’s done with that, she cracks her neck and looks at your pants, like it’s a challenge. Then, in an instant, she’s able to undo your [armor] with just her tongue and teeth and has you standing waist-down naked. Now you have second thoughts of having any of your naughty bits near that mouth.");
            outputText("\n\nJust before Frosty starts her mouth sex, she raises a finger like she’s remembering something and quickly crawls around to the back of the booth, wiggling her tush in the air. You hear her rummaging under the counter and then she’s suddenly back in front of you; did she even crawl back around? In her hands is a yellow bottle shaped like a bee-girl and a thin black rope. She plops back down on her ass with her boobs doing a little jiggle when she lands. She holds the black rope up and tells you what it’s for.");
            outputText("\n\n\"<i>Sometimes I forget to not use my hands when I do this, so I tie them behind my back. And the honey... well, you’ll find out soon.</i>\"");
            outputText("\n\nShe a takes a deep swig of the bee-girl bottle, pooling up the honey in both her cheeks. She swishes it around in there and then gulps down a portion of the honey, though you can tell there’s still some of it left. Now she’s putting both hands behind her back, one with the black rope in it. Her hands fiddle around there; one of her eyes is closed and her tongue sticks out between her lips as she tries to figure out how to tie herself up, but like the polar opposite of Houdini, she’s able to entrap herself in the most impossible way. \"<i>See, nice and tight, just like my little pink pussy.</i>\" She does a little side-turn to show you her work. Both hands are tightly bound to each other with a complicated knot holding them there. If you hadn’t seen it, you wouldn’t believe she did this to herself.");
            outputText("\n\n\"<i>Now let’s get this party started!</i>\"");

            outputText("\n\nShe starts by licking from the bottom of your [vagina] to the tip of your [cock biggest] and then swallows down the head, bobbing her head on your cock. Her big pink innocent-looking eyes stare up at you, the cock going down her throat betraying their look. The honey in her mouth makes it feel like you’re fucking a hot pool of honey; in and out your cock moves and soon the entire member is coated in the stuff. She bobs her head on your cock and tightly wraps her lips around it, slurping up all the honey in a vacuum-tight sucking as she pulls off, getting all the sweet liquid on your cock back in her mouth.");

            outputText("\n\nPopping your cock out of her mouth, she buries her face in your cunt. Your erect [cock] is being pushed against her curly pink hair as she inadvertently rubs against the member, her head always directed at where her tongue wanders all over your cooch, exploring every fold and crevices with the same hyper-active eagerness she always has. Your cock throbs in pleasure as its female counter-part gets all the lickings. You thrust your [hips] forward, poking your cock into her hair, reminding her that you still have a [cock biggest] wanting her bimbo lips wrapped around it. She unburies her face from your crotch and opens her mouth wide with an \"<i>Ahhh-Mmmmmmm</i>\" that is muffled when she brings her mouth down on your dick again.");

            outputText("\n\nYou have male and female pleasure organs and she only has one little mouth to fuck, but she’s eager to please you. This could be interesting. \"<i>Frosty, my [vagina] wants some attention too.</i>\" Frosty immediately goes back to burying her face in your cunt. \"<i>FROSTY! My [cock] is left out in the cold.</i>\" Again she blows your cock down her throat. \"<i>MY PUSSY!</i>\" You keep making her go back and forth between the two different pleasures until she’s dizzy, her eyes spinning in circles when she’s in between licks and sucking. She regains her sense with a shake of the head and assesses the situation. She eye-balls the distance between the tip of your [cock biggest] and your [clit]. Then she tenderly kisses the top of your cock and proceeds to kiss it over and over, her mouth making out with your [cockHead biggest]. You’re about to tell her to switch to your pussy, but before you can even open your mouth, her tongue starts wrapping around your cock.");
            outputText("\n\nAt first it only covers the head but then it proceeds to wrap down the entire length of your dick, going around your fuckmeat like the red stripe of a candy-cane. She tightens her stretchy bubblegum-tongue around your [cock biggest], honey drooling in down the spaces in between. Her tongue slithers farther down until it wraps around your clit just like it did with your cock. What started out in messing with the simple mind of a nymph has turned into you getting a mind-blowing tongue fuck. Her grip on your sensitive bits tightens and loosens over and over, faster and harder, bringing your entire crotch zone to the point of cumming. She puts you in a death-grip with her soft tongue, making your [cock biggest] and [vagina] throb, quiver and twitch as you moan and thrust your hips in anticipation of your impending double orgasm. You simultaneously release both your cream and your juices, your cum going down her throat while your love juices soak her bikini top and her pink boobs.");
            outputText("\n\nThe strength in your legs disappears and you fall back onto the stand for support. Frosty unwraps her tongue from your cock with a slow slurp, and like it was never so stretched just a moment ago, her tongue is back to normal.");
            outputText("\n\n\"<i>Bet you didn’t know nymphs could do that... I didn’t even know I could... do that...</i>\" She shakes off this thought like she did with the dizziness. Instead she focuses on undoing the rope, or more like eating the rope. Her face cringes in disgust as she chews on the stuff, making moans of dissatisfaction. She keeps chewing until the rope is fully undone and falls to the ground.");
            outputText("\n\n\"<i>Black licorice... disgusting stuff.</i>\" She holds the \"rope\" up to you. \"<i>The only candy I’d hesitate to chew on.</i>\" She throws the candy rope behind the stand carelessly. \"<i>Thank you for your participation but please move along. I have more customers to deal with.</i>\" Like a show-girl, her hands direct your eyes to the line of herms behind her, all of them erect and wet, the one right behind her looking directly at her bikini bottom with primal lust in her eyes. You let out an understanding sigh and make your way past the line of herms, avoiding their cocks and hearing Frosty explain the contract. \"<i>All you have to do is sign here.</i>\"");
            player.sexReward("saliva", "Dick");
            player.sexReward("saliva", "Vaginal");
            sharedEnd();
        }

        function sharedEnd():void {
            frostyPoints(-15);
            dynStats("sen", -1);
            doNext(camp.returnToCampUseOneHour);
        }
    }

    //[Back to Frosty’s Special Menu.]
    public function genderlessCatchAllForFrosty():void {
        if (flags[kFLAGS.SEEN_GENDERLESS_FROSTY_REJECTION] == 0) {
            flags[kFLAGS.SEEN_GENDERLESS_FROSTY_REJECTION]++;
            //[If player selects any option and is Gender-less 1st time]
            outputText("Frosty look at the service you selected then leans over the counter and looks down at your crotch. She makes a curious \"<i>Mmmmm...</i>\" and reaches her hand over the counter and down towards your crotch. She palms it a bit, nodding her head as she does so. \"<i>Just as I thought,</i>\" she mumbles. The pink nymph retracts her hand and stands straight up. She hits the special menu in the lower-right corner with two fingers. You see very tiny lettering, writing itself onto the paper. You try to read what it’s writing, even squinting your eyes, but it’s too small to read. Only when the lettering stop writing does Frosty hand you a huge magnifying glass. You wonder where she would keep such a thing. You give Frosty a strange look and go to holding the magnifier up to the newly formed text:");
            outputText("\n\n\"<i>We reserve the right to deny certain services to people of a certain gender, Sorry!</i>\"");
            outputText("\n\nYou give Frosty a dirty look but she just shrugs her shoulders like this new rule she just made is out of her power. \"<i>Sorry customer, them's the rules. But hey, you can still choose a few other options... very few other options!</i>\" You let out an irritated sigh and go back to looking at the specials' menu.");
        } else {
            outputText("\"<i>Sorry customer, you need a cock or a pussy or BOTH if I’m to do that!</i>\" she sings in a cheesy jingle tone that makes you go, \"<i>ughhhhhh.</i>\"");
        }
        //[Back to Frosty’s Special Menu.]
        frostySpecialsMenu();
    }

    //Cunnilingus (For all genders)
    public function cunnilingateFrosty():void {
        clearOutput();
        outputText("She looks at the service you selected and a wide smirk comes over her face. \"<i>Ooooh, I love that one!</i>\" she squeals in delight, putting away a good amout of her display in a blur, then vaulting over the counter. You jump back,  avoiding her legs as she takes a seat on the edge of your side of the counter with her legs crossed. You’re about to bend down to her crotch level and spread her two pink legs open when she suddenly holds up one finger to you and quickly blurts out: \"<i>Oh wait, I forgot one more thing!</i>\" She leans her back onto the counter, her hair draping on the other side as she looks like she’s searching under the counter for something. You hear her let out an \"A-HA!\" as Frosty’s body shifts to grab what she was looking for; she gracefully pulls herself back with some strange lean metal cylinder with a thin nozzle on the top in her hand.");
        outputText("\n\nShe holds a finger up to the nozzle’s tip and you hear it make a spraying sound as a fluffy white substance is dispensed on her fingertip. She holds the fingers down to you, expecting you to suck the stuff off her finger. Maybe it is the heat of the moment or something else but you latch your mouth around that finger and have your tongue explore as much as it can. The white stuff is sweet and fluffy, immediately turning into a flat sugary liquid when it makes contract with your spit. You continue sucking on her finger, Frosty looking at you with delight, until the taste of the sweet stuff is gone. She pulls her finger from your craving mouth, a trail of saliva following and breaking as she takes it back.");
        outputText("\n\n\"<i>You really like my cream don’t ya?  Well, guess where you can get more?</i>\"");

        outputText("\n\nShe uncrosses her legs, spreads them and undoes the strings holding that tiny piece of bikini cloth against her pussy. The covering falls off her pink cunt and hangs over the edge of the counter; you see her pink pussy is all wet and excited to see you. The nymph shakes the can, her breasts jiggling a little, and places the nozzle over her hard clit, spraying  a little swirl of the sweet stuff on it. Its cold fluffy texture makes her coo a little. She beckons you with her finger to dig in.");
        outputText("\n\nYou quickly bring your mouth to her pussy with a loud slurp as your entire mouth covers her moist mound, sucking and licking the sex hole just to taste that little bit of sweet, sweet cream. She gasps in surprise on how savagely you are tongue fucking her, her legs and toes curling up and leaning back on her arm for support. Only when you stop tasting the stuff do you calm down, pulling your mouth off her now puffed up cunt, her pussy lips looking quite a bit fuller now than they did before. Frosty catches her breath before shaking the can once more and spraying large amount of the cream over her clit and vulva, almost looking like white fluffy snow covering a pink mound. You hold back, watching her spray on more cream. Only when her pussy is completely covered and then some does she lean back on the counter, both arms bracing her up, legs spread wider than they were before and making a quick sharp whistle, giving you the signal to dig in once more.");

        outputText("\n\nYour mouth first laps up a huge glob of just the cream, not getting in contact with her skin just yet. You swish the stuff in your mouth, its sweet flavor rolling over your tongue and sticking to the walls of your cheeks. Only when the cream becomes an unbearable sweet liquid do you swallow it down and lick your lips. You take another glob of the stuff off her cunt.  This time your lips brush against her soft pink skin.  Her anticipation warms her body, melting droplets of the cream down her thighs as you get closer and closer to her treasure. You keep on taking large chunks of the cream off her nympho pussy, until it’s looking painted with cream residue. Her cunt is sticky as the moistness causes the white cream to dissolve into syrupy ooze all over and into her pussy. She has been making little moans here and there, you never really touching skin throughout that whole ordeal, but her tender skin and the delicious white cream are almost one and the same now.");

        outputText("\n\nYou lick your lips again; you’re full-bellied and a bit exhausted but you just want more of that cream. Especially the bits around her moist fuck-hole... the cream dampened with the liquid lust of a nymph has more of a kick to it. You stick your tongue out and circle around her cream-gusher, gathering as much as you can and giving each lip the attentive lickings they deserve, giving her clit a flick whenever you feel like it.");
        outputText("\n\nThe excitement built from the licking though the pile of cream shows greatly as Frosty moans and coos with every lick you make. You spread her lips apart to get at the sweet stickiness that seeped in. Her breathing becomes heavier as you maneuver your tongue over her sweet spot, licking up what little creamy residue resides on her. Frosty becomes wetter with every lick.  You bring her closer to orgasm, but she's unable to come full circle.");
        outputText("\n\nYou’re getting tired of the cream now, too much of a good thing as they say. You need something to wash it down; some nymph cum would make the perfect drink. You go back to what you did when you first tasted this sweet treat off this delicious body and cover your entire mouth over the puffy pink pussy, causing her to curl her legs and toes as you pleasure her entire sex bit with your hot wet mouth. Your slimy muscle rolls over her two lips and moves around her clit.");

        outputText("\n\nShe pushes your face harder onto her pleasure mouth, making you \"kiss\" her deeper and hotter, her moans and yells of pleasure growing louder and louder as the build up grows bigger and bigger.  You can taste trickles of her fuck juice, eagerly drinking it down. You brace yourself for the flood of sweet, sweet cum.");
        outputText("\n\nLike clockwork, she wraps her long pink legs around your head, pushes your face as hard as she can with both hands and shoves her pelvis forward as she lets out a gleeful moan and a flood of orgasm flows into your mouth. Delightedly, you gulp down her nectar.  When the last of the girl-cum flows out, her body goes limp, releasing you from her cum grip.");
        outputText("\n\nYou pull your mouth off her sloppy cunt and look down at your work. Frosty is laying on the counter, her head hanging off on the cashier side while her legs are spread out and her cunt all horny and exposed on the customer side. You’re pushed aside by a minotaur with a five-foot hard-on. He lines his flared cock head to Frosty’s now red hole, rubbing the head over the lips to get a \"taste\"  of what he’s about to indulge in. However, before he impales her on his meat-stick, Frosty springs back to life. She slides her body under the counter, and her hand reaches up to search for her bikini bottom.");
        outputText("\n\nHer hand passes over the minotaurs cock a few times, before finally finding the tiny bit of cloth. The hand whizzes back under the counter and Frosty pops back up, in her \"proper\" uniform now.");
        outputText("\n\n\"<i>Sorry sir,</i>\" she explains to the horny minotaur, \"<i>you’ll need to sign a few things if you want to fuck me with that big tasty stick of man meat.</i>\"");
        outputText("\n\nFrosty proceeds to try and have the minotaur sign the papers as you go out back into the city.");
        //[Player is back at camp]
        frostyPoints(-1);
        dynStats("lus", 33, "scale", false);
        player.sexReward("vaginalFluids", "Lips", false);
        doNext(telAdre.telAdreMenu);
    }

    private function analWithACupcakeSloot():void {
        clearOutput();
        outputText("\"<i>So you wanna be the pitcher or the catcher?</i>\" she ask with devilish smile. What the hell is that suppose to mean?");
        frostyPoints(-30);
        menu();
        addButton(0, "Pitcher", analPitcher).disableIf(!player.hasCock(), "Req. a cock!");
        addButton(1, "Catcher", analCatcher);
    }

    //Pitcher
    private function analPitcher():void {
        clearOutput();
        outputText("\"<i>Ok, let’s see if you can strike me out.</i>\" She closes one eye and sticks her tongue out at you.  This girl has a few screws loose, doesn’t she? You see her pull the strings of her bikini-bottom and you can assume that her ass is naked behind the counter now. Through you couldn’t really see from where you're standing, as the countertop is a little above waist level to her. She motions for you to walk around and join her on the cashier side.  You move around the counter, and you were right, her bikini bottom has fallen to the  ground and Frosty is practically naked, save for the little bit of cloth holding back her massive, pink tits.");
        outputText("\n\n\"<i>Well, what are you waiting for? Get that thing out and let the fun start!</i>\"");
        outputText("\n\nYou squeeze behind her, there being just enough room for the two to stand front to butt from one another, your body squishing against her soft back-side.  You reach into your [armor] and release your [cocks] from " + (player.cockTotal() == 1 ? "its" : "their") + " prision, the hot mass getting tangled in the curly hair draping over her back. It’ll take some maneuvering from both of you but eventually your cock-head makes contact with her tight pink hole. Frosty takes a deep breath and starts easing her-self down your [cock]. It takes her only a few moments for your cock to be snugly secured in her insides. She stands up straight, and the grip around your cock becomes tighter. She breathes out: \"<i>This is like the only service where I can man the shop and pleasure a customer, a bit exhausting, but business is business.</i>\"");
        outputText("\n\n\"<i>Mph</i>\", you reply as you begin to rock your [hips], starting the pleasurable fiction. As you begin revving up, a centauress trot over to the booth. She has blonde hair done up in a bun and is sporting two big lovely breasts. She looks perplexed on why you're standing behind Frosty and why she’s breathing heavily and has a flushed look on her face. It doesn’t take long for her to put two and two together. She’s about to give you two some privacy but Frosty quickly stops her.");
        outputText("\n\n\"<i>Oh... mmmmm... Don’t mind... oh geez... him/her... it’s part... slow a bit [name]...it’s part of the service.</i>\"");
        outputText("\n\nThe centauress comes back, trying her best to ignore you fucking the back-door of the person she’s talking to.");
        outputText("\n\n\"<i>Oh... ummmmm... yes. I would like to buy some of your...</i>\" she pauses when you really start pounding it into Frosty, making her body jiggle and her eyes close as she tries to ignore you and focus on her job. The centauress is almost  mesmerized by this display of lust, how eagerly you move your hips to ram your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " into Frosty and how she’s like putty in your hand as you do this.");
        outputText("\n\nThe centauress shakes her mind back to her objective. \"<i>I was wonder if I could buy some of those deluxe cupcakes.</i>\"");
        outputText("\n\n\"<i>Ooooooooo-k... how man-man-many do you-Mmmmmmmmmmmm-want!</i>\" Frosty tries to reply to her customer");
        outputText("\n\nThe centauress replies with a \"<i>five</i>\" focusing more on your cock pounding into that ass.");
        outputText("\n\n\"<i>Would yooooooou like-like to sign up for our-oh goddess this is sooooooo good- our Sweets and Sex program. You can-can-can-Oooooooooo!</i>\" Frosty throws her head back, puts a hand over her heart and lets out a long moan. You feel a hot stream her nymph cum running down her orgasim twitching legs, clearly she is getting off on this faster than you are. Must be an exhibitionist.");
        if (flags[kFLAGS.PC_FETISH] >= 1) outputText(", just like  you. Knowing this centauress is watching ass fuck this pink slut makes your cock even harder, like you can feel her eyes on your cock. You could blow your load into her colon right now, but you hold back. You want this curious horse-cunt to look on longer.");
        outputText("\n\nFrosty regains as much composure as she can with you still going at it. She goes back to talking to the centauress, who looks more flushed than Frosty does right now.");
        outputText("\n\n\"<i>As-as-as I was saying. yooooou can get get p-p-points...</i>\" Frosty let’s out a moan, she’s been holding back, out, \"<i>points! for every i-i-i-item you buy.  The-the-these point can be used to-to-to fuck meeeee!!!!</i>\" she blurts out that last part out and just fully indulges herself in you. Sticking her tongue out like a panting bitch, her eyes dreamily half-closed  with lusty ass pleasure. Letting out any little moan that builds up in her. \"<i>More, MORE!</i>\" she yells and you grab her long legs out from under her and hold them up.  Frosty entire weight is pushed down on your [cock] and her pink ass-hole is bounced every time you thrust up, making her pink tits jiggle out from her top and bounce as you fuck this nympho slut.");
        outputText("\n\nThe centauress stares at this show, biting on her knuckle and holding her side. Making her already big chest puppies look even perkier.  She must be trying to hold back some new feeling she has, now that she’s seeing your cock going directly into Frosty’s ass, in and out as she moans like a bimbo in heat. She must be imagining what it must feel like while trying to resist the thought at the same time. You gaze catches the centauress’, she bashfully looks away, taking a side-glance at your fuck stick.  ");
        outputText("\n\nYou feel your urethra dilate, the pressure in your cock grows too much to bare and you shoot glob after glob of hot sticky spunk into Frosty, the feeling of this hot cum makes Frosty squirt a stream of girl-cum all over her counter. Some of it sprinkling onto the now memorialized centaur cunt. You huff a little and pull her off your cock with a loud wet pop, followed by a ");
        if (player.cumQ() < 500) outputText("small trickle of cum that just drips out of her gaping hole.");
        else if (player.cumQ() < 1000) outputText("decent stream of cum that flows for a second and then just starts to drip.");
        else if (player.cumQ() < 2000) outputText("flood of cum following your cock out of the gaping hole. ");
        else outputText("huge flood of cum, you have to hold Frosty’s legs up for a few more minutes before all the jizz comes out of her, almost sounding like a water faucet when it hits the ground. The ground and your feet are soaked in the stuff now.");

        outputText("\n\nYou set Frosty down on her feet, she stands there for a second and then slumps forward onto her own cum covered counter with a little splash.  The centauress looks down at her and then at you. You put your cock back in your pants and walk past her with a smirk on your face. She pokes Frosty’s hat and ask \"<i>Are you still accepting sign ups for your services?</i>\"");
        player.sexReward("no", "Dick");
        doNext(camp.returnToCampUseOneHour);
    }

    private function analCatcher():void {
        clearOutput();
        outputText("\"<i>I love it when you people pick that one, hehehe..</i>\" What does she mean by \"you people\"? Before you can make a retort on that comment, she ducks under the counter and the sound of clanking pans can be heard, followed by the sound of clicking buckles. She pops back up with a huge impish grin on her face, what is she planning? She moves from behind the counter and stands to the side of it, leaning against her booth."
            + "\n\n"
            + "Showing you what she’s all smiles about, her bikini bottom has been switched to a strap-on horse cock! Leather straps secure the large member in its place, each one digging a narrow path in her skin, going across pink thighs. All of them meet on her bubblegum-pink ass. Right now the cock is dangling, looking directly at the ground. Only when she snaps her finger, it becomes full, hard and erect, springing up so fast that Frosty has to take a step back to keep her balance."
            + "\n\n"
            + "She snaps her fingers again and the horse-cock goes limp, hitting her leg with a slap and dangling between her ankles.She seductively walks over, horsecock swinging in the breeze, playfully running her hand over your shoulder as she moves right behind you, her hands running down your [breasts], over your body, and reaching your crotch."
            + "\n\n");
        if (player.hasCock() && player.hasVagina()) outputText("Her entire hand feels up your [cocks] while her fingers rub your [vagina].")
        else if (player.hasCock()) outputText("She traces the outline of your [cockplural] on your [armor] with her fingertip.");
        else if (player.hasVagina()) outputText("She rubs a finger along the length of your [cunt], damping the crotch of your [armor].");
        else outputText("Her hand is looking for something that isn’t there, and you smirk a little at her efforts.");
        outputText("\n\n");
        outputText("She looks into your eyes and smiles while her hands reache to undo the bottoms of your [armor]. You help her a little and soon your [armor] no longer cover your [ass]");
        if (player.hasCock() || player.hasVagina()) outputText(" or your ");
        if (player.hasCock()) outputText("[cocks]");
        if (player.hasCock() && player.hasVagina()) outputText(" and ");
        if (player.hasVagina()) outputText("[cunt]");
        outputText(". You courstyly take a step forward and take a side-glance at Frosty, she still has that impish smile on, waiting to shove that three-feet cock-stick in your ass. You let a  little sigh and wonder if she wants this more than you."
            + "\n\n"
            + "You bend over the counter and present your [butt] to the fake-herm nymph. She snaps her fingers once more, and the strap-on spring backs to attention. You feel her spread your cheeks aparts, getting a better view of your [asshole]. She maneuvers her hips to line the flared head up to your pucker. You feel its cold material lightly pushing against your back-hole. Knowing of what behind that small cold feeling causes your ");
        if (player.hasCock()) outputText("[cock] to get hard and beads of pre form on " + (player.cockTotal() > 1 ? "their throbbing tips" : "its throbbing  tip"));
        if (player.hasVagina()) {
            if (player.hasCock()) outputText("before dripping onto your already sodden [vagina].");
            else outputText("cunt to quiver in excitement");
        }
        if (!player.hasCock() && !player.hasVagina()) outputText("heart to beat in anticipation");
        outputText(".\n\n"
            + "You calm down these lustful feelings and brace yourself when Frosty grabs onto your [hips] and slowly pushes her horsecock in, spreading you [asshole]. You’re ready to fully take it, but she stops pushing the foreign object only at two inches in. Thinking she stopped to let you catch your breath or something. So wrong, once your body relaxes, she shoves the rest of the huge dick in you with one powerful thrust. You let out a shriek of surprise that echoes through the city, losing all the strength in your");
        if (player.isNaga()) outputText("snake-tail, the tip of it");
        else outputText("[legs], one");
        outputText(" doing an odd twitch while a powerful orgasm envelops your body."
            + "\n\n"
            + "Frosty laughs hysterically as you continue to shriek, holding her side with her cock still in you. \"<i>HAHAHAHAHA!!! TALK ABOUT SURPRISE BUTT-SEX!!! Ooooooh, I wish I could see the look on your face when I did that, hehehe.</i>\"  You give Frosty a cold look. \"<i>Oh come on, don’t be like that... tell ya what. I’ll give ya another cumming... on the house, of course.</i>\""
            + "\n\n"
            + "You continue to stare at her with those cold eyes, her smiling back at them, hoping you’ll accept this apology of hers. You stare at her a bit more and then let out a huff of defeat and push your [butt]  back against her crotch as way of saying 'apology accepted'."
            + "\n\n"
            + "You re-brace yourself as Frosty grabs onto your [hair] this time. You arch your back in pain as it causes you to be pushed harder against the sex toy, whininh a little in agony. As that devilous nymph begins rocking back and forth, you can feel the object move in you."
            + "\n\n"
            + "It moves only few inches on your onsides. Your mind starts racing with pleasure as Frosty’s other hand wanders over your [breasts] and pinches on your [nipple], pulling and twisting it and taking nice hard grabs at your [breasts]. A familiar build-up forms down in your crotch, and you start pushing back against Frosty’s \"cock\" to hurry up the climax and start pinching your other [nipple] mimicking the same action as the torturous nymph does, abusing the sensitive bud all in the name of sexual pleasure."
            + "\n\n"
            + "Frosty pushes your chest against the counter and starts thrusting more of the horsecock in and out of you, slapping her pink thighs against your [butt] with every push. A whole foot of the hot sex toy is being thrusted in with a loud smack and pulled back out with a moan from you.  Both of you keep twisting your nips, the desert hot wooden counter top warms your chest and stomach, pushing the hands harder against your body. She starts taking stronger thrusts, pulling at least two feet of the strap-on out of you and shoving it back in with echoing slap of flesh.  Your moans grow faster and her breath gets hotter, and at the next moment ");
        if (player.hasCock() && player.hasVagina()) outputText("your sexes release a huge mix of male and female cum, making a huge mess by your feet.")
        else if (player.hasCock()) outputText("your [cock] shoots out streams of white baby batter.");
        else if (player.hasVagina()) outputText("your [vagina] gives one last quiver and twitches, releasing a gusher of girl-cum down your thighs.");
        else outputText("you feel an orgasm building up in your groin and then releasing a glow of ecstasy across your whole body.");
        outputText("\n\n"
            + "Frosty makes a satisfied sigh and thrusts her hips again to make sure you're satisfied too. She releases your hair, your head thudding against the countertop. She snaps her fingers again and the toy shrivels out of your [ass] and dangles back to between her ankles, leaving your [asshole] gaping wide open."
            + "\n\n");
        outputText("\"<i>Now that I think about it, I should have used some form of lube... oh well, it got the job done anyway. Woudn’t you agree, [name]?</i>\""
            + "\n\n"
            + "You agree with a wave of the hand, still exhausted and riding the wave of pleasure. She laughs at your half-hearted 'yes' and walks over to the other end of you to whisper in your ear: \"<i>If I were you, I would get up and leave soon, otherwise that guy with a huge knot behind you is gonna think your butt-hole is a part of the display.</i>\""
            + "\n\n"
            + "You quickly turn onto your backside, feeling yourself knocking an eager cock off its course. A dog-morph stands there with the biggest knotted cock you've ever seen. You quickly gather all your things and make you way past him. He looks at Frosty, wanting her to relieve him of his stresses. You hear Frosty say: \"<i>All you have to do is sign these.</i>\"\n\n");
        player.sexReward("no", "Anal");
        doNext(camp.returnToCampUseOneHour);
    }

    private function frostySpanking():void {
        clearOutput();
        outputText("You point at the service you've chosen. Frosty looks down at it and her eyes go wide. She quickly pulls a clipboard that is holding a decent stack of paper in place, from the under counter. The worried nymph flips through the papers, stopping at one of the pages towards the back. Her finger scans down the paper, and stops. She looks over the paper and then down at the service you selected. She gulps down the worry look on face and tries to smile \"<i>So you <b>do</b> have enough points for that service... hehehehe...</i>\" She nervously tries to giggle \"<i>Are there ANY other services you would be interested in, like one that isn’t this one?</i>\""
            + "\n\n"
            + "She doesn’t seem to like this service, are you sure you want her to go through this?");
        doYesNo(spankingYes, spankingNo);
    }

    private function spankingNo():void {
        clearOutput();
        outputText("She wipes the worry off her brow and goes back to her happy face.\n\n");
        frostySpecialsMenu();
    }

    private function spankingYes():void {
        clearOutput();
        outputText("You tap your finger over the \"Spanking\" text."
            + "\n\n"
            + "\"<i>Sooooooo... do you want to spank me or would you prefer me to spank you?</i>\"");
        frostyPoints(-100 * (flags[kFLAGS.FROSTY_TIMES_SPANKED] ? 2 : 1));
        menu();
        addButton(0, "Spank Her", spankHer);
        addButton(1, "Get Spanked", getSpanked).disableIf(!player.hasPerk(PerkLib.Masochist), "Req. 'Masochist' perk!");
    }

    private function spankHer():void {
        clearOutput();
        outputText("You give her a look, saying \"Did you seriously just ask that?\". She gets the point, and reluctantly agrees with you, mumbling under her breath anout why she even added stupid-ass spanking in the first place."
            + "\n\n"
            + "Frosty pulls a big fancy chair out from under the counter, carries it over to the side of the booth and plops it down. It’s a bit \"crooked\" when she puts it down and she continues to adjust the chair until it’s \"straight\". She’s obviously procrastinating, you clear your throat and say you don’t mind sitting on a \"crooked\" chair. She quickly takes her hands off the chair, getting caught in the act, so to speak.  She gestures to the chair’s cushion, wanting you to sit but you sense there is something missing. You walk over to the counter and reach under there. "
            + "\n\n"
            + "\"<i>THAT FOR EMPLOYEES ONLY!!!</i>\" Frosty nervously looks at you and tries to stop you, but it’s too late. Your hand has already found you were looking for. Grabbing onto its handle, you pull it out to the light of day, much to Frosty’s horror."
            + "\n\n"
            + "It’s a paddle that has nicely sized holes in it to counter air resistance and a few dull metal studs embedded in the wood between the holes to leave some marks on the flesh it abuses. Done examining the fine piece of wood, you lightly smack it against the palm of your hand and look over at Frosty."
            + "\n\n"
            + "\"<i>Oh... I wonder where that came from... heh...?</i>\"   You take a look at the handle and you can see that it has a label. \"<i>Property of Frosty Cakes.</i>\" is written there in fancy calligraphy. Yeah, you \"wonder\" too. You caught this bitch red-handed trying to cheat you out of your full service, well that isn’t gonna be the only thing that red ass on her won’t fix."
            + "\n\n"
            + "You scuff past her, and Frosty flinches at the air of authority that surrounds you. You take a seat on the chair and pat for her to take her place. As Frosty prepares to lay herself across your lap, you see that she still has her bikini-bottom protecting her luscious rump. You tell her that she must first remove the offending garment. The spanking you have in mind for her is going to have her bare, allowing you to see the progress of changing her bright-pink skin into a more appealing red color. She nervously fiddles with the strings and soon is standing ass naked, trying to avoid your eyes like a child who knows they’re about to be punished."
            + "\n\n"
            + "She stands in front of you, hoping that you’ll change your mind in your mind in the last second. NOPE! You grab her by the wrist and forcefully bend her across your lap. She squirms a little, but she settles down for you. After all, she can’t back out of a contract.  You rub and squeeze her delicate ass, it feels warm, soft, and overall nice to touch. She makes little whimpers, readying her body for your abuse."
            + "\n\n"
            + "You release your grip on her cheeks and raise the paddle high into the air for a dramatic effect, holding it up there for moment and watching Frosty shake in fear. You slam down on her with everything you got. <b>WHACK! WHACK! WHACK!</b> Frosty quickly covers her mouth with her hands over to muffle the screams and groans of her pain, wrenching her body to adjust to this affliction.  Three more slaps of the paddle and her pink ass is starting to display a slight red blush."
            + "\n\n"
            + "However, it's only the beginning. You want to make it into a crimson glow. Another four quick slaps, and tears start to stream down her face as she lightly sobs into her hands. <b>WHACK!</b> You do another nice hard smack on the tenderized flesh. Frosty is now babbling into her hands now, drop of her tears dripping out of her hands."
            + "\n\n"
            + "\"<i>PLEASE STOP!!!!! I’LL REFUND YOUR POINTS JUST PLEASE STOP!!!</i>\"  You whack her ass again, ignoring his pleas and listening to her unmuffled shriek. She covers her abused butt with her sopping wet hands and is now begging for you to stop. \"<i>I’ll give you any other service for free, JUST PLEASE STOP!!!</i>\""
            //There’s a devious idea  you could with that free service, wonder how happy she’ll be if you wanted that service to be anal?
            ////Okay, there WAS an option to fuck her abused butt for corrupts/masochist. But it wasn't written, so I removed it. - SH
            + "You give a stern wack on her knuckles, she quickly retreats her hands from her tender bottom. Defeated in her attempts, the most she can do is bite on her knuckle now, continuing to take your harsh attacks on her tender bottom while tears of agony drip off her face. <b>WHACK-WHACK-WHACK-WHACK!</b>"
            + "\n\n"
            + "\"<i>...you’re so cruel...</i>\" she whimpers. You give her red bottom five more smacks, making her voice falter mid-sentence. Her cries of pain becoming mere little whimpers. Perhaps her voice got tired of screaming and crying or her ass is just numb to the pain now.  Her derriere is now the lovely crimson red you desired her to have, almost looking like sun-burn. You cease your attacks, letting the numbness of her pain subside and allow the feeling to return to her abused bum. She has calmed down too, still sobbing a little, as the pain lingers slightly. You rub your hand over this the raw red flesh, the heat of her body repairing the damage radiates off her, as you feel the small divots the dull studs made from each strike. You a poke a finger into the tender area and the abused nymph grunts of pain. Yep, she isn’t going be sitting right for a days. You tell her you’re done."
            + "\n\n"
            + "\"<i>Thank you... *sob*... thank you, sweet, merciful Marae...</i>\" She weakly gets on her feet and gently walks her way back to the stand, her steps staggered as she tries to walk in a way that doesn’t hurt too much."
            + "\n\n"
            + "\"<i>Hey! Nice ass, honey!</i>\" A passing by red mouse girl sees Frosty’s red and checkered ass and gives the bottom a nice hard clawed hand slap on the toosh. Frosty yelps like a bitch and zooms into the bakery, leaving the Mouse-girl in the wake of a pink whoosh. You smirk at the confused mouse-girl whose fur is now wind blown to one side. Maybe Frosty has some creams or potions in the bakery to heal what you just did to her.");
        dynStats("lus", 20, "scale", false);
        ++flags[kFLAGS.FROSTY_TIMES_SPANKED];
        outputText("\n\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function getSpanked():void {
        clearOutput();
        outputText("She lets out a huge sigh of relief, her entire body relaxing after hearing these good news, then a wicked grin cracks across her face."
            + "\n\n"
            + "\"<i>Ohhhh... so you’ve been a naughty boy/girl? Well I know what to do with the likes of you.</i>\""
            + "\n\n"
            + "She reaches under the table and throws a fancy chair on the ground next to her stand. Then walks from her side of the counter, holding something behind her back and having an impish smile on her face."
            + "\n\n"
            + "\"<i>I got a surprise for you!!!</i>\""
            + "\n\n"
            + "The devilish nymph quickly shows what she’s  hiding. It’s a paddle that has nicely-sized holes in it to counter air resistance and a few dull metal studs embedded in the wood between the holes to leave some marks on the flesh it abuses.  Frosty’s full name is written in fancy calligraphy on the handle. The amount of pain and torment that thing can do to your [ass] makes you bite your bottom-lip in anticipation. Your pink soon-to-be abuser sees that look of lust in face."
            + "\n\n"
            + "\"<i>Heheh.. Its so rare that someone picks this service, I think you’re the first one. Good thing too, I thought I actually wasted gems buying this paddle.</i>\""
            + "\n\n"
            + "She gives a light tap of the paddle on her hand, making a soft slap. Oh, you can imagine it already slapping against your naughty ass, you need to be punished! You let out a desired sigh as Frosty grabs your wrist and leads you to her chair. Your master takes a seat on her throne and pats on her lap for you to take your lonely place across it. You strip out of your [armor], even the top half you didn’t need to take off. You don’t want anything distracting you from the pain. Eagerly bending yourself over her, you position your ass for the maximum exposure and abuse. She compliments your [ass], giving it light strokes and boring squeezes."
            + "\n\n"
            + "\"<i>Come on already!!!</i>\" You shout at her, making her giggle at your eagerness for this abuse."
            + "\n\n"
            + "She raises the paddle slowly, you start to ");
        if (player.hasCock()) outputText("grow hard");
        if (player.hasVagina()) {
            if (player.hasCock()) outputText(" and ");
            else outputText("get wet");
        }
        if (!player.hasCock() && !player.hasVagina()) outputText("feel aroused");
        outputText(" with every inch she raises it. Higher and higher it goes, above her head and as far as her arm can strech. She's holding it high in place, watching you squirm and writhing, awaiting this pain you so rightfully deserve."
            + "\n\n"
            + "<b>WHACK!</b> The paddle hits in pleasurable pain. You moan out as you throw your head back. Soon there are three quick slaps to your rear, every slap feels like its own orgasmic wave of pleasure; like a tsunami, it spreads throughout your body. From the top of your head to the tips of your " + (player.isNaga() ? "tail" : "toes") + ", you shake with pleasure and sweat in pain. Your sexy bits are brimming with arousal in the wake of these waves. Three more quick whacks give you a burst of lust that you could just overdose on. You start panting with your tongue out as your eyes begin to form tears in reaction to the pain, trying to betray your true feelings."
            + "\n\n"
            + "<b>WHACK! WHACK! WHACK! WHACK!</b> You moan again as tears continue to stream down your face");
        if (player.hasCock() || player.hasVagina()) outputText(" and your ");
        if (player.hasCock()) outputText("[cocks]");
        if (player.hasCock() && player.hasVagina()) outputText(" and ");
        if (player.hasVagina()) outputText("[cunt]");
        if (player.hasCock() || player.hasVagina()) outputText(", getting closer to" + (player.hasCock() && player.hasVagina() ? "their" : "its") + "climax, aching with pain-fueled lust and pleasure");
        outputText("."
            + "\n\n"
            + "Frosty becomes a spanking machine cranked up to its maximum! Your " + (player.isNaga() ? "tail" : "toes") + " curl up as your bottom is brutally and mercilessly tortured by this baker’s studded paddle. The moans of gleeful pleasure that roar through your throat are overcomed the hard, smacking sound of wood on the glowing-red flesh. Even as " + (player.isGenderless() ? "a phantom orgasm rips through your body" : "you cum like a gusher") + ", Frosty is chastising your ass like a nanny. Your euphoric state has you sprawled out over Frosty’s pink thigh as she starts to gently paddle your rear, every second she gets slower with her punishing thwacks. Then she stops with her paddle high in the air."
            + "\n\n"
            + "\"<i>Ok, [name], that’s all the time you have with this service. Oh, look at your tushy! It’s bright and glowing, I bet it hurts like a dragon throat!</i>\" Yes, it hurts sooo good. The stinging pain resonating from your butt-cheeks feels like it alone would make you cum again. You get up off her lap and put your clothes back on, a hard wave of pain shot throughout your body as you get your pant back on. So good, you feel like you want to sit and squirm in your seat."
            + "\n\n"
            + "Frosty waves goodbye to you as you walk away from her booth, surprisingly, no line has lined up after you had been serviced.");
        player.sexReward("no");
        doNext(camp.returnToCampUseOneHour);
    }
}

}