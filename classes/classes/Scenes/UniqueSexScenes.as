/**
 * ...
 * @author Liadri
 */
package classes.Scenes
{
	import classes.*;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.Scenes.Areas.Mountain.HellHound;
	import classes.Scenes.Areas.Mountain.InfestedHellhound;
	import classes.Scenes.Areas.Mountain.Minotaur;
	import classes.Scenes.Areas.Ocean.SeaAnemone;
	import classes.Scenes.NPCs.Anemone;
	import classes.Scenes.Places.Mindbreaker;
	import classes.Scenes.Quests.UrtaQuest.MinotaurLord;

	public class UniqueSexScenes extends BaseContent
	{

		public function UniqueSexScenes()
		{
		}

		public function alrauneExtraSceneWithHollicyntiaTentacleDuel():void {
			clearOutput();
			outputText("As you ponder how you will deal with Hollicyntia’s behaviour today, you catch a glimpse of her checking out your vines. Holli seems to be comparing her vines with yours, evaluating size and length thoroughly like a boy in a shower room. As if that upstart could rival your floral perfection!\n\n");
			outputText("\"<i>These are big and healthy, but mine are better!</i>\" she taunts, evidently trying to rile you up.\n\n");
			if (player.isLiliraune()) outputText("Your twin responds right away clearly upset \"<i>As if! Twice the girl, twice the pleasure! You’re just jealous that I get to literally enjoy having an orgy partner all day long! If the both of us worked you up you would not even last a minute before melting in your tree little sis!</i>\"\n\n");
			else outputText("Surely not! You bet you could fuck your sister’s brains out before she actually managed to get you off. With confidence you issue her a challenge, your vines raised around you. Here’s the deal, both of you will try to fuck each other silly, and whoever orgasms first loses!\n\n");
			outputText("\"<i>Deal! I will prove to you, dear sister");
			if (player.isLiliraune()) outputText("s");
			outputText(", that my stamens are the best in this garden.</i>\"\n\n");
			outputText("You vines lunge at Holli’s nectar pot as her own zero in on yours, and soon you’re tentacle fucking each other in earnest in an attempt to make the other orgasm first. You start by hammering your stamen in her pussy, but she swiftly counter-attacks by blooming her stamen in a dozen tendrils right inside your vagina, each one wriggling independently. Two can play at this game however, and you let out a cloud of pollen, letting it reach her nose and drive her into a lust crazed haze as you ready your other vines. She surprises you by pulling you into a tight embrace, mashing the both of your nectar dripping breasts together. You fuck her ass and grope her breast with your remaining vines, forcing her to restart the offensive with a chest assault of her own.");
			outputText(" The ")
			if (player.isLiliraune()) outputText("three");
			else outputText("both");
			outputText(" of you are moaning like wanton whores and lost in sensations by now, but neither of you want to lose to the other in this desperate duel of endurance and sexual skill. Soon your mind is going blank from the vigorous fucking, but you don’t care. You won’t allow yourself to orgasm before Holli does. Eventually, unable to hold anymore, the ");
			if (player.isLiliraune()) outputText("three");
			else outputText("both");
			outputText(" of you scream your defeat together as your stamens explode, filling each others wombs to the brim. There’s so much liquid pollen pumped into you and you can feel your bloated stomach groan under the pressure. You can’t help but cup it with your hand in motherly delight. Holli isn't looking any better, it will probably take hours for her belly to deflate.\n\n");
			outputText("\"<i>I... want a rematch...No way I'll stop at a tie!</i>\"\n\n");
			outputText("That won’t be today though. You're so packed up with plant cum that without even checking your odds, you're pretty sure you are pregnant. You doubt Holli can hold any more of your pollen either, so you dress back up, highly satisfied and somewhat smug, leaving Holli to her personal frustration.");
			player.sexReward("cum","Vaginal");
			player.sexReward("cum","Anal");
			player.sexReward("cum","Lips");
			player.sexReward("vaginalFluids","Dick");
			player.sexReward("saliva","Dick");
			player.sexReward("Default","Dick");
			if (player.isLiliraune()){
				player.sexReward("cum","Vaginal");
				player.sexReward("cum","Anal");
				player.sexReward("cum","Lips");
			}
			statScreenRefresh();
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			doNext(camp.returnToCampUseOneHour);
		}

		public function TreeWayRapeLiliraune():void {
			clearOutput();
			outputText("With your foe on the ground before you, you feel a familiar warmth rushing through you, making you blush purple as fantasies of filling this woman with your progeny overcome you. You smile mischievously at your twin sister.\n\n" +
					"\"<i>Hey sister, feel like going for a threeway, including pollination?</i>\"\n\n" +
					"\"<i>Sure, and she looks just like the kind of girl I'd like to relieve me of my load.</i>\"\n\n" +
					"Resolving to make your dreams a reality, the pair of you loose a spray of pollen for your victim to slowly inhale as it lays thick in the air...\n\n" +
					"Her face flushes rapidly as her expression gradually turns to that of a bitch in heat, ready for pollination as your aphrodisiacs fill her with pink thoughts. " +
					"You and your sister help your soon-to-be bride of the day to climb up into the nectar bath, allowing her to get a full whiff of your intoxicating scent from the source, " +
					"something she eagerly does. When you're sure she’s sufficiently entranced you start with a sweet kiss, pulling her into your arms as you sister massages and plays with her breasts.  " +
					"Meanwhile, with the prey distracted, you ready your many stamen mounted vines for the incoming pollination.\n\n" +
					"You and your sister share a bath with her, washing her body thoroughly with your syrupy nectar until she’s as slimy and ready as the two of you are. " +
					"Your ambient pollen and various aphrodisiacs only serve to turn her on more, her skin a flushed shade of pink under your sticky nectar, making her squirt from the smallest stimulation, like your heated breath against her neck, or your sister’s hands toying with her nipples. " +
					"The two of you caress her skin, making sure not to leave any area untouched, as you pull your vines into the bath, slowly aligning your cunnies and hers with your stamens.\n\n" +
					"She lazily gasps in surprise and delight as you insert yourself in her, filling her ass and cunt in just the perfect way with your thick vines. You aren't left wanting either, " +
					"expertly fucking your pussies in a way only your own stamens can manage. The three of you moan together as your stamens work both your and her holes in perfect synchronization. " +
					"While you and your sister are in control, you aren’t sure whether you’re more enthusiastic about fucking the woman’s cunt or fucking your own, " +
					"as you can feel every stamen and the two cunts from your body that much more sharply. " +
					"Not that it matters at all as long as all these holes are filled with pollen by the end.\n\n" +
					"\"<i>Ahhh sis! It's like fucking with three dicks except you also feel two in your own pussy! Ahhhhn!!!</i>\"\n\n" +
					"\"<i>I’m completely losing it! I think I’m going to cum!</i>\"\n\n" +
					"Nectar and pussy juice mix in the bath, as the trio of you, reach orgasm after orgasm, pumping your respective bodies full of liquid pollen. " +
					"Reaching your peak for the last time with a shuddering cry, you slowly pull the girl out of your flower and deposit her back on the ground, " +
					"leaving her unconscious but satisfied as you caress her belly still full of your pollen. " +
					"You look back at your twin to confer with her.\n\n" +
					"\"<i>You think it took?</i>\"\n\n" +
					"\"<i>Oh, I’m positive it did… she should be giving birth to our seedling in no time.</i>\"\n\n" +
					"Your bellies aren’t any better, though the pregnancy will soon move down to the pitcher, " +
					"and you fantasize at the idea of giving birth, the two of you hoping for the best as you head back to camp.");
			player.sexReward("cum","Vaginal");
			player.sexReward("vaginalFluids","Dick");
			player.sexReward("saliva");
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function TagTeam():void {
			clearOutput();
			outputText("With your foe on the ground beneath you, you can’t help but think you’ve finally found a stamen to fertilize yourself with! " +
					"You grin at your sister, voicing your line of thought.\n\n" +
					"\"<i>Think he can fertilize us good?</i>\"\n\n" +
					"\"<i>If he can feed our two pistils sure, but I want the first turn.</i>\"\n\n" +
					"Without waiting for any longer, the two of you proceed to grab him with your vines and pull him toward your waiting flower. " +
					"He violently struggles to escape as you pull him ever closer to the pool, all the while you and your sister giggle at his desperate attempts to get away.\n\n" +
					"\"<i>Look sister, he's trying so hard to escape. I love these guys.</i>\"\n\n" +
					"\"<i>You can’t run away silly, not from our vines. There's no way you will make it, tied up like this… Mmmmmmm, that and the fact your resistance only makes us hornier.</i>\"\n\n" +
					"All good things must come to an end however, and entertaining as it is, you want to pollinate now, even if your twin will get the first round! " +
					"The both of you release a massive cloud of aphrodisiac pollen toward him, letting him inhale your scent. " +
					"He doesn’t struggle much anymore as his ‘stamen’ betrays him, going erect in seconds, drooling precum at the mere thought of getting a shot at your lovely pair of pussies, " +
					"something you will be more than happy to let him do. Looking at you both with half-lidded eyes, he relinquishes control entirely. " +
					"You finally reel him into your nectar bath and kiss him as your sister lubes up his stamen with your nectar. He makes a cute moan as she prepares him for the next step, " +
					"drooling with delight at the idea of getting what she wants. You sister straddles him right away as you lay against his back feeling your own pussy clench in pleasure as she milks him for his semen. " +
					"Eventually, you both achieve orgasm, her on his dick and you on his ass. Giggling, your sister hands him over.\n\n" +
					"\"<i>It’s your turn sis, please take him in as I take his mouth.</i>\"\n\n" +
					"\"<i>All good, I have it under control. Make sure to kiss him correctly, the last time it didn't feel quite as good for me.</i>\"\n\n" +
					"While your twin takes care of his mouth, unable to wait any longer, you pull him to you, impaling your nectar drenched hole on his cock. You begin to slide yourself up and down, making lewd wet noises as you forcefully milk your former opponent's stamen. Pollination feels so wonderful! You fawn over him, moving into your drugged victim’s open arms and before long, it’s hard to figure out which of you is the most addicted. Your sister suddenly breaks the sloppy kiss, her mouth and his still linked by a strand of saliva, as your mate finally bottoms out and fills your flower with his seed, you and your sister achieve a second orgasm.\n\n" +
					"Highly satisfied, the both of you deposit him back on the ground with little ceremony, half conscious from the massive drug-induced orgasm your pollen put him under. You and your twin can’t help but hope the seed took, " +
					"daydreaming of your children to come as you seal your vaginas shut to prevent the load from escaping.");
			player.sexReward("cum","Vaginal");
			player.sexReward("vaginalFluids","Dick");
			player.sexReward("saliva");
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function Convert():void {
			clearOutput();
			outputText("You watch delighted as [themonster] drops to the ground in defeat. You could have used her as a seedbed, " +
					"but this time around you have other ideas as you raise your stamen mounted vine. ");
			if(player.isLiliraune())
			{
				outputText("Your twin smirks mischievously, she likes this program.\n\n" +
						"\"<i>Um, look at her lovely body; do you think we can make it better?</i>\"\n\n" +
						"\"<i>We sure can! I wonder how she'll look once the pleasure ravages her.</i>\"\n\n");
			}
			outputText("Terrified of you, she tries to crawl away, but your vines firmly grip her and pull her toward you. " +
					"your victim screams, claws and struggles in all the ways she can, but your vines finish binding her in place as your last free vine moves towards her pussy. You ");
			if(player.isLiliraune()) outputText("and your sister both ");
			outputText("moan in pleasure as the tentacle tip blooms open into a flower mounted by a hard stamen. It begins to slowly leak a purple fluid, a sign of your corruption, " +
					"as you approach it from the wanton slut slit. Unable to escape and immobilized like she is, she can only beg as your stamen suddenly starts leaking its liquid corruption into her pussy, " +
					"flooding her womb until her belly looks pregnant with your corrupted fluids. She resists for a moment, but it is short-lived as her body begins to change color to light green, " +
					"spreading from her already nectar gushing pussy of which the amber brew mixes with your fluids. She moans and drools nectar as her hair is replaced by grass, and her body becomes progressively closer to that of a plant morph, " +
					"her overflowing pussy drenching the ground from which corrupted grass begins to grow. Unsatisfied with your stamen in her pussy, " +
					"she yanks at a vine, forces it open and shoves it in her mouth with an eye crossed glaze. You can’t hold the pleasure at bay anymore, " +
					"cuming both inside and outside as the bitch grows her floral hair ornament, finishing her transformation into a dryad.\n\n");
			if(player.isLiliraune())
			{
				outputText("\"<i>Mmmmm, look how good she looks now! I’d eat her flower anytime.</i>\"\n\n" +
						"\"<i>Except we already did, sister, she doesn’t look like she will wake up anytime soon either.</i>\"\n\n" +
						"The two of you chuckle, turning people into messes like these is so much more fun with each other around. ");
			}
			outputText("Satisfied with your handiwork,");
			if(player.isLiliraune()) outputText(" the both of");
			outputText(" you depose your newest adopted daughter on the ground, who swiftly wakes up and looks at ");
			if(player.isLiliraune()) outputText(" the pair of");
			outputText(" you with eyes full of adoration." +
					"\"<i>Thank you so much, I’m so happy! Let me repay you by spreading this gift to everyone I can!</i>\"\n\n" +
					"Aw, ain’t she grateful. She stands up in a rush, having spotted a somewhat terrified imp. She proceeds to run after it, screaming." +
					"\"<i>Stop running away and fuck my flower!!!!</i>\"\n\n" +
					"You giggle and shrug. How your newest daughter enjoys her new life is none of your concern. " +
					"You head back to camp as she begins to forcefully rub the imp’s stamen for his pollen.");
			player.sexReward("vaginalFluids");
			player.sexReward("saliva");
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function AlrauneDungeonBadEnd():void {
			clearOutput();
			outputText("Unsure of what to do with you, your captors decide to keep you home as a decorative, if not, a perverted plant." +
					" While you have, for security reasons, been limited to the boundary of a single room to which you have been magically forced to take root," +
					" your life is not any less interesting than it was prior to your defeat as a good amount of people come in and out daily to harvest your aphrodisiac nectar, get seeded, pollenize you or a mix of all three." +
					" You were quickly repurposed as a lusty if efficient dungeon guardian, always ready to rape anything stupid or horny enough to come within reach of your vines.");
			if(player.isLiliraune()) outputText(" When you’re not busy raping intruders or using the dungeons many denizens as your seedbed or cum dumps you spend the days of your quasi-infinite lifespan having sex with your twin in the middle of your pitcher, ever ready to invite whoever enters the room next for a threesome.");
			outputText(" They kept feeding you nutrients, and you gave them sex and nectar in return. The perfect deal right?\n\n" +
					"As the days pass your vines slowly began to grow and exceed the range of the walls of your confinement room, " +
					"turning what used to be a dungeon into a garden where your vines have become a network of tendrils, always seeking a pussy or ass to fuck. You eventually seize the dungeon in full, " +
					"forcing the original denizens of the place to build new quarters away from your influence as your canopy of rape-happy vines stretch ever further. " +
					"At first, they tried to prune your growth but eventually perhaps due to negligence you slowly got past the point at which you could be contained, your many vines capturing people alive to add ever more vessels to serve as your personal seedbeds. Without any further opposition, this place swiftly turned into a nursery for your many seedlings. " +
					"Your canopy of vines spread so far it's sometimes difficult for you to know just how many people you are fucking at the same time. " +
					"Your mind has, over time, become accustomed to this gigantic network of constant fucking and orgasms, allowing you to stay clear-headed at all times as you copulate with your many entwined victims.\n\n" +

					"One day some human woman in armor with a magic sword managed to get past your many daughters and enter your chamber, claiming that she is the champion of some town called Ingnam... Why does that feel familiar? " +
					"You should remember this… While the name of the place might’ve had some relevance to you in the past, you have been here for so long that you have since forgotten. She says she is here to defeat the ‘Verdant Queen’." +
					" A title the locals have given you perhaps?\n\n" +

					"You care little for her speech however as you grab her with several of the vines that cover the place,");
			if(player.isLiliraune()) outputText(" you and your twin");
			outputText(" licking your lips in delight. It has been many years since one made it this far.\n\n");
			if(player.isLiliraune()) outputText("\"<i>Oh my! Isn’t she cute? Came all the way down here just to play with us</i>\"\n\n" +
					"\"<i>How about you tell us your name before we fill you full of stamens and make you forget it? It just so happens to be very lonely here, and we definitely will never let you go. You’re way too convenient for that.</i>\"\n\n" +
					"The both of you giggles");
			else outputText(" You giggle");
			outputText(" as you reel in the girl who fight back, tooth and nail to get free, hacking and slashing until the overpowering scent of your pollen and ripe nectar puts an end to her resistance, " +
					"your vines reeling her into your pitcher to ready her flower for pollination. " +
					"Nowadays, the only things you ever get to pollinate are demons or your own daughters and the flower of a pure human is a delicacy. " +
					"You could say that for her this is…");
			EventParser.gameOver();
		}

        public function get sceneMenu():Array {
			var menuItems:Array = [];
			menuItems.push.apply(this, USSTailRape());
			menuItems.push.apply(this, USSTailpeg());
			menuItems.push.apply(this, USSSnRape());
			menuItems.push.apply(this, USSVoltTsf());
			menuItems.push.apply(this, USSHeatTsf());
			menuItems.push.apply(this, USSCooldown());
			menuItems.push.apply(this, USSStlWmth());
			menuItems.push.apply(this, USSGobMech());
			menuItems.push.apply(this, USSBrainMlt());
			menuItems.push.apply(this, USSAlrauneSS());
			menuItems.push.apply(this, USSEastrBny());
			menuItems.push.apply(this, USSTentRape());
			menuItems.push.apply(this, USSLiveDildo());
			menuItems.push.apply(this, USSJiangshiDrn());
            return menuItems;
        }

		public function pcUSSPreChecksV2(backFunc:Function, btnPos:int = 13):void{
            //uncomment if it's REALLY needed
			if (pcCanUseUniqueSexScenes())
				addButton(btnPos, "U.Sex Scenes", openUSSmenu, backFunc).hint("Other non-typical sex scenes.");
			else
				addButtonDisabled(btnPos,"U.Sex Scenes", "You don't qualify for any Unique Sex Scenes.");
		}

        public function pcCanUseUniqueSexScenes():Boolean {
			if (player.hasPerk(PerkLib.ElementalBody)) return false;
            if (RaijuOverLust(true)) return true; //special for supercharged Raiju
            else return menuActiveButtons(sceneMenu) > 0;
        }

		//Use above for special cases.
		public function openUSSmenu(backFunc:Function = null):void{
			//special for supercharged Raiju
			if(RaijuOverLust(true)) {
				RaijuOverLust();
			}
			else{	//normal menu
				var menuItems:Array = sceneMenu;
				if (backFunc == null) backFunc = camp.returnToCampUseOneHour;
				menuGen(menuItems, 0, backFunc);
			}

        }

        //checking functions ===========================================================================
        private function RaijuOverLust(check:Boolean = false):*{
            if (player.statStore.hasBuff("Supercharged") && !monster.hasPerk(PerkLib.LightningAffinity) && !monster.hasPerk(PerkLib.LightningNature)){
                if(check) return true;
				else{
					clearOutput();
					menu();
					if(!player.hasVagina() || !player.hasCock()) raijuVoltTransfer();
					else RaijuRapeSupercharged();
				}
            }
			else if(check) return false;
        }

        private function USSTailRape():Array{
            var btnSet:Array = ["Tail Rape"];
            if (player.tailType == Tail.MANTICORE_PUSSYTAIL && monster.hasCock()) btnSet.push(manticoreTailRapeScene,"");
            else btnSet.push(false,"Req. to have Pussytail and enemy with cock.");
            return btnSet;
        }
        private function USSTailpeg():Array{
            var btnSet:Array = ["TailPeg"];
            if (player.tailType == Tail.HINEZUMI || player.tailType == Tail.SALAMANDER) {
                if (monster is Anemone || monster is SeaAnemone || monster is HellHound || monster is InfestedHellhound) btnSet.push(false, "Req. enemy to have anus.");
                else btnSet.push(hinezumiTailpegScene, "");
            }
            else btnSet.push(false, "Req. to have Hinezumi Tail.");
            return btnSet;
        }
        private function USSSnRape():Array{
            var btnSet:Array = ["Strangle and Rape"];
            if (player.gender != 0 && (player.tailType == Tail.HINEZUMI || player.tailType == Tail.MOUSE || player.tailType == Tail.DEMONIC)) btnSet.push(strangleAndRapeScene, "");
            else btnSet.push(false, "Req. to be non-genderless with hinezumi, mouse or demon tail.");
            return btnSet;
        }
        private function USSVoltTsf():Array{
            var btnSet:Array = ["Volt Transfer"];
            if ((player.raijuScore() >= 10 || player.thunderbirdScore() >= 12) && !monster.hasPerk(PerkLib.EnemyHugeType) && !monster.hasPerk(PerkLib.EnemyGigantType) && !monster.hasPerk(PerkLib.EnemyColossalType) && !monster.isAlraune() && !monster.isDrider() && !monster.isGoo() && !monster.isNaga() && !monster.isScylla() && !monster.isTaur()) btnSet.push(raijuVoltTransfer, "");
            else btnSet.push(false, "Req. to be Raiju and enemy must be non-gigant humanoid.");
            return btnSet;
        }
        //OverHeat Species (?)
        private function USSHeatTsf():Array{
            var btnSet:Array = ["Heat Transfer"];
            if (player.hasStatusEffect(StatusEffects.Overheat) && !monster.hasPerk(PerkLib.EnemyHugeType) && !monster.hasPerk(PerkLib.EnemyGigantType) && !monster.hasPerk(PerkLib.EnemyColossalType)) btnSet.push(hinezumiHeatTransferScene, "");
            else btnSet.push(false, "Req. to have Hinezumi Coat, over 50% of max lust, enemy must be humanoid and not giant.");
            return btnSet;
        }
        private function USSCooldown():Array{
            var btnSet:Array = ["Cooldown"];
            if (player.hasStatusEffect(StatusEffects.Overheat) && monster.hasPerk(PerkLib.IceNature) && player.hasVagina() && monster.hasCock()) btnSet.push(Cooldown, "");
            else btnSet.push(false, "Req. a cold type creatures with a cock, the overheat perk and a vagina.");
            return btnSet;
        }
        //YukiOnna
        private function USSStlWmth():Array{
            var btnSet:Array = ["Steal Warmth"];
            if (player.yukiOnnaScore() >= 14 && monster.hasCock() && !monster.hasPerk(PerkLib.UniqueNPC) && !monster.hasPerk(PerkLib.EnemyHugeType) && !monster.hasPerk(PerkLib.EnemyGigantType) && !monster.hasPerk(PerkLib.EnemyColossalType) && !monster.isAlraune() && !monster.isDrider() && !monster.isGoo() && !monster.isNaga() && !monster.isScylla() && !monster.isTaur()) btnSet.push(yukionnaStealWarmthScene, "");
            else btnSet.push(false, "Req. to be Yuki Onna and enemy must be: non-gigant, humanoid, with cock, non-unique npc.");
            return btnSet;
        }
        private function USSGobMech():Array{
            var btnSet:Array = [player.hasKeyItem("Cum Reservoir") >= 0 && player.keyItemvX("Cum Reservoir", 1)?"Cum Reservoir":"Fill the reservoir"];
            if (player.isInGoblinMech() && player.hasKeyItem("Cum Reservoir") >= 0 && monster.hasCock()) {
                if (player.keyItemvX("Cum Reservoir", 1) == 4) btnSet.push(false, "Reservoir is already full. You need to use all this stored cum before you harvest new one.");
                else btnSet.push(gobomechFillTheReservoir, "");
            }
            else btnSet.push(false, "Req. to be in goblin mech, having Cum Reservoir upgrade instaled on it and enemy with cock.");
            return btnSet;
        }
        private function USSBrainMlt():Array{
            var btnSet:Array = ["Brain Melt"];
            if (Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_ISMB) btnSet.push(brainMelt, "");
            else btnSet.push(false, "Req. to be a mindbreaker.");
            return btnSet;
        }
        private function USSAlrauneSS():Array{
            var btnSet:Array = [];
            if (player.isAlraune()) {
                if (player.isLiliraune()){
                    if (monster.hasCock()) btnSet.push("Tag Team", TagTeam, "");
                    else btnSet.push("Tag Team", false, "You need to be two person against a male to use this scene.");
                    if (monster.hasVagina()) btnSet.push("Triple Girl Fun", TreeWayRapeLiliraune, "");
                    else btnSet.push("Triple Girl Fun", false, "You need to be two person against a female to use this scene.");
                }
                else {
                    if (player.lowerBody == LowerBody.PLANT_FLOWER && monster.hasCock()) btnSet.push("Get Pollinated", alrauneGetPollinatedScene, "");	//Isn't Alraune supposed to have LowerBody.PLANT_FLOWER to even pass isAlraune?
                    else btnSet.push("Get Pollinated", false, "Req. to have Alraune lower body and enemy with cock.");
                    if (player.lowerBody == LowerBody.PLANT_FLOWER && monster.hasVagina()) btnSet.push("Seeding", alrauneSeedingScene, "");
                    else btnSet.push( "Seeding", false, "Req. to have Alraune lower body and enemy with vagina.");
                }
                if (player.isAlraune() && player.cor >= 50 && monster.hasVagina() && !monster.hasPerk(PerkLib.UniqueNPC)) btnSet.push("Convert", Convert, "");
                else btnSet.push("Convert", false, "You need to be a very corrupted alraune against a non unique female character to use this scene.");
            }
            else btnSet.push("Alraune", false, "You need to be an Alraune.");
            return btnSet;
        }
        //easter bunneh
        private function USSEastrBny():Array{
            var btnSet:Array = ["EGGS!!"];
            if (player.hasPerk(PerkLib.EasterBunnyBalls) && player.hasCock() && player.ballSize > 3) btnSet.push(EasterBunnyLayEggsRape, "");
            else btnSet.push(false, "Req. to be a Easter Bunny.");
            return btnSet;
        }
        private function USSTentRape():Array{
            var btnSet:Array = ["Tentacle Rape!"];
            if (monster.hasVagina() && (player.isKraken() || player.isScylla())) btnSet.push(TentacleRape, "");
            else btnSet.push(false, "You need scylla or kraken tentacles to do this. Only works on female foes.");
            return btnSet;
        }
        private function USSLiveDildo():Array{
            var btnSet:Array = ["Living Dildo"];
            if (player.hasVagina() && (((player.isKraken() || player.lowerBody == LowerBody.HYDRA) && player.tallness*3/2 > monster.tallness) || player.tallness > monster.tallness*2) ) btnSet.push(HumanDildo, "");
            else btnSet.push(false, "To be way taller then your opponent in order to even use this scene.");
            return btnSet;
        }
        private function USSJiangshiDrn():Array{
            var btnSet:Array = [];
            if (player.jiangshiScore() >= 20) {
                if (monster.hasPerk(PerkLib.EnemyTrueDemon)) {
                    if (monster.hasCock()) btnSet.push("Drain him", jiangshiDrainHimTrueDemons, "");
                    else btnSet.push("Drain him", false, "Only male/herm true demon enemies.");
                    if (monster.hasVagina()) btnSet.push("Drain her", jiangshiDrainHerTrueDemons, "");
                    else btnSet.push("Drain her", false, "Only female/herm true demon enemies.");
                }
                if (monster is Minotaur || monster is MinotaurLord) btnSet.push("Drain him", jiangshiDrainHimMinotaurs, "");
                else btnSet.push("Drain him", false, "Only minotaur enemies.");
            }
            else btnSet.push("Jiangshi", false, "You need to be a Jiangshi.");
            return btnSet;
        }

		public function RaijuRapeSupercharged():void {
			clearOutput();
			menu();
			outputText("As [themonster] is defeated, you lose any remaining restraint or shred of rationality you previously had, "+ player.clothedOrNaked("jumping out of your equipment and ", "") + "pouncing on your opponent with your");
			sceneHunter.selectGender(dickF, vagF, null, null, 0);

			//============================================================================
			function dickF():void {
				outputText(" plasma dripping cock already rock hard at the thought of FINALLY finding a hole to plug. Your body is overflowing with latent electricity. Your [cock] throbs in eager anticipation at the thought of pumping your victim with every volt of energy you have.\n\n" +
						"[He] pleads for you to stop, yet in your lust-addled state, the only reply you can manage to give them is an intense stare of unbridled lust. There is nothing to hold you back now, rain would be more likely to flow back into the sky at their command.\n\n" +
						"This poor, unfortunate soul is your long-awaited outlet, and nothing can hold you from unloading every ounce of seed into them. Your presence was warning enough, they had time to run.\n\n" +
						"Before [he] can make any further protest, you plug yourself into [his] "+monster.assholeOrPussy()+", thrusting with wanton abandon as your charge quickly builds up within you. In a moment, you quickly begin unloading surge after surge of electricity into them. The air crackles around you with latent, lustful shocks. You can't help but growl in pleasure.\n\n" +
						"Your poor victim's hole reflexively tightens around you as you continue bucking into them eagerly, the sheer force of your electricity causing them to spasm and quiver beneath your presence. You bring more of your weight upon them as you can feel yourself getting closer to the release that you so crave. Your eyes roll back, causing your vision to white out as you continue unloading all your charge into the make-shift lightning rod.\n\n" +
						"[themonster] continues clenching against you as a familiar pressure and heat builds up within your loins. You let loose a loud grunt as you finally release your load into [him]. Shot after shot of raiju plasma fills up your hapless victim as you steadily regain your senses, and your erection deflates.\n\n" +
						"Finally, you slowly unplug yourself from them, cum slowly seeping out of the broken, twitching mess you've left the [monster] in. Your partner will be a fumbling mess for a while with all that lingering charge in them. Electricity courses around their form as [he] clenches [his] body, still cumming.\n\n" +
						"You no longer have any need to stick around now that your vision is cleared, and your mind is no longer stuck in a fog. You decide to head back to your camp, satisfied.");
				if (monster.hasVagina())
					player.sexReward("vaginalFluids","Dick");
				else
					player.sexReward("default","Dick",true,false);
				player.statStore.removeBuffs('Supercharged');
				player.lust = 0;
				statScreenRefresh();
				cleanupAfterCombat();
			}
			function vagF():void {
				outputText(" plasma dripping pussy juicing itself at the thought of FINALLY getting plugged! Your body is literally overflowing with electricity, and you're about all too eager to unload every last volt into your hapless victim.\n\n" +
						"[He] pleads for you to stop, yet in your lust-addled state, the only reply you can manage to give them is an intense stare of unbridled lust. There is nothing to hold you back now, rain would be more likely to flow back into the sky at their command.\n\n" +
						"This poor, unfortunate soul is your long-awaited plug, and nothing can hold you from dissipating all of your volts in them. Your presence was warning enough, they had time to run.");
				if (monster.hasCock()){
					outputText("Before [he] can make any further protest, you force [his] plug into your overloaded outlet pumping with wanton abandon as your charge quickly builds up within you.");
					if(player.vaginalCapacity() < monster.cockArea(0)) outputText(" Damn, [his] plug is massive. You barely manage to force [him] in, but there's no helping it. It's that or going about a few extra hours as a lust crazed lunatic, and you'd prefer the former.");
					player.cuntChange(monster.cockArea(0), true);
					outputText(" In a moment, you quickly begin unloading surge after surge of electricity into them. The air crackles around you with latent, lustful shocks. You can't help but growl in pleasure.\n\n" +
							"Your poor victim's cock reflexively twitches around your walls as you continue pumping it eagerly, the sheer force of your electricity causing them to spasm and quiver beneath your presence." +
							" You bring more of your weight upon them as you can feel yourself getting closer to the release that you so crave." +
							" Your eyes roll back, causing your vision to white out as you continue unloading all your charge into the make-shift lightning rod.\n\n" +
							"[themonster] continues clenching against you as a familiar pressure and heat builds up within your loins. You let loose a loud grunt as you finally achieve release, shooting all the remaining voltage into your victim's dick as a pool of raiju plasma floods beneath you." +
							" Emptied from your overwhelming lust, you steadily regain your senses as your orgasm ebbs down.\n\n" +
							"Finally, you slowly unplug yourself from them, cum mixed with plasma slowly seeping out of your outlet as you give one last glance at the broken, twitching mess you've left the [monster] in." +
							" Your unwilling partner will be a fumbling mess for a while with all that lingering charge in them." +
							" Electricity courses around their form as [he] clenches [his] body, still cumming.\n\n" +
							"You no longer have any need to stick around now that your vision is cleared, and your mind is no longer stuck in a fog. You decide to head back to your camp, satisfied.");
					player.sexReward("cum","Vaginal");
				}
				else {
					outputText("Before [he] can make any further protest, you force your overloaded outlet into [his] face almost asphyxiating [him]." +
							" Immediately you shoot your first bolt causing [his] mouth to open and [his] tongue to flail wildly right into your box." +
							" You moan in delight as the charge quickly builds up within you. In a moment, you quickly begin unloading surge after surge of electricity into them." +
							" The air crackles around you with latent, lustful shocks. You can't help but growl in pleasure.\n\n" +
							"Your poor victim's overstimulated tongue just twitches around your walls, the sheer force of your electricity causing their entire body to spasm and quiver beneath your presence." +
							" You bring more of your weight upon them as you can feel yourself getting closer to the release that you so crave." +
							" Your eyes roll back, causing your vision to white out as you continue unloading all your charge into the make-shift lightning rod.\n\n" +
							"[themonster] continues flailing randomly as a familiar pressure and heat builds up within your loins." +
							" You let loose a loud grunt as you finally achieve release, shooting all the remaining voltage into your victim's body as a pool of raiju plasma floods into [his] open mouth." +
							" Emptied from your overwhelming lust, you steadily regain your senses as your orgasm ebbs down and that of your victim heads up.\n\n" +
							"Finally, you slowly unplug yourself from them plasma slowly dripping out of your outlet as you give one last glance at the broken, twitching mess you've left the [monster] in." +
							" Your unfortunate partner will be a fumbling mess for a while with all that lingering charge in them, let alone you're not sure they are going to be able to speak again for a while." +
							" Electricity courses around their form as [he] clenches [his] body, still cumming.\n\n" +
							"You no longer have any need to stick around now that your vision is cleared, and your mind is no longer stuck in a fog. You decide to head back to your camp, satisfied.");
					player.sexReward("saliva","Vaginal");
				}
				player.statStore.removeBuffs('Supercharged');
				player.lust = 0;
				statScreenRefresh();
				cleanupAfterCombat();
			}
		}

		public function manticoreTailRapeScene():void {
			clearOutput();
			outputText("While your defeated foe is laying on the ground, you make a sadistic grin as you contemplate the situation. This came just as you got hungry or rather, just as your tail did.\n\n");
			outputText("Kicking [monster him] on [monster his] back you proceed to sit on [monster his] legs to prevent [monster him] from moving. You push everything out of the way as your eyes zero in on the target, his " + monster.cockDescriptShort(0) + ". You sting [themonster] a few times, injecting [monster him] with a pint worth of aphrodisiac. For several seconds, your toy tries to get you off of [monster him] but your poison eventually kicks in and [monster he] falls limp on the ground at your it’s " + monster.cockDescriptShort(0) + " is standing throbbing and erect. Licking your lips, you take it upon yourself to relieve your victim of its pent-up lust, opening your tail and swallowing its entire length inside.\n\n");
			outputText("Smirking with malicious cruelty, you whisper softly in your terrified victim’s ear.\n\n\"<i>Does me eating you whole make it feel like you're dying? Don't worry, I will make you die over and over again until you're dry as an empty husk! From this moment you are my toy, slut!</i>\"\n\n");
			outputText("Soon, your cumpump’s face turns to a tormented expression as your tail forcefully milks him of all his cum, regularly injecting more aphrodisiac to make him orgasm and leak constantly like a hose. Almost ironically, and against [monster him] better judgment the stimulation of your vaginal walls causes [monster his] body to buck up and down in your tail, only making him cum more. On your end, you taste every drop of cum he deposits inside just like you would with your mouth. It is a delicious taste, way different from what cum would have tasted had you been human. However you have another body part that you would like to satisfy and you move your hips to the [themonster] face, shoving your drooling [pussy] in your victim’s face.\n\n");
			outputText("\"<i>Lick me clean you worm! Don’t you see how wet I am?!</i>\"\n\nBoth too terrified and supremely horny to refuse your command, your defeated foe begins to use its tongue to give your sensitive pussy a proper licking. Delighted by the sensations from both of your pussies, you feel like singing your pleasure and to your surprise a series of moans that sound like a song come out from your mouth as you ride orgasm after orgasm, splattering [monster his] crotch and face with your girl juice.\n\n");
			outputText("Only once [monster his] " + monster.ballsDescriptLight() + " have shrunk to the point they look like a pair of raisins do you let go of what's left of [monster him].\n\nYou lick your lips feeling like you just had a five course meal fit for a queen as you leave the body of your passed out opponent on the ground at the mercy of other potential sexual predators.");
			player.sexReward("cum");
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function hinezumiTailpegScene():void {
			clearOutput();
			outputText("You feel like some payback is in order, however, this time around you have something different in mind than your regular antics.\n\n");
			outputText("You walk over [themonster] and wrap your tail around [monster his] neck tightening until [monster he] gasps for air and threateningly adding your next sentence.\n\n");
			outputText("\"<i>You lost and I won. Normally I would leave you alone and go about my business but know what? I don’t feel like it! You see that thing wrapped around your neck? That's my tail and I have an excellent idea of where I'll stick it in. If you try anything out of line I’m going to have you enjoy a real literal anal burn. Keep in mind that my flames only burns when I want or if I’m extra pissed, better not make either happen.</i>\"\n\n");
			outputText("Most creatures on Mareth cares little for being raped, but pain and suffering is a whole different concept. At first [themonster] tenses up in shock then stops struggling not to further incur your wrath. In response to [monster his] you sarcastically taunt [monster him].\n\n");
			outputText("\"<i>That's a good buttslut right there. Now let's have a look at the material I will be having my fun with.</i>\"\n\n");
			outputText("You force [themonster] on [monster his] belly as you sit on [monster his] back releasing [monster his] neck from your tail noose and aiming your now still burning whip-like appendage for a new destination. Your ride shakes a little and you decide to properly tell it to stay still by wiping your tail across [monster his] ass cheeks. [Themonster] screams in pain as your tail leaves a pair of red marks across [monster his] flesh then finally gets the point.\n\n");
			outputText("Once you're well aligned your tail darts in and forces its way through [themonster] welcoming ass hole. You gasp as inch after inch of your tail fills your partner all the way up the bowels. You could even see the bumps of your tail in [monster his] stomach if you wanted to. Now well inside you begin to work that hole, stretching it on your passage. While you rape that anus with your tail your hands aren’t left idle and you use them to fiercely masturbate, well intent on covering the back of your unwilling partner with your own personal markings. You feel [themonster] moan, [monster his] anal ring tightening around your tail, ");
			outputText("as you keep sliding in and out faster and faster with your own impending orgasm. The dam finally breaks as your ");
			if (player.hasCock()) outputText("[cock]");
			if (player.gender == 3) outputText(" and ");
			if (player.hasVagina()) outputText("[pussy]");
			outputText(" make a fine mess on [themonster]'s back. You pull your tail out of [monster his] abused hole utterly satisfied before wiping [monster his] ass once or twice as a parting gift, making [monster him] double in pain. Gosh, it feels so good to put those freaks in their place.\n\n");
			outputText("You head back to camp both morally and physically satisfied of your deeds.\n\n");
			player.sexReward("Default", "Default", true, false);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function strangleAndRapeScene():void {
			clearOutput();
			var cock:Boolean = player.hasCock() && (!player.hasVagina() || rand(2) == 0);
			outputText("As you wonder what to do, you suddenly catch sight of [themonster] attempting to flee. You swiftly wrap your tail around [monster him] neck like a noose and forcefully pull [monster him] back to you.\n\n");
			outputText("You ask where does [monster he] think  [monster he]'s going, as you still have to claim your prize.\n\n");
			outputText("You can see some fear blossom in [monster his] eyes as you begin to choke [monster him] until [monster he] begins gasping pitifully for air, and then you have an idea. You forcefully shove [themonster] on [monster his] back and expose your " + (cock ? "[cock]" : "[pussy]") + " with clear intent.\n\n");
			outputText("When [themonster] does nothing but stare for a few seconds, you ask what [monster he]'s waiting for, lightly tightening your tail around [monster his] neck as a warning to start working or else.\n\n");
			outputText("[Themonster] finally seems to realize [monster his] predicament and panics, immediately moving to lick your" + (cock ? "[cock]" : "vaginal lips") + " in an effort to douse your wrath. That’s way too fast for your tastes, though, and you order your fuckslave to slow down and actually proceed with better care." + ((player.tallness < 60 && player.mouseScore() >= 8) ? " You get a thrill out of this domineering position. It's not every day that the small mouse gets to thoroughly humiliate the cat." : "") + " As you use your opponent’s mouth like a sex toy, you give a quick glance down and spot " + monster.pronoun3);
			if (monster.hasCock()) outputText(" " + monster.cockDescript() + " hardening and twitching");
			if (monster.hasVagina()) {
				if (monster.hasCock()) outputText(" and " + monster.pronoun3);
				outputText("" + monster.vaginaDescript() + " wetting the ground with girl juices");
			}
			outputText("[pg]It seems your victim is getting off from the abuse. Well, it seems you won’t need to worry about [monster him] needs, you figure as you shove your " + (cock ? "[cock]" : "[pussy]") + " harder into [monster his] face!\n\n");
			outputText("Only as you reach your third orgasm do you finally release your victim, ordering [monster him] to scram or else. As [monster he] does just that, you can still see your tail imprints on [monster his] neck, but you don't particularly care by this point. You head home quite satisfied.\n\n");
			if (cock) player.sexReward("saliva", "Dick");
			else player.sexReward("saliva", "Vaginal");
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function alrauneGetPollinatedScene():void {
			clearOutput();
			outputText("With your foe on the ground beneath you, you can’t help but think you’ve finally found a stamen to fertilise yourself with! Without waiting any longer, you proceed to grab him with your vines and pull him toward your waiting flower. He violently struggles to escape as you pull him ever closer to your flower, all the while you giggle at his desperate attempts to get away. All good things must come to an end however, and, entertaining as it is, you want him pollinating you now! You release a massive cloud of your aphrodisiac pollen toward him,  letting him inhale your scent.  He doesn’t struggle much any more as his stamen betrays him, going erect in seconds, ");
			outputText("drooling precum at the mere thought of getting a shot at your lovely pussy, something you will be more than happy to let him do. Looking at you with half lidded eyes, he lets you take control entirely. You finally reel him into your nectar bath and kiss him, lubing up his stamen with your nectar. He makes a cute moan as you prepare him for the next step, drooling with delight at the idea of getting what you want.\n\n");
			outputText("Unable to wait any longer, you pull him to you, impaling your nectar drenched hole on his cock. You begin to slide yourself up and down, making lewd wet noises as you forcefully milk your former opponent's stamen. Pollination feels so wonderful! You fawn over him, moving into your drugged victim’s open arms and before long it’s hard to figure which of you is the most addicted, as you kiss him with the passion of a longtime lover. You break the sloppy kiss, your mouths still linked by a strand of saliva, as your mate finally bottoms out and fills your flower with his seed.\n\n");
			outputText("Highly satisfied, you deposit him back on the ground with little ceremony, half conscious from the massive drugged induced orgasm your pollen claimed from him. You can’t help but hope it took, daydreaming of your children to come as you seal your vagina shut to prevent the load from escaping.");
			player.sexReward("cum","Vaginal");
			player.sexReward("vaginalFluids","Dick");
			statScreenRefresh();
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			cleanupAfterCombat();
		}

		public function alrauneSeedingScene():void {
			clearOutput();
			outputText("With your foe on the ground before you, you feel a familiar warmth rushing through you, making you blush purple as fantasies of filling this woman with your progeny takes you over. Resolving to make your dreams reality, you let loose a spray of your pollen for her to slowly inhale as it lays thick in the air.\n\n");
			outputText("Her face flushes rapidly as her expression gradually turns to that of a bitch in heat, ready for pollination as your aphrodisiacs flood her senses. You help your soon-to-be bride of the day climb up into your nectar bath, allowing her to get a full whiff of your intoxicating scent from the source, something she eagerly does. When you're sure she’s sufficiently entranced you start with a sweet kiss, pulling her into your arms and readying your many stamen mounted vines for the incoming pollination.\n\n");
			outputText("You share a bath with her, washing her body thoroughly with your syrupy nectar until she’s as slimy and ready as you are. Your ambient pollen and various aphrodisiacs only serve to turn her on more, her skin a flushed shade of pink under your sticky nectar, making her squirt from the smallest stimulation, like your heated breath against her neck. You caress her skin, making sure not to leave any area untouched, as you pull your vines into the bath, slowly aligning your cunny and hers with your stamens.\n\n");
			outputText("She lazily gasps in surprise and delight as you insert yourself in her, filling her ass and cunt in just the perfect way with your thick vines. You aren't left wanting either, expertly fucking your pussy in a way only your own stamens can manage. You moan in unison with your partner as your stamens work both your and her holes in perfect synchronization. Nectar and pussy juice mix in the bath, as the pair of you reach orgasm after orgasm, pumping your respective bodies full of fluids. Reaching your peak for the last time with a shuddering cry, you slowly pull the girl out of your flower and deposit her back on the ground, leaving her unconscious but satisfied as you caress her belly still full of your semen.\n\n");
			outputText("Your own belly isn’t any better, and you fantasise at the idea of giving birth hoping it took as you head back to camp.");
			player.sexReward("cum","Vaginal");
			player.sexReward("vaginalFluids","Dick");
			statScreenRefresh();
			player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE);
			cleanupAfterCombat();
		}

		public function brainMelt():void {
			clearOutput();
			outputText("This host is unworthy… totally useless." +
					" Try all you want you couldn't turn it into something useful itd have to be handled by your master but there's one thing you can do." +
					" A nasty shade falls over your eyes as you smile perversely, your victim however want's none of that and has already started to slowly back away from you." +
					"The " + monster.short + " tries to crawl to safety, but before it can get out of your reach, you leap onto [monster his] back and insert your tentacles into [monster his] ears. You orgasm right away your ");
			if (player.hasVagina()) outputText(player.vaginaDescript());
			if (player.hasCock()) outputText(player.cockDescriptShort());
			outputText(" drenching the " + monster.short + " ass in green goop as you plunge into [monster his] memories and experiences drawing out strands after strands of knowledge out of [monster his] brain strait into your own." +
					" Each new memory you take make you cum as you brain overloads with new foreign knowledge." +
					" A normal brain would've been unable to properly process such information and this might have left you confused and unable to distinguish your experiences from the victims own but as you draw out the knowledge and accumulated pleasure of each time the " + monster.short + " has ever cumed eye crossing from the mental overload you easily manage to catalogue those feelings as something out of your own isolating the personality and feelings from the raw knowledge.\n\n");
			if (player.hasVagina()){
				outputText("Your new toy half broken it takes very little efforts to turn [monster him] on [monster his] back and");
				if (monster.hasCock()) outputText(" impale");
				else outputText(" grind");
				outputText(" your needy squirming tentacled pussy ");
				if (monster.hasVagina()) outputText("on her now drenched snatch allowing you to bring yourself to new heights of pleasant delirium.");
				else if (monster.hasCock()) outputText("on his drooling erect cock allowing you to bring yourself to new heights of pleasant delirium.");
				else outputText("on your victim naked belly attempting to draw additionnal pleasure in vain. With your victim devoid of sexual organs thats as good as you will get.");
			}
			if (player.hasCock()) outputText("While you mentaly rape your victim of everything that used to make its sense of self you push your needy cock through the now welcoming hole that is your half broken toy butt thrusting to bring yourself to new heights of pleasant delirium.");
			outputText("\n\nYou cum green, your fluids dripping from your partner and tainting the ground beneath into a small pool of defiled fluid as you draw in whatever remains of your victim's now empty brain.");

			if (player.buff("Brain melt").getValueOfStatBuff("int.mult") < (player.perkv1(PerkLib.MindbreakerBrain1toX)*2)){
				player.buff("Brain melt").addStat("int.mult",0.01);
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp("int");
			}

			player.sexReward("Default", "Default", true, false);
			statScreenRefresh();
			cleanupAfterCombat();
		}



		public function raijuVoltTransfer():void {
			clearOutput();
			outputText("Your static arcs through your entire being as you stand before your opponent. Thoughts race through you as you gaze at your prey. Your opponent shudders as you grab [monster him] by the neck.\n\n");
			outputText("You're losing your mind, you need them to know how much you need this. You want them to squirm beneath your touch. You want them to feel what you feel. More arcs of electricity jolt through you as lust overrides your senses. Your opponent can only helplessly wait for you take your next course of action... Your entire body is tingling in anticipation, craving for more\"\n\n");
			outputText("[Themonster] trembles as you kiss [monster him], your static starting to jolt along [monster his] skin. As you vent out your electiricity, you can only feel the squirms of pleasure mixed with arousal beneath you.\n\n");
			outputText("Voltage rushes out of your body as it transfers to your victim");
			if (monster.hasCock()) outputText(" wrapping and sheathing around [monster his] penis,");
			if (monster.biggestTitSize() >= 1) outputText(" massaging the shape of [monster his] " + monster.breastDescript(0) + ",");
			if (monster.hasVagina()) outputText(" licking the entrance of [monster his] pussy");
			outputText(" and spreading across the rest of [monster his] skin. You smile, contended as the haze of lust progressively dissipates from your mind. Unfortunately, your victim will not have the same pleasure you do from release. The excess of your static slowly passes into [themonster] prone form and you almost achieve climax from the relief as you purge all of this bad energy out of yourself.\n\n");
			outputText("Your victim, however, is not so lucky. As you pour in your lust [monster he] begins to completely lose control, attempting to fiercely masturbate this excess of desire out, to no avail. As you are close to done your partner is a wrecked mess on the floor, desperate to gain release but unable to achieve it fully as the supernatural electricity keeps building [monster his] desire way beyond normal, obliterating self-restraint and pride along the way. You move away from [themonster] just as [monster his] hands begin to draw fluids out of [monster his] lust filled endowment. ");
			outputText("You stay clear as your victim’s lust explodes, spewing ");
			if (monster.hasCock()) outputText("cum");
			if (monster.hasVagina()) outputText("girlcum");
			if (monster.biggestTitSize() > 0) outputText(" and milk");
			outputText(" everywhere in the vicinity. You can see the pulse of your statics as a small glow in every thrust of [monster his] hips as [monster he] keep fiercely masturbating in an attempt to expel the lust.\n\n");
			outputText("You leave your lust receptacle there, it's unlikely [monster he] will stop masturbating anytime soon.");
			player.sexReward("Default", "Default", true, false);
			statScreenRefresh();
			cleanupAfterCombat();
		}

		public function hinezumiHeatTransferScene():void {
			clearOutput();
			outputText("You ponder what to do with your defeated opponent then realize your body is on the brink of overheating with lust. Your opponent shudders as you grab [monster him] by the neck." +
					"You ask if [monster he] can feel the heat you radiate. You truly are thankful to be gifted the sight of your new victim. You must purge the bubbling warmth, and you wonder if [monster he] knows what you're about to do.\n\n" +
					"Your opponent only realizes your intent when you kiss [monster him], your flames starting to lick his/her skin, leaving a tingle of pleasure and arousal as you start to vent your heat out." +
					"Your flames stretch out from your ");
			if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) outputText("coat,");
			else outputText("body,");
			if (monster.hasCock()) outputText(" wrap and sheath around [monster his] "+monster.cockDescriptShort()+",");
			if (monster.biggestTitSize() >= 1) outputText("massage the shape of [monster his] "+monster.breastDescript(0)+",");
			if (monster.hasVagina()) outputText("lick the entrance of [monster his] "+monster.vaginaDescript()+"");
			outputText("and spread across the rest of [monster his] skin like a wildfire. You smile in contentment as the haze of lust progressively clears from your mind which is the opposite of what can be said for your victim. The excess of your");
			if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) outputText("hinezumi coat,");
			else outputText("flames,");
			outputText(" slowly pass inch by inch into [themonster] prone form and you almost achieve climax from the relief as you purge all of this ");
			if (player.hasStatusEffect(StatusEffects.HinezumiCoat)) outputText("bad ki ");
			else outputText("fire ");
			outputText("out of yourself.\n\n" +
					"Your victim, however, is not so lucky. As you pour in your lust it begins to completely lose control attempting to fiercely masturbate this excess of desire out, to no avail. " +
					"As you draw closer to the end, your partner is a writing mess on the floor. Desperate to cum but unable to achieve complete release as the supernatural fire keeps fueling [monster his] desire " +
					"way beyond normal obliterating self-restraint and pride along the way. You move away from [themonster] just as [monster his] hands begin to draw fluids out of [monster his] lust filled endowment. " +
					"You move back as your victim reaches the height of their orgasm.");
			if (monster.biggestTitSize() >= 1)outputText(" You notice [monster his] breasts begin to dribble milk as well. ");
			outputText("There are fluids everywhere in the vicinity. You can see the pulse of your flames as a small embery glow in every thrust of [monster his] hips as [monster he] keeps fiercely masturbating in an attempt to expel the lust.\n\n" +
					"You leave your writhing lust receptacle there, it's unlikely [monster he] will stop masturbating anytime soon.");
			//We give both sex reward so to end player rut or heat in the event pc has either
			if (monster.hasCock()) player.sexReward("cum");
			if (monster.hasVagina()) player.sexReward("vaginalFluids");
			cleanupAfterCombat();
		}

		public function TentacleRape():void {
			clearOutput();
			outputText("As your opponent falls defeated on the ground, it dawns on your prey is in desperate need of some punishment. " +
					"She wanted to rape you? Well, you're going to open her vocabulary to an entirely new definiton of the term.\n\n" +
					"You pick up the defeated woman, easily lifting her by the leg with one of your tentacles as she's helplessly held upside down.\n\n" +
					"She quickly cries out in protest, <i>\"Wait, what are you doing?! Stop!\"</i>\n\n" +
					"You pull her to you, smiling widely as you begin to return her question with mockery.\n\n" +
					"Were she not so eager to fuck you just a second ago? Is this not what she wanted? It's not like she's going to back now, is she?" +
					" Not that she has a choice in this matter anymore.\n\n" +
					"You pay her no further heed as you methodically proceed to brutally strip every single piece clothing she had from her body. " +
					"Once she's suitably naked, you grab her other leg with a second tentacle and spread her wide, exposing her pussy for the entire world to see as you prepare to break her mind with the most intense set of penetrations she ever had. " +
					"You insert one tentacle... then a second, and so on, the girl eyes going wider after each insertion. " +
					"The little bitch can stretch way wider than her size would tell, and soon you're inserting your fourth tentacle inside of her abused pussy, her belly bulging with the sheer size of your limbs. " +
					"She begs you to stop but this only drives you on as you proceed to fuck her senseless, moving a fifth and sixth tentacle to invade her ass and mouth, gagging her up. " +
					"You expected her ass to be tighter than this but obviously a few people passed before you did and made a good number on the girl. Meanwhile, your remaining tentacles aren't left unused as you fuck your own hole trying to get yourself off as you rape the she-devil into submission. " +
					"You watch the merciless movement of your limbs in her belly and can’t help but to be amazed the girl didn’t die from your insertions alone, likely people on Mareth are better adapted to this kind of senseless rape then humans. " +
					"No matter how accommodating she is, she still cums an incalculable amount of times, her eyes rolling back as you finally get yourself off and drench her entire body in your viscous ink, " +
					"doing a nice painting job. Still you are far from done punishing that slut as you bring your now free tentacles to her making her scream in pleasure mixed horror. " +
					"You aren’t left without pleasure yourself as each of your tentacles are covered with a million nerves and fucking the slut with them isn’t so different to you from fucking her with a full set of penises. " +
					"You moan in pleasure, achieving several ink-gushing orgasms from raping the sluts many holes. This of course only entices you to fuck her even more.\n\n" +
					"You violate the mind broken woman for a good hour before leaving her unconscious on the ground like the overused heap of trash she is to bathe in the ink your many orgasms produced. It's very likely she will find even minotaurs to be too small for her for quite a while. " +
					"That said, you return to camp satisfied.");
			player.sexReward("vaginalFluids");
			cleanupAfterCombat();
		}

		public function HumanDildo():void {
			clearOutput();
			outputText("Seeing as your needs have not been met, and your opponent is on the ground crawling away, a wicked idea surges through your mind as you pick it up with your tentacles. " +
					"It starts screaming, kicking and waving its arms everywhere trying to get you to drop it, but you prove too strong and mainly too huge for your victim. " +
					"Before long you manage to bind [monster him] with your tentacles so to prevent its movement as you order [monster him] to stay still.\n\n" +
					"Defeated and utterly terrified, your toy obeys reluctantly as you draw its entire body inside your vagina inch by inch and order him/her to squirm, using [monster him] like an improvised dildo to fuck yourself with. " +
					"The movements of your prisoner against your vaginal walls is simply divine as they rock you with several small consecutive orgasms, gushing ink everywhere. [monster He] finally finds your clitoris, grabs it, then start jerking it off like a pseudo cock, " +
					"driving you completely insane as you flood the ground with ink. " +
					"You finally sigh satisfied and draw your unwilling toy out of your vaginal walls still covered from head to toe with your ink. " +
					"\n\nYou laugh at it’s shocked expression, the scene is just too hilarious. Satisfied you throw your opponent away as you head back to camp.");
			player.sexReward("Default", "Vaginal", true, false);
			cleanupAfterCombat();
		}

		public function EasterBunnyLayEggsRape():void {
			clearOutput();
			outputText("Oh gawsh, your balls feel like they will explode anytime soon if you don’t shoot those eggs out already! Again the welcoming piece of ass your defeated foe present you looks like the perfect place to lay and this is not the kind of opportunity you would pass on.\n\n");
			outputText("With a soulless stare and a manic smile completing your lust crazed expression that would scare the shit out of the most pent-up of demon, you ready for breeding revealing your hardening [cock] as you prepare to go to town on [themonster] welcoming ass. " +
					"[monster he] eyes widen in terror as [monster he] realizes that from predator [monster he] became the prey. You grab that ass and smack it a few times for good measure forcing a moan or two out of your partner before grabbing your victims tight as you prepare for the mating." +
					" [themonster] eyes are almost begging for mercy by now, but you’re too far gone in your lust to care.\n\n");
			outputText("You gasp in delight as your bunny cock slides into that sweet hole the walls tighten around you. Using your powerful bunny legs you begin to jump in and out of this rabbit hole your unwilling partner groaning as you use his/her/its backside to sate your bottomless lust.\n\n");
			outputText("<i>\"Eggs…!!!! EGGS!!!\"</i> You finally scream, eye crossed in delight as your two/four heavy eggs finally slide out of your balls, moving through your urethra and into your victim's spacious bowels.\n\n");
			outputText("Your [cock] still hard, you keep bucking inside -opponent- name relentlessly until you cum not once not twice but three times, tongues out, caring little for the destroyed hole of your partner. Only caring for your own satisfaction you stop fucking only once [themonster] faint from exhaustion. " +
					"Well you still got plenty of energy left but might as well fuck something that's awake. You unplug your still hard cock from [monster his] asshole gasping as your cock sensitive flesh is exposed to the air again." +
					" Without anything to plug it the excessive load of cum stashed in your victim's stomach surges out and dye the ground beneath [monster his] white. For good measure you clean your dripping penis on [themonster] ass and hops off back to camp.\n\n");
			player.sexReward("Default", "Dick", true, false);
			cleanupAfterCombat();
		}

		public function gobomechFillTheReservoir():void {
			clearOutput();
			player.addKeyValue("Cum Reservoir", 1, 1);
			outputText("Gosh, you really aren't horny right now but that doesn’t mean you're going to let all this precious baby making gold go to waste!\n\n");
			outputText("You jump out of your mech and painfully grab [themonster] by the cock in order to make your next statement clear.\n\n");
			outputText("\"<i>You don’t move one inch while I work, or I swear you will regret it… understood, shank???</i>\"\n\n");
			outputText("Having made your intentions obvious, you get under your mech and pull out the reservoir tube, paying no heed to your confused victim, [monster he]'s going to find out soon enough anyway. You run back to [themonster], tube in hand, and plug it on [monster his] " + monster.cockDescriptShort(0) + " fastening it in place with straps. Satisfied with the result, you run back to your mech and press the start button activating the vacuum.\n\n");
			outputText("[Themonster]’s eyes widen as your engine forcely starts milking [monster his] dick. Of course [monster he] struggles for a bit against the pleasure inducing contraption, but the aphrodisiac dripping syringes you added in the fastening make short work of any resistance [monster he] has left, causing [monster him] to jerk up and down on the ground in unwanted, yet forced consecutive orgasms. You watch with keen interest as the tube fills up with a constant flow of freshly harvested cum, smiling at the fluctuation of the volume needle on your motherboard. ");
			outputText("Since you have nothing to do but wait, you slowly enjoy a coffee, laid back in your driver’s seat and whistling, as the engine’s cum-o-meter fills up. Soon [themonster] eyes rolls in their socket as [monster he] completely lose control of [monster his] body, [monster his] sexual organ taking over for [monster his] brain. The needle finally reaches ");
			if (player.keyItemvX("Cum Reservoir", 1) == 1) outputText("1 quarters");
			if (player.keyItemvX("Cum Reservoir", 1) == 2) outputText("2 quarters");
			if (player.keyItemvX("Cum Reservoir", 1) == 3) outputText("3 quarters");
			if (player.keyItemvX("Cum Reservoir", 1) == 4) outputText("full");
			outputText(", a little before the cum pump falls unconscious, well that's a good harvest.\n\nYou go to the passed out cum cow and unfasten your equipment before jumping back into the mech, heading back to camp.\n\n");
			cleanupAfterCombat();
		}

		public function Cooldown():void {
			clearOutput();
			outputText("You eye [themonster] with anticipation. Being a "+player.race()+", your body temperature is constantly burning way above normal and right now your [pussy] is like 40° celcius in summer with high humidity. " +
					"A little cooling is in order and this unlucky rift denizen is about to serve as natural refreshment for your burning hot body.\n\n" +
					"You proceed to force [themonster] on [monster his] back");
			if (monster.wolfCocks() > 0) outputText(", your warm body slowly forcing his puppy pecker out of its sheath");
			outputText(". Once your partner’s towering erection is suitable you proceed to straddle him and fill your burning vagina full of his dick." +
					"[themonster] "+monster.cockDescriptShort()+" twitches as warmth coats his member and you begin to slide up and down his towering maleness");
			if (monster.wolfCocks() > 0) outputText(", enjoying yourself as his knot grows and locks itself in your [pussy]");
			outputText(". You begin to slowly work his tool with your vagina, moaning as the shaft ever so gently scrapes your walls. You want the cool cream inside to fill you all over and soon the beast growls as it reaches its impending climax, its dick unloading thick ropes of cooling cum into your furnace of a pussy.\n\n" +
					"Thoroughly satisfied you pull from [themonster] "+monster.cockDescriptShort()+" and walk off. Gosh, this one felt hella good you should come back more often when you’re in need of some cooling.")
			//We give both sex reward so to end player rut or heat in the event pc has either
			player.sexReward("cum");
			player.sexReward("vaginalFluids");
			cleanupAfterCombat();
		}

		public function yukionnaStealWarmthScene():void {
			clearOutput();
			outputText("You eye your defeated opponent’s form with delight. [monster he]'s so warm and full of life, certainly sharing some of it with you should be no problem? Yet the greedy creature squirms and crawl away in a vain attempt to escape you and this angers you to no end. Even worse this thing is a guy. You freeze [themonster] limbs in place, trapping them with ice, and approach him.\n\n");
			outputText("Your icy glare stares into them as you feel the warmth from them linger. You'll be sure not to leave an ounce of heat left.\n\n");
			outputText("He looks at you fearfully and rightly so, there's no telling how far you will go to get the warmth you’re craving from him. You spread [monster his] leg wide to reveal the already hardening " + monster.cockDescriptShort() + " between. You lick his length to lube it properly for what is coming next, your cool saliva making [themonster] shiver. You rub your body along his while doing this, enjoying the sensation of warmth over your skin. A few seconds later you're already straddling the towering erection, inserting inch after inch inside your folds. Moans are exchanged as you begins to lower your body on your victim’s cock, moving at a steady pace. Midway you kiss [themonster] silencing his pain and pleasure mixed groans ");
			outputText("as your cool breath pours in, and you draw out his warm one. He begins to shake as his cock hardens further, both from the pleasure and the thin layer of ice preventing his release and softening, freezing the very blood inside and spreading out across his body. He would be screaming half mad right now if you weren't choking his loud reply with a kiss, breathing in his warmth. He keeps thrusting until his lower body loses mobility to the creeping frost, not one to end, so soon you prolong his agonizing pleasure and yours by your own efforts, moaning in delight each time his diamond hard frozen member bottoms in.\n\n");
			outputText("As you achieve your fifth orgasm, his body is entirely covered in creeping ice, and he's no better than a frozen statue, devoid of all warmth and life. What a bore, you were just barely satiated and could've gone on for several hours. You kick him in anger, causing his form to crack and explode like glass in the opposite direction. Guess you had fun while it lasted, time to head back to camp.\n\n");
			player.HP = player.maxHP();
			player.mana = player.maxMana();
			player.soulforce = player.maxSoulforce();
			player.sexReward("cum","Vaginal");
			cleanupAfterCombat();
		}

		public function jiangshiDrainHimTrueDemons():void {
			clearOutput();
			var intBuff:Number = player.buff("Energy Vampire").getValueOfStatBuff("int.mult");
			if (intBuff < 0) {
				outputText("You moan eagerly as you focus on the demon's throbbing member. Sustenance... food... Your dead eyes lock on the dick with intent. It is the only thing that gives you purpose now. Instincts take over yourself, you’re lost, basking in the demon’s presence.\n\n");
				outputText("A blue shimmer of energy accumulates within the demon member, a shimmer only you can see. Enthralled, you steadily hop toward the exposed cock, thirsting for the pearlescent cream that you see accumulating at the tip, steadily dripping down the lengthy member. So much energy... So much life... You lack so much, your hunger grows. Famished, your mouth uncontrollably drools, exposing your teeth and obscene tongue as it dances in anticipation of the meal you are about to dive into. The demon watches you, fascinated and aroused by your intentions, which are on display clear as your pale dead eyes. You're going to relentlessly devour him until he floods you with the creamy white vitality you yearn for.\n\n");
			}
			else {
				outputText("While you are fully aware [themonster] has no soulforce to steal, his body still offers you enough sustenance to maintain yourself. Your unholy instincts drive you to focus on his " + monster.cockDescriptShort() + " with a barely contained hunger. You almost begin to wonder why you bothered to fight [monster him] when you were this eager to suck [monster him] off from the start.\n\n");
				outputText("The demon, seemingly aware of your interest, flaunts [monster his] cock knowingly. Temptation grows at the sight, snuffing out any lingering doubts. There is no shame. No regret. Only a burning need welling up from your core.\n\n");
			}
			outputText("You practically fall on the offered cock, crawling into position and wrapping your needy lips around it in a tight seal as you begin feverishly extracting the white vitalic seed from the fiendish member. The demon caresses you, petting your head while you worship the tool in front of you with a mastery born of your magically ingrained instincts. The demon moans in appreciation as your hungry tongue wraps around the cock, teasing and jerking [monster his] eager erection"+(monster.balls > 0 ? ", [monster his] balls sloshing with accumulating cum":"")+" as [themonster] steadily approaches [monster his] climax.\n\n");
			outputText("Instinctively sensing the imminent climax you wrap your lips tightly around the throbbing cock, sealing shut as the demon unloads ropes after ropes of corrupted cum directly into your massaging throat.\n\n");
			outputText("The meal is satisfying, though it does not restore your humanity, lacking the soulforce you require to make you slightly more alive. Finished with the demon, you hop off and take your leave"+(inDungeon ? "":" heading back to camp")+".\n\n");
			HPChange(Math.round(player.maxHP() * 0.1), true);
			EngineCore.ManaChange(Math.round(player.maxMana() * 0.1), true);
			player.fatigue -= Math.round(player.maxFatigue() * 0.1);
			if (player.fatigue < 0) player.fatigue = 0;
			player.trainStat("lib", 1, 50);
			dynStats("cor", 1);
			player.sexReward("cum", "Oral");
			cleanupAfterCombat();
		}
		public function jiangshiDrainHerTrueDemons():void {
			clearOutput();
			var intBuff:Number = player.buff("Energy Vampire").getValueOfStatBuff("int.mult");
			if (intBuff < 0) outputText("You sense a food source nearby. Your dead stomach twitches, your mind filling with need. Like a fountain of life energy only your dead eyes can see, the demoness’s pussy glows neon blue in the dead, greyish world. You are drawn like a moth to the flame, your mind dead set on with this single intent, to make her cum all this juicy energy out.\n\n");
			else outputText("You ponder, lost in thought over how you're going to take advantage of the demon in front of you when a wicked idea comes to your mind.\n\n");
			outputText("You drop down on the demoness, crawling over to her exposed cunt before pushing her on her back and firmly but lovingly grabbing her hands with your icy grasp.\n\n");
			outputText("\"<i>Wait... W-What is this?!... HANDHOLDING?! NOOOO! Get off me, stay away from my face, you degenerate!...</i>\" Muffled screams are all that remains of her protest as you forcefully kiss her, sealing her mouth with the embrace as you drink in her sweet saliva.\n\n");
			sceneHunter.selectGender(dickF, vagF);

			//==================================
			function dickF():void {
				outputText("You grind your erect [cock] against the demon’s vagina, smearing her lips with your abundant pre as you prepare for penetration. The demon is fully aware that you plan on taking energy rather than giving it, so she tries to fight back. Her struggles are futile, seeing as you not only already hold her hands but also possess inhuman strength, far more than enough to keep the demon slut restrained. With your erection aligned, you drive yourself to penetrate the demoness.\n\n");
				outputText("You moan in delight as you begin to rape the "+(monster.hasCock()?"omnibus":"succubus")+"’ cunt, viciously harvesting her energy with each thrust. Realizing what you’re doing, she wails in terror, your [cock] bloating up as her life force begins to flow. She struggles, trying to wrench her hands from yours, but the unfortunate demoness is already being drained. You clamp down, keeping her hands pinned to the ground under your grip, your weight firmly keeping the weakened slut down. Her walls clamp down as she tries to get her legs underneath her to push you off, but she’s too late. ");
				outputText("Her legs fall limp, tears begin to form on the defeated demoness’s face as you piston in and out of her hole. Unable to endure the draining sex for long, the demoness cries out weakly, drenching the ground underneath you with her pussy juices. Your energy sensitive eyes can see her blue life force fading, the force flowing to her pussy, then into your [cock].\n\n");
			}
			function vagF():void {
				outputText("With your victim properly pinned, you begin to grind your puffed pussy lips against her own drawing extra energy and pleasure from the labial contact. The demon panics as you begin to drain the life force from her, she cries out, trying to wrench her soaked lips away from yours. Despite her desperation, your cold, dead grip is far too strong, and you bear down, pressing your pussy lips into hers, grinding your clit on her cunt.\n\n");
				outputText("As your drain goes on, her desperate flailing starts to slow, the sexual predator finally running out of stamina. She falls limp, breathing heavily as your cunts spill your mixed juices onto the ground. Her vibrant blue life force begins to fade, and you feel yourself grow stronger with every second.\n\n");
				sharedEnd();
			}
			function sharedEnd():void {
				if (player.biggestTitSize() > 0) outputText("You moan delighted as you rub your [breasts] against the demon prodigious chest savoring the electrifying feeling of smaller input of energies circulating directly from her nipples to yours.\n\n");
				outputText("Your eyes glow a spectral blue, infused with her stolen vitality as you extract drop by drop from your bound opponent. She cries for help, pleading for her life, her lips slowly turning blue. Her pitiful cries would have swayed most people back home in Ignam. Unfortunately for the slut, you currently lack the ability to reason coherently, your mind having fully embraced this feeding frenzy you are caught in" + (intBuff < 0 ? ", her cries are utterly futile. Your thoughts are lost in a mindless state. Nothing else matters except for getting your food, she might as well be wailing to a hollow, mindless corpse. Fitting for what you’ve devolved to in your frenzy" : "") + ". ");
				outputText("In your current state, such cries are mere seasoning to your lovely, slutty meal. Offers of gems, power, even to become your slave fall on deaf ears, all you can pay attention to is the flow, that beautiful life force entering you. This whore is but an energy source, and you intend to tap it until it runs dry.\n\n");
				outputText("The demons might be insatiable but there is a limit to their stamina, a limit your dead flesh no longer has to obey. She takes your punishment well, better than most other living races, but there’s no way she can hold out forever.\n\n");
				outputText("Unable to hold anymore under your constant assault, the demoness breaks, her pussy gushing like a fountain as her eyes cross. Her body spasms as if struck by lightning" + (player.hasCock() ? ", pussy walls all but milking your [cock] dry" : "") + ". Her legs shake, and her arms fall limp. She no longer struggles, her eyes rolling up into her head. Her body is unscathed but to your eyes she is a dried up husk. There's barely enough energy left in her to keep her alive… well if she survives this that is. You stay on top for a few more seconds, but the demoness’s body doesn’t have anything left to give. ");
				outputText("For a few moments you bask in the high, your flesh bursting with energy. But you’re no longer getting anything from this slut, you’ll need another to get your fix.\n\n");
				outputText("Unconcerned by the demon's fate you stand up and" + (inDungeon ? " resume exploring the labyrinth" : " hop back to camp") + ".\n\n");
				HPChange(Math.round(player.maxHP() * 0.1), true);
				EngineCore.ManaChange(Math.round(player.maxMana() * 0.1), true);
				player.fatigue -= Math.round(player.maxFatigue() * 0.1);
				if (player.fatigue < 0) player.fatigue = 0;
				dynStats("cor", 1);
				player.sexReward("vaginalFluids", "Oral");
				cleanupAfterCombat();
			}
		}

		public function jiangshiDrainHimMinotaurs():void {
			clearOutput();//
			outputText("The minotaur falls, unable to fight any longer."+(monster.lust >= monster.maxLust()?" His massive erection throbbing, drooling excessive amounts of precum as he moos softly, panting with desperate need.":"")+" His churning balls are full of excessive amounts of his virile energy. A fountain of energy, in more ways than one, and it's a fountain you intend to drink every last possible drop from. Already driven over the edge, the masculine scent of his musk only serves to remind you of the prize you've won. All you can think of now is the alluring sight of lifeforce that fill his balls.\n\n");
			outputText("Unceremoniously, you drop on the prone minotaur with eager readiness as you begin deepthroating his juicy cock for his soulforce. The bull moos, jumping slightly in shock before he gives in to the pleasure at the sudden but aggressive attention.\n\n");
			outputText("Lacking a gag reflex or a need for air, you easily slide his massive member down your throat as you blow him. His full balls churn, yet you only receive a steady stream of precum from him. Impatiently, you poke the minotaur's massive balls with your nails, causing them to further swell in size as the venom forces him to produce even more cum.\n\n");
			outputText("The minotaur moos eagerly, forcefully bucking into your gaping maw. You wring your tongue around his massive shaft, coaxing him closer to orgasm. The massive bull can only handle this torture for so long and begins unloading shot after shot into your throat causing your belly to inflate briefly before you absorb the fluid and deflate back to your normal size. Fitting your maker accounted for a bukake scenario.\n\n");
			outputText("The bulky bull-man lies down, exhausted and utterly spent as you pull away. You feel his massive, slowly deflating erection fall from your throat before you stand up, energized from the filling meal.\n\n");
			var intBuff:Number = player.buff("Energy Vampire").getValueOfStatBuff("int.mult");
			var speBuff:Number = player.buff("Energy Vampire").getValueOfStatBuff("spe.mult");
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) {
				if (intBuff < +1.0) player.buff("Energy Vampire").addStats({ "int.mult": +1.00 }).withText("Energy Vampire");
				if (speBuff < +0.5) player.buff("Energy Vampire").addStats({ "spe.mult": +0.50 }).withText("Energy Vampire");
			}
			else {
				if (intBuff < +0.5) player.buff("Energy Vampire").addStats({ "int.mult": +0.50 }).withText("Energy Vampire");
				if (speBuff < +0.25) player.buff("Energy Vampire").addStats({ "spe.mult": +0.25 }).withText("Energy Vampire");
			}
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) player.soulforce += player.maxSoulforce() * 0.4;
			else player.soulforce += player.maxSoulforce() * 0.2;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText(" You feel slightly more alive from the soulforce you vampirised from your sexual partner orgasm.");
			player.sexReward("cum", "Oral");
			cleanupAfterCombat();
		}
}
}