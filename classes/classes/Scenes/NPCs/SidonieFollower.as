/**
 * ...
 * @author Coalsack
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.Plains.GnollPack;
	import classes.Scenes.SceneLib;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	
	public class SidonieFollower extends NPCAwareContent
	{
		
		public function SidonieFollower() 
		{
			
		}
		
		private function buildedAnythingInCamp():Boolean {
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10 || flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3 || flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2 || flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1 || flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100 || flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4 || flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2)
				return true;
			return false;
		}
		private function anyHermInCamp():Boolean {
			if ((flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.IZMA_NO_COCK] != 0) || (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) || (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 3))
				return true;
			return false;
		}
		private function anyMalesInCamp():Boolean {
			if ((player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) || player.hasStatusEffect(StatusEffects.CampRathazul) || (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] < 1 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) || flags[kFLAGS.IZMA_BROFIED] == 1 || flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2
			 || emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 1)
				return true;
			return false;
		}
		
		public function meetingSidonieAtPlains():void {
			clearOutput();
			outputText("At your usual stroll in the middle of the plains, you happen into an usual view: A very tall horse-morph girl is being chased by a half-dozen of angry gnolls. The group of hyena-like creatures wave spears and hurl javelins to the fleeing equine.\n\n");
			outputText("The girls seems quite imposing on her own, albeit you have serious doubts about how she’ll fare against a whole group of enemies. Shall you help her?\n\n");
			menu();
			addButton(0, "Yes", meetingSidonieAtPlainsYes);
			addButton(1, "No", meetingSidonieAtPlainsNo);
		}
		public function meetingSidonieAtPlainsYes():void {
			outputText("Given how hostile are gnolls to travelers, is more than likely that they picked on this poor equine as soon as they saw her. Having met a familiar situation before, you cannot let it happen to her. Whistling as loud as you can, you call upon them, mocking them as cowards for ganging up on a lone traveler.");
			outputText(" Angry snarls and pointy lances are directed to you, as four of the chasing gnolls divert their attention to you. Seems like you have a fight on your hands!\n\n");
			startCombat(new GnollPack());
			doNext(playerMenu);
		}
		public function meetingSidonieAtPlainsNo():void {
			outputText("Nope. This seems a bit too risky, given their numbers. You continue on your way, hoping that the horse-morph doesn’t get it too rough if those gnolls catch her.\n\n");
			flags[kFLAGS.SIDONIE_RECOLLECTION] = 18;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function wonGnollPackFight():void {
			clearOutput();
			outputText("The last gnoll falls to the ground, defeated, while you take your time recovering you breath after the fast-paced battle. As you do so, you manage to see that the horse-morph woman has beaten the two remaining attackers, and that she’s angrily shouting at one of them.\n\n");
			outputText("You approach her, but when she manages to see you, the equine readies to another fight. You wave your hands non.threateningly, after which she noticeably relaxes. Both of you stand in the grass in awkward silence for a moment, until the horse-woman breaks the ice and thends her hand to you.\n\n");
			outputText("\"<i>Name’s Sidonie, friend. What’s yours?</i>\"\n\n");
			outputText("With that, you shake hands and present yourself. You gaze at her. Light brown fur covers hers body, turning to white on her belly. Her hair is a golden shade of blonde, and her azure eyes compliment her equine face pretty well. A fresh and somewhat loose cotton attire girds her body.\n\n");
			outputText("\"<i>Well, [name], you have my thanks for that. I don’t think that I could fend off that bunch of hyena assholes alone. I’ve managed to hold my own against three, four at best and...Aaah</i>\"\n\n");
			outputText("You conversation is suddenly interrupted by the horse-morph sudden yelp. As you try to look what happened, you manage to see a pink liquid flowing from a dart, a dart that is stabbed on the horse-girl furred leg. Holding the other side, a bruised gnoll grins wickedly.\n\n");
			outputText("Sidonie angrily turns back, and with a loud ‘thud’ she knocks the air out of the hyena warrior’s lungs, rendering her unconscious..\n\n");
			outputText("\"<i>Stupid bitch!</i>\" she yells, beating the senseless hyena on the ground with her hoof. \"<i>I’m gonna...No, please. Not in front of this " + player.mf("guy","girl") + " that I’ve just met...</i>\"\n\n");
			outputText("Trying to calm her down, you ask her what’s wrong, and if the dart was poisoned, how you could help her looking for any antidote.\n\n");
			outputText("\"<i>No, [name], I think that isn’t not poison. That bitch drugged me with one of those lust-inducing mixes that they trade with those goblin sluts. Sorry, but would you mind if...</i>\"\n\n");
			outputText("Then you see it. Until now hidden by the loose cloth covering her, the unmistakable tent of a growing erection makes appearance. Given by the size of the bulge made by the half-erect member, you can guess that the thing is almost twenty inches big. Quickly guessing what she’s saying, you ask her if she needs some privacy. ");
			outputText("Sidonie nodes eagerly, and you walk aways some steps and turn your back, since nothing else can be done in the sea of grass. Still, you manage to hear her moans and unmistakable sound of cum splashing the ground.\n\n");
			outputText("Once that uncomfortable moment passes, you return with her, only to find the horse-girl much more composed, albeit still heavy breathing from her resent orgasm.\n\n");
			outputText("\"<i>Sorry, " + player.mf("boy","girl") + ". I don’t act that way often. I usually never let those fuckers get that close, and this time I was particularly unlucky...or maybe not, since someone came to rescue me. Often I wander those places, looking for some water, food, or some decent place where practice my carpentry skills. ");
			outputText("But what about you? How is it that from all people, you happened to stumble on the plains? Somehow, you don’t strike me as the average Marethian nomad, so I guess that you don’t live on the plains...</i>\"\n\n");
			outputText("Well, since she asked, you give her the story of your role as Champion of Ingam, how you were sent here, as well as your less than conventional adventures. You explain how you found this place during your travels, and how you were in the middle of one of them when you met with the unfriendly gnolls chasing her.\n\n");
			outputText("Once the topic shifts to more mundane things, both of you discuss how life has been in Mareth during your stay, the strangeness of the climate under demonic rule");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText(" and how it’s now slowly returning to normal, and other trivial stuff");
			outputText(". She tells you about her job, carpentry, and how she used to works as one until she ended up in the plains. At this point you stop her, and ask if she’ll mind lending you her services.\n\n");
			outputText("\"<i>Why, are you in dire need of a carpenter? That’s not so surprising, considering that you’re a warrior and so. You usually require help with shields and similar stuff, or building outposts.</i>\"\n\n");
			outputText("That’s right. Having a carpenter’s aid will surely come on handy.\n\n");
			outputText("\"<i>It sounds good for me, but I don’t see how I can help you with that camp of yours and me on the plains, unless you’re okay with me moving to that place.</i>\"\n\n");
			outputText("Sounds like a good idea, and you’re not fond of the idea of having to move furniture or heavy shields all the way from the plains to you camp. You ask her is she’s open to the idea.\n\n");
			outputText("\"<i>Hell, yes, [name]. I’m fed up of having to live on the plains, living off the little food and water that I can gather. My client base, albeit nice, isn’t that big, and some bands of gnolls are especially hostile.</i>\" Sidonie says, looking at the seemingly endless sea of grass. \"<i>So, Champion, seems like I’m coming with you!</i>\"\n\n");
			cleanupAfterCombat();
			doNext(commingToCamp);
		}
		public function lostGnollPackFight():void {
			clearOutput();
			outputText("Beaten and abused by the pack of gnolls, you fall to the ground bruised. Some minutes later, you gather enough strength to stand up, and manage to see that the silhouette of horse woman that they were chasing in the horizon. Seems like she has managed to escape while they were tangled with you.\n\n");
			outputText("Since it’s obvious that she has gotten so far away that it’s unlikely that you catch up with her, you sigh, hoping that you have another chance meeting the running equine.\n\n");
			flags[kFLAGS.SIDONIE_RECOLLECTION] = 18;
			cleanupAfterCombat();
		}
		public function commingToCamp():void {
			clearOutput();
			outputText("After doing the usual route from the plains to you camp in the middle of the wastelands, you find yourself arriving with a bit more of company this time. The carpenter horse-girl, Sidonie, comes at your side, carrying with her several boxes containing her belongings and working tools.\n\n");
			outputText("The eerie glow of the portal welcomes you both, and you let sidonie pick a place to set up her things. She chooses a high spot, near on side of the stream, and you help her by bringing her stuff there. As you were the one who invited her here, you offer to set up her tent while she takes this time to look around the camp");
			if (camp.companionsCount() >= 2) outputText(" and meet the rest of the camp inhabitants");
			outputText(".\n\nOnce you’re finished with the tent, a bit later of what you had expected, you call her over, only to find that she is still busy looking around. With nothing else to do, you sit on front your tent, and wait until Sidonie has finished exploring the camp to help her unpacking the rest of her stuff. ");
			outputText("Since it takes a while, you eventually fall asleep. A couple of hours later, you’re awaked by the horse morph, and to you surprise, everything is already unpacked and in place. Noticing your surprise, Sidonie explains.\n\n");
			outputText("\"<i>Hey, [name]. While you were asleep I finished unpacking my stuff and putting it on my tent. Thanks for setting it for me, by the way. My woodworking stuff it’s also on place, so I can start working.</i>\"\n\n");
			if (camp.companionsCount() >= 2) {
				outputText("It’s good to hear. You ask her if she found something interesting on the camp while you were asleep?\n\n");
				if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
					outputText("\"<i>That white, cute mouse boy was the first person that I saw when arriving to the camp. Not to hard since his fur makes him stand out. We had a nice talk, and I got that he is a monk, in a kind of personal quest trying to push away Mareth’s corruption. It sounded quite noble, and I was quite taken with his story, so much that I wanted to grab the little boy and hug him...");
					outputText("but that surely would’ve been too weird.\n\nDon’t tell him, but there’s something on his twinkish body that makes me want to fuck him senseless. Good thing that I’ve much more self-control that your average horse-morph. We tend to be a bit pushy on those matters, and I’ve the feeling that our mousey friend it’s quite shy about that stuff.</i>\"\n\n");
				}
				if (amilyScene.amilyFollower() && flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] == 0) {
					outputText("\"<i>The brown-furred girl and I had the opportunity to chat too. It’s a good to known that mouse people won’t be doomed to extinction as everyone feared. I have to admire her determination to help her race. ");
					outputText("Going so far to modify her own body to enhance her fertility, and having to endure all those births is quite a sacrifice.</i>\"\n\n");
				}
				if (arianScene.arianFollower()) {
					outputText("\"<i>Once I stumbled on that colorful looking tent I found that we’ve a wizard among us! But, that Arian ");
					if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("gal");
					else outputText("guy");
					outputText(" is quite nervous. I stepped in to said hi, but the poor thing got scared and curled into a ball. When I get ");
					if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("her");
					else outputText("him");
					outputText(" to calm down, we finally could have a proper presentation. All on all, ");
					if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("she");
					else outputText("he");
					outputText(" seems like a fun person, albeit ");
					if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("her");
					else outputText("him");
					outputText(" attention sometimes drifted to my little ‘friend’ as we talked.</i>\"\n\n");
				}
				if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
					if (flags[kFLAGS.SOPHIE_RECRUITED_PURE] > 0) {
						outputText("\"<i>The pink haired harpy on our camp, Sophie, is quite a piece of work.</i>\" the horse-girl says. ");
						outputText("\"<i>She just saw me arriving and tried to hit on me. Little did she know that I’m not that into girls, so she was very disappointed when she found out. Still, she was kind enough to help me unpacking my stuff, so I think that having her near will be nice.</i>\"\n\n");
					}
					if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0) outputText("\"<i>That blondie ditz is really annoying, you know</i>\" the horse-girl says, pointing at you bimbofied harpy, \"<i>I was still unpacking my things and she jumped from nowhere asking if she could suck my dick. Anyways, I guess that she is special to you, so I’ll do my best to be polite with her.</i>\"\n\n");
				}
				if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) outputText("\"<i>Near the stream, I caught sight of a shark fin, and look at my surprise when I found that we were living with one of those tigersharks, that girl Izma. She was not a bloodthirsty or lust crazed as average shark girls, that’s for sure.</i>\"\n\n");
				if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) outputText("\"<i>I also met that cow-looking girl, Izzy. It’s nice to know that I’m not the only tough looking gal at camp, huh? We even had the chance to have a little strength contest.</i>\"\n\n");
			}
			outputText("(<b>Sidonie has been added to the Followers menu!</b>)\n\n");
			flags[kFLAGS.SIDONIE_FOLLOWER] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
		
		public function mainSidonieMenu():void {
			clearOutput();
			outputText("In the mood of spending some time with your camp’s carpenter, you approach Sidonie’s tent and find the horse-morph stretching outside her home, probably taking a break from her job. As soon the the caramel-furred equine spots you, she waves at you and invites you to her tent.\n\n");
			outputText("\"<i>Good to see you, [name]! How things have been going for you?</i>\"\n\n");
			menu();
			addButton(0, "Appearance", SidonieAppearance);
			addButton(1, "Talk", SidonieTalkMenu);
			addButton(3, "Recollection", SidonieRecollection);
			addButton(4, "Sex", SidonieSexMenu);
			addButton(14, "Leave", camp.campFollowers);
		}
		
		public function SidonieAppearance():void {
			clearOutput();
			outputText("On front of you is Sidonie, your carpenter friend. Standing 8ft 5in over, she easily dwarfs most of the camp inhabitants.\n\n");
			outputText("As expected of the horse-morphs that dwell in this realm, she has a equine face covered in creamy-gold colored fur. Bright, azure eyes shine on her head, and a lighter patch of cream fur runs from her forehead to her nose. A long, blond mane with caramel highlights falls from her forehead to her middle-back. Horse ears poke from her hair, flickering from time to time. Silver ear studs decorate them.\n\n");
			outputText("The rest of his body is covered in the same layer of soft, short creamy-gold fur, with a layer of white-cream toned fur running from her neck to her underbelly. Soft DD cups fill her chest as cushiony pillows. Her build is graced by a set of toned muscles, while having a pleasant softness of her butt, hips and lower belly. ");
			outputText("Sidonie now wears a white linen t-shirt, the soft cloth flowing marvellously with the wind, adding to the allure of her upper body. Under that, a tight set of black tights emphasizes her huge package.\n\n");
			outputText("Her arms are also built on strong muscles, covered by a layer of short cream-gold fur, ending in human-like hands, with black, hoof-like nails. She has nice and curvy hips, and a soft but still toned butt. A long equine tail, made of glossy blonde fur falls from it. Her tails has also those caramel tinted accents.\n\n");
			outputText("Her legs are as toned as his body, sleek muscles giving them great strength, her short cream-gold fur keeping them soft enough. A set of equine hooves complete them, giving her steps a notorious sound as she walks.\n\n");
			outputText("Between her legs, a monster of a cock hangs: 20 inches of pure equine meat, mottled in a lovely mix of pink and light brown. When unaroused, it remains inside of her equine sheath. Hanging below, two large balls, measuring about 4 inches each one, eagerly await the opportunity to deposit their hefty load on her next bedmate. Hidden behind them, an equine vagina lies.\n\n");
			outputText("She has a tight anus between her buttcheeks, right were it should be.\n\n");
			doNext(mainSidonieMenu);
		}
		
		public function SidonieTalkMenu():void {
			clearOutput();
			outputText("Looking around at the horse-girl quarters, you tell her that you’d like to chat a bit with her. Sidone nods and smiles.\n\n");
			outputText("\"<i>Sure. sweetheart. What’s on your mind?</i>\"\n\n");
			menu();
			addButton(0, "Herself", SidonieTalkHerself);
			addButton(1, "The Plains", SidonieTalkThePlains);
			addButton(2, "Carpentry", SidonieCarpentry);
			addButton(3, "The Camp", SidonieTheCamp);
			addButton(14, "Back", mainSidonieMenu);
		}
		public function SidonieTalkHerself():void {
			clearOutput();
			outputText("Leaning near where Sidonie is, you casually ask her how, from as places, she ended on the planes. She smiles at you and motions you to sit in a nearby couch. You make yourself comfortable on the seat while she goes to her kitchen for a couple of drinks.\n\n");
			outputText("\"<i>Not an unexpected question, dear</i>\" she says, handing you a glass and sitting at your side. \"<i>I guess that’s kinda weird to see one of mine hanging around in a place full of those gnoll creatures and the like, instead of looking shelter on the city of the sands, huh?</i>\"\n\n");
			outputText("Actually, yes. Almost every equine-morph that you’ve seen before are in Tel’Adre.\n\n");
			outputText("\"<i>That’s because I’m from there. Well, I was.</i>\" she says with a small grin. \"<i>Used to work on a small carpentry since I was twelve, with my uncles. There’s a bunch of them in the city, I bet that you’ve seen a couple of them at least. Mine were specialized in building cabins, tents and outdoor stuff, albeit I still had to learn to make furniture and other parts of the craftsmanship.");
			outputText(" With the demon menaces there’s few people that ventures out of the city, but the Guard members, as well as merchants, have to do that from time to time, so we procure to aid them from the horrors out there with the best of our work.</i>\"\n\n");
			outputText("\"<i>My father insisted on what I had to learn early, to absorb the knowledge of the workmanship while my mind was still fresh and young, so I was an apprentice there for six years. At eighteen, I finally earned my place among the workers.</i>\"\n\n");
			outputText("\"<i>Everything went fine until one day, more or less two years after, a couple of guys from the Watch came to the shop and asked for someone who could aid them repairing an outpost near the outskirts of the desert. None of the workers agreed, since venturing out of the city, even for a noble cause such aiding some members of the Watch in need, was too dangerous for them.</i>\"\n\n");
			outputText("\"<i>Of course, a young and foolish twenty-years old Sidonie was nothing but overjoyed to accompany two guards on an important mission, so I volunteered. If my father or some of my uncles were at the moment, they would’ve stopped me in the act, but that wasn’t the case, so I was walking through the desert with the Watch guys shortly after.</i>\"\n\n");
			outputText("\"<i>We arrived the post a couple of hours later. It looked a bit weary and broken, especially since it was exposed to the sand and heat from the desert. Fixing the damaged post for the  guys wasn’t a difficult task in the end, since it only needed replacements on the outer walls and some new flooring.</i>\"\n\n");
			outputText("You ask her if the Watch recruits that came to her shop couldn’t simply have bought planks and then do the repairs themselves?\n\n");
			outputText("\"<i>Because not matter how strong or brave they are, there are things that require a carpenter’s skilled hands to be done properly. If they had fixed the outpost themselves, well the outpost would be repaired...a bit crudely, and probably fall apart a couple of months later, hence they opted to ask one of us to make the repairs in-site.</i>\"\n\n");
			outputText("\"<i>As you could’ve noted, I finished my task without major difficulties, but on the returning trip, a sandstorm caught us. Unlike the watch guys, I had no knowledge of the desert geography, so I’d probably wandered during days. When I finally saw how the sand turned into fresh, green grass, I was nothing but relieved and grateful.</i>\"\n\n");
			outputText("\"<i>After satisfying my thirst in a well, I explored the area finding a way home, hoping to see the outline of the city from an area bordering the plains. After a week or so, I started giving up hope, so I interned myself on the grass, looking for a place to look for indications.</i>\"\n\n");
			outputText("\"<i>Just a few days later, I found myself stormed by a cacophony of guttural laughters: a gnoll hunting party. Around thirty warriors, carrying spears and javelins surrounded me by all sides. The situation was pretty ugly, but even while I was no Watch woman, I’d still put up a fight.</i>\"\n\n");
			outputText("Seems like that didn’t work, given how gnolls were hot on her heels.\n\n");
			outputText("\"<i>I’m here, so that says a lot. There was no way that we could escape from all of them, but I managed to bring to the ground several, eleven of them, If I recall well.</i>\" she points \"<i>Then, there was this massive shadow looming over me: the goddamn matriarch.</i>\"\n\n");
			outputText("\"<i>The she-bitch almost took me down, but somehow, possessed by a strength that I didn’t know that I had, I managed to bring her to the ground.</i>\" Sidonie smiles, then shakes her head. \"<i>Only to be piled on by a dozen of her guards.</i>\"\n\n");
			outputText("\"<i>Amazingly, she told them to stop. Standing up, the matriarch told me that she was impressed of my battle skills, so much that she was going to let me walk free that time.</i>\"\n\n");
			outputText("Wait a minute, weren’t those the gnolls who attacked her?\n\n");
			outputText("\"<i>Of course not, that happened some years ago. The gnolls of that village and I were always on friendly status, save for that first encounter.</i>\"\n\n");
			outputText("How so?\n\n");
			outputText("\"<i>As I said, the matriarch was very impressed of my skills, and when she knew that I was a skilled carpenter, asked me to come to his village to repair a couple of things. A bit wary, I came and did the job, and, to my surprise, instead of locking me there, they thanked me and paid me with food and water. Seems like not all of those gnolls are a bunch of morons.</i>\"\n\n");
			outputText("\"<i>From time to time, I went to the village, doing some repairs and assembling furniture, and they always paid me generously. The matriarch was so pleased one time that I refurbished her tent, that offered me to stay on the village as her consort queen. As tempting as it was, I still entertained the idea of returning to my home, so I declined.</i>\"\n\n");
			outputText("\"<i>I kept wandering the grasslands for several years, practicing my carpentry with the sparse wood in the plais, and visiting my hyena-like friends from time to time. A good day, I was spotted by a different tribe of gnolls, but these were more interested to turn me into their slave than use of my services. ");
			outputText("Luckily, a brave [race] " + player.mf("guy","girl") + " came that day, and help me in that time of need, so thanks to " + player.mf("him","her") + ", I’m safe here.</i>\"\n\n");
			outputText("You think that you’ve heard that before.\n\n");
			outputText("\"<i>Oh, really?</i>\" She says, sticking out her tongue playfully. \"<i>Anyways, once in " + player.mf("his","her") + " camp, I became the local carpenter, and I’m quite happy about how that turned out. ");
			outputText("A couple of days later, I managed to get into Tel’Adre again, and after several years of absence, meet my father again. He almost passed out when he saw me again, and we spent the next hour crying of happiness in each other arms.</i>\"\n\n");
			outputText("\"<i>We caught up with each other for the rest of the day, but when he asked me to return to the family workshop, I told him that I was already working as a carpenter in a safe place, not so far from Tel’Adre. He was quite happy of that I had found a job.</i>\"\n\n");
			outputText("\"<i>So, all in all, that has been my life. In the end, seems like somehow thing turn better than I expect, and have to thank Marae for that, and of course, thank you for being such a friend.</i>\"\n\n");
			outputText("Smiling, you thank Sidonie for her story, stating that you’re also happy for how everything turned well at the end.\n\n");
			doNext(SidonieTalkMenu);
		}
		public function SidonieTalkThePlains():void {
			clearOutput();
			outputText("This time, you're curious about what Sidonie experienced when she was living on the plains, so you ask her a bit more about it.\n\n");
			outputText("\"<i>As I told you, I got acquainted of a tribe of gnolls, and often spent time on his village. Sadly, the rest of the hyena-like creatures weren’t as nice as my friends. Wandering across the plains, more often than not I encountered the hostile tribe of them, keen on raping me, or worse, not unlike those you beat when me met.</i>\"\n\n");
			outputText("\"<i>There was also this red-head bitch, that tried to knock me down to steal a ride on my pole. Managed to get to it two times, the first one taking me by surprise when I was working on a lacquered chair, and a second time when she used that flaming tail of hers to burn my tail, and knocking me out with her scimitar while I was busy putting down the fire. ");
			outputText("Bitch. Next time that I met that cunt I slapped so far that she didn’t came back in two weeks.");
			if (followerHel()) outputText(" The redhead girl on your camp reminds me a bit of her, but since she hasn’t come yet to hit on me, I doubt that they’re the same person. Still gives off the ‘haughty slut’ vibe.");
			outputText("</i>\"\n\n\"<i>Ah, probably the most fun thing on the plains are those satyr boys.</i>\"\n\n");
			outputText("The rapist satyrs wandering the grasslands? How that could be fun, you ask her.\n\n");
			outputText("\"<i>You have to know, once you’re capable to beat a bunch of gnolls, those satyrs aren’t a menace anymore. To make everything better, they go alone most of the times, so I only needed a couple of well placed hits to bring them down.</i>\"\n\n");
			outputText("So, they aren't’ much of a nuisance, unlike gnolls.\n\n");
			outputText("\"<i>It’s not only that, [name].</i>\" She adds, with a subtle wink. \"<i>A girl like me has her...needs, from time to time.</i>\" You attention diverts for a second to the bulge on her pants. \"<i>Since I don’t want to risk myself with the gnolls or the other plain creatures, and given that those guys are an easy catch, I hunted them each time that I wanted to bust a nut.</i>\"\n\n");
			outputText("\"<i>Figures that somehow, satyrs reproduce by inseminating another’s mate butt. So, the first time that I caught one of those guys, and left his belly round, and his butt leaking of Sidonie-brand cream, he started whining about how he doesn’t wanted to get pregnant. He must have been a bit young, since he didn’t know that only satyrs can fertilize other males. ");
			outputText("Whatever it was, they guy probably liked it, because the next week he came again, and this time he only let out moans instead of whines. After a while, I got myself a group of satyrs that sought after me only to get themselves a good dicking. They even faked the fights sometimes, falling to the ground, ass up, even before I actually hit them.</i>\"\n\n");
			outputText("Interesting, and aside sexual stuff, what else has she seen on the plains?\n\n");
			outputText("\"<i>Well, there is this sheep village. I tried to get in once, but was late on the night, and I saw some demons flying near a well in the middle of the place, so I ran the hell out of that place. No townsfolk who lives with demons is a trustworthy company. Besides that, there’s a bazaar, full of tents and stores. ");
			outputText("Reminds me a bit of Tel'Adre, except for its rampant debauchery and the occasional demon wandering the streets. Still, is a good place to rest, since the morphs living there don’t let the demon people get too cocky. I loved eating in the main restaurant, and their satyr waiter had one of the most delicious asses that I’ve fucked.</i>\"\n\n");
			if (flags[kFLAGS.BAZAAR_ENTERED] > 0) outputText("You’re sure that the Bazaar is quite the place. And everything from the Black Cock has the fame of being quite delicious.");
			else outputText("You’ve still to visit that place, but from all you’ve heard, seems like it’s worth the effort.");
			outputText("\n\n\"<i>Not too common, but I’ve managed to see kangaroo-morphs. I saw a lone ranger one time. She looked odd tho, because unlike most morphs, she had a humanoid face. Since in Mareth, having a human face means that either you gulped down a bunch off corrupted stuff, or are a demon, and in some rare cases, that you come from afar, I decided to play safe and stay away. ");
			outputText("On another side of the plains, I saw another kangaroo-morph, and he was huge .I bet that he was taller than me, and that is something. Unlike the other, this guy was a proper morph, with that snout and pointy ears that kangaroos have. ");
			outputText("He looked a bit depressed when I saw him, but before I could talk to him, he rushed to a hole in the ground, probably one of those burrows that kangaroo-morphs have been digging since the demon outbreak, and sealed the door with a wooden plank.</i>\"\n\n");
			outputText("Odd.\n\n");
			outputText("\"<i>Quite.</i>\"\n\n");
			outputText("\"<i>There’s also this random blue-haired woman that I see bouncing here and there. She looks a little like a marten, and has those sparks flowing from her body from time to time. I’ve heard her complain about that often, albeit if that’s a problem for her, ");
			outputText("she’d better not rub her body against the static charged fences that cross some parts of the plains. Besides that...I think that I’ve seen a flying guy over the plains, but since I’ve never gotten close, I don’t know much more about him.</i>\"\n\n");
			outputText("\"<i>So, that’s more or less what I’ve managed to see on the plains. It’s not that bad of a place, and things are fun enough, if you know where search.</i>\"\n\n");
			doNext(SidonieTalkMenu);
		}
		public function SidonieCarpentry():void {
			clearOutput();
			outputText("Looking at the masterfully carved pieces of furniture near Sidonie’ place, you ask her how is her job, and if she likes it?\n\n");
			outputText("\"<i>Ah, the second question is easy, [name]</i>\" she warmly answers ");
			outputText("\"<i>Of course that I like it, either way I would be doing something else for a living. Given my experiences with the plains, that wouldn’t be hard, but this job is part of my family legacy, and I really value what that means. Also, taking a featureless piece of wood and turning it into luxurious furniture, or a lacquered artifact always fills me with pride.</i>\"\n\n");
			outputText("Given the quality of the things that she has managed to craft, you have to agree with her on that.\n\n");
			outputText("\"<i>Now, about how the work goes...that’s a bit more tricky. Carpenters usually don’t limit their jobs to simply cutting wood. Given the kind of thing that you’re making, you usually have to polish your artisan and lacquerer abilities, because sometimes, even if the product is sturdy and useful, people may not like since it’s lacking aesthetics. Other times, that is not important, ");
			outputText("and you can focus on the practical stuff.</i>\"\n\n\"<i>In the end, the product must fulfill the use that it was created for, not matter how simple or luxurious it looks. Once you’ve decided what you’re going to do, the next choice is about the materials. Many people oversimplify, and thinks that we only use wood, nails and varnish, but there are hundreds of types of woods that you can use, ");
			outputText("and you must pick the right one for the right job.</i>\"\n\nLooks like woodworking is much more complicated than you thought on first place.\n\n");
			outputText("\"<i>It is. But, as I said, once you see a finished piece, you cannot help but feel that all you effort worth it. On top of that, all the physical works also pays off in other areas. How do you think that I’ve got a body like this, huh?</i>\"\n\n");
			outputText("The horse-morph boasts a bit, showing you the muscles in one of her arms. You grin at the show of self-confidence, touching Sidonie’s bicep with a ‘hmm’. You give her a thumbs up and thank her for explaining you about her creations.\n\n");
			outputText("\"<i>Anytime you want, [name].</i>\"\n\n");
			doNext(SidonieTalkMenu);
		}
		public function SidonieTheCamp():void {
			clearOutput();
			if (!buildedAnythingInCamp()) outputText("\"<i>I see that you follow the ‘less is more’ idea.</i>\" Sidonie jokes. \"<i>That said, this place seems a bit far from the rest of Mareth, while, at the same time is recognizable enough to be easily found if you know what you’re looking.</i>\"\n\n");
			if (flags[kFLAGS.CAMP_WALL_PROGRESS] >= 100) {
				outputText("\"<i>Seems like you went for a good old palisade as a barrier against Mareth’s vermins. Very smart of you.</i>\" She remarks. \"<i>Albeit I’m not sure about how It would fare against an army of demon soldiers.");
				if (flags[kFLAGS.CAMP_WALL_SKULLS] >= 1) outputText("Still, those skulls send a clear message to that corrupted scum.");
				outputText("</i>\"\n\n");
			}
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 0) {
				if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("\"<i>Now I see where all the wood that you requested from me before went. It’s good to know that you have given it a good use. When I checked it seems solid and well built, and I bet that sleeping in a proper bed beats having to sleep on the ground, by far.</i>\"\n\n");
				else outputText("\"<i>You must really like that bedroll of yours, by what I’ve seen. Not judging, of course. I suppose that it must be quite cozy. I’m only worried about that you could be a bit...exposed, in here.</i>\"\n\n");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) {
				outputText("\"<i>There are those baths. I really enjoy them");
				if (anyHermInCamp()) outputText(", and since some of us girls have extra ‘equipment’ too, I’m quite comfortable with them,");
				if (player.hasCock()) {
					outputText(" though I’ve to admit, a couple of times I’ve taken a peek about what you");
					if (anyMalesInCamp()) outputText(" guys");
					outputText(" are doing on the other side");
				}
				outputText(".</i>\"\n\n");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) {
				outputText("\"<i>And it’s good to have a place where release frustrations in a friendly way. Serves me well to keep fit, too.");
				if ((isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) || followerKiha() || emberScene.followerEmber() || player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) outputText(" Though some of our pals are really hard to crack.");
				outputText("</i>\"\n\n");
			}
			doNext(SidonieTalkMenu);
		}
		
		private function object():String {
			var buffer:String = "";
			var temp:int = rand(4);
			if(temp == 0) buffer += "white-striped bark";
			else if(temp == 1) buffer += "a walnut-like appearance";
			else if(temp == 2) buffer += "a lemon-smelling bark";
			else buffer += "mahogany color on them";
			return buffer;
		}
		public function SidonieRecollection():void {
			clearOutput();
			outputText("A bit tired of having to wander aimlessly searching for wood pieces for your building projects here and there, and not in the mood of paying an exorbitant amount of gems for them, you go to Sidonie’s place, to see if she can help you picking and getting some wood.\n\n");
			outputText("The horse-morph is currently relaxing, sitting on a bench at her tent entrance. Here, you ask her is she could give you some help searching for some wood. Sidonie nods, then says:\n\n");
			if (flags[kFLAGS.SIDONIE_RECOLLECTION] > 0) {
				outputText("\"<i>Sorry, [name]. I’m still tired from our last wood-chopping session</i>\" Sidonie apologizes. \"<i>Maybe tomorrow, once that my muscles have rested enough.</i>\"\n\n");
				outputText("Nodding, you tell her that’s okay. It’s not like you are going to get much done with one of the two of you too tired.\n\n");
				doNext(mainSidonieMenu);
			}
			else {
				outputText("\"<i>Okay, [name]. I’m free right now, so we should go.</i>\"\n\n");
				outputText("With that, she goes inside her place, coming out a minute later with a wagon carrying inside two axes, a saw, and some wood-cutting tools. She hands on axe two you, then explains.\n\n");
				outputText("\"<i>We’re going to a southwestern section of the forest, near those deepwoods. That’s where the best wood is.</i>\"\n\n");
				outputText("You follow her out of the camp, arriving the forest without major issue. Seems like no imp is taking the risk of attacking two axe-wielding travelers. Once you arrive, you immediately notice how this section of the woods is quite different from the rest. No sign of corruption is near, and the usual marks left in trees by wandering satyrs or goblins are absent. Sidonie motions you to stop in a clearing, surrounded by particularly tall and thick trees. Their trunks emanate an aromatic smell, a total contrast from the sex-smelling glade that you’ve found sometimes.\n\n");
				outputText("\"<i>Here, [name]. We’re cutting a couple of those.</i>\" The horse-morph carpenter says, pointing a duo of threes with " + object() + ". \"<i>The wood on them should be enough to keep us busy today, and our stock will be filled with it by the end of the day.</i>\"\n\n");
				outputText("Each one of you positions near a tree and start cutting them with you axes. Sidonie has little trouble bringing down her tree, while you ");
				if (player.str < 50) outputText("require a bit more time for it");
				else outputText("chop the wood without any particular issue");
				outputText(", keeping a good pace with her own rhythm. Once both trees are down, you spend the next hour removing the bark and using the two-man saw that she brought to cut the log into planks.\n\n");
				outputText("The remaining two hours are spent reducing those planks into a more manageable size, softening it with sandpaper and bringing it back to the camp in the wagon. The clearing is quite devoid of any kind of hostile wildlife, so the process is painless, but tiresome. Both of you are left sweaty and exhausted, albeit you are quite satisfied by the huge amount of high-quality wood that you’ve brought home. ");
				outputText("Sidonie seems a bit affected by the work-induced heat, so she has to excuse herself to jerk off. You manage to see her pint-sized globs of cum staining the grass and sawdust lying on the ground when you’re collecting her pieces of wood to put them on the wagon.\n\n");
				outputText("Once the last load of wood has been brought to the camp, you pick the tools on the wagon and return to the camp, satisfied with today’s work.\n\n");
				flags[kFLAGS.SIDONIE_RECOLLECTION] = 22;
				if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 300;
				else {
					if ((flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + 300 ) < 900) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 300;
					else flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 900;
				}
				doNext(camp.returnToCampUseFourHours);
			}
		}
		
		public function SidonieSexMenu():void {
			clearOutput();
			if (flags[kFLAGS.SIDONIE_SEX_MENU] == 1) {
				outputText("Seeking again for another session in the loving horse-morph companionship, you enter her tent again, and spot her on the usual spot. She locks you in a tight embrace, and says.\n\n");
				outputText("\"<i>Coming for a bit more of horsey loving?, sweetheart?</i>\"\n\n");
				outputText("You nod eagerly, and jump to her side on the couch. Both of you stripe each other, some gropes exchanged as clothes are tossed away. You rest your head on Sidonie’s bosom, sniffing on her very pleasant smell, a bit reminiscent of nature and wilderness. Then, both of you lie on her couch, groping at each other lustily, the contact between her caramel fur and your ");
				if (player.hasFur()) outputText("own ");
				else outputText("" + player.skinFurScales() + " ");
				outputText("fueling the desire between you two even more. Once you’ve foreplayed enough, you lie on Sidonie’s arms, her erection poking your thigh.\n\n");
				outputText("\"<i>Okay, frisky " + player.mf("boy", "girl") + ".</i>\" she ask you, planting a soft kiss on your neck \"<i>What’s on your mind?</i>\"\n\n");
				dynStats("lus", 33);
			}
			else {
				outputText("You walk casually near the horse-morph place, and manage to see that she has interrupted her daily routine. Judging about how she has her shirt unbuttoned and folded over her shoulder, having only a white, sleeveless piece covering her ample bosom.\n\n");
				outputText("As she enters her tent, Sidonie catches you and waves you over, undisturbed by having his upper body almost exposed to you. Probably the time living on the plains made her lose a bit of her inhibitions. A bit awkwardly, you return the greet and go to her side. Here, she invites to your home, telling you that she relaxing on her place for a bit.\n\n");
				outputText("When you come in, the first thing that catches your attention is how tidy is the place. No sight of sawdust, or any kind of dirt. Her furniture is clear and looks as it were brand new. The entire places has an aromatic fragrance.\n\n");
				outputText("\"<i>It’s nice to have you here, hon.</i>\" Sidonie says, distracting you a bit from the contemplation of her place. \"<i>Being a Champion and all has to be tiring job, and knowing that even with that, you take you time to spend it with your friends always makes me happy.</i>\"\n\n");
				outputText("Well, it’s not like you would reached far without your friends help. And even if you did, you would be awfully lonely.\n\n");
				outputText("\"<i>Aw, that’s very kind of you. Look, sweetheart. I’m gonna get changed, so you rest a bit here.</i>\" she says pointing at a couch near where you area. \"<i>Wait for me, and once I’m done, I’ll bring some mead for us to drink.</i>\"\n\n");
				outputText("Sounds good, you tell her. With that, she goes to the other side of, as you notice now, her very large tent. A bit later, she returns with said drinks, and, to your surprise, with a much simpler attire than before. Covering her chest is a similar piece, but, instead of her usual denim pants, she’s now using a white set of shorts that do little to hide her enormous bulge.\n\n");
				outputText("\"<i>Here, [name], have some.</i>\" Sidonie says, passing you a glass filled with honey-scented mead. \"<i>So, Champion, how are things going with you crusade for our homeland?</i>\"\n\n");
				outputText("You tell her about you late accomplishments, and how the menace of the demons, albeit still present, is gradually receding. Still, the average Marethian seems a bit hornier than most people than you knew before arriving.\n\n");
				outputText("\"<i>Yeah I get you. Every now and then I had to bust a nut inside of one of those prancing satyrs, else I’ll end up captured by a random critter that had taken advantage of my lust.</i>\"\n\n");
				outputText("That doesn’t sound too different about what you have to do with some of your attackers.It’s good to hear that you’re not the only one on that situation. You decide to change topic, and both of you talk for a good while about what do you hope for this land after the demons go, about how Sidonie business is booming");
				if (flags[kFLAGS.HEXINDAO_UNLOCKED] > 0) outputText(" and now she’s selling a lot of pieces to the He Xin Dao folks,");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText(" or how the sky, slowly but surely, is acquiring a more blueish color");
				outputText(". Several glasses of mead are exchanged on the meanwhile, making both of you gradually affected by the honey-scented drink.\n\n");
				outputText("\"<i>Hey, [name]. i think that it’s enough mead for a while.</i>\" Sidonie remarks, putting aside the bottle of mead. \"<i>Mind if we stay together and cool down while the effect passes?</i>\"\n\n");
				outputText("Sure, you won’t mind that. Soon you’re hugged by the ");
				if (player.tallness < 72) outputText("much larger");
				else if (player.tallness < 96) outputText("larger");
				else outputText("equine");
				outputText(" and put on her side. You rest you head over her mane, and notice that both her hair and fur emanate a soft, floral scent. Did she bathe before returning with the drinks? It does matter, her smell is so good, and you can’t help yourself, as you bathe on her fragrance. Before you can tell it, you nuzzling on her chest, face almost buried on her pillowy breasts.\n\n");
				outputText("\"<i>Huh, sorry</i>\" you excuse yourself. \"<i>I didn’t mean to...</i>\"\n\n");
				outputText("To you surprise, Sidonie only smiles.\n\n");
				outputText("\"<i>About time for you to catch up with my signals, " + player.mf("boy","girl") + ". I was starving for some company, and having a sweetheart like you, it's, hard to resist, you know?</i>\" she says, and then is when you realize that the equine girl has gotten a boner from your close contact, the thick horsecock tenting her shorts. You can even see the outline of its veins through the fabric. Seems like your friends has taken a fancy to you.\n\n");
				outputText("On your side, you also feel somewhat aroused, as the fact that your head is resting on her bosom fuels an increasing fire on your loins, with your ");
				if (player.gender == 3) outputText("with your [cock] getting harder and your [vagina] getting wetter as time goes");
				if (player.gender == 1) outputText("[cock] getting harder");
				if (player.gender == 2) outputText("[vagina] getting wetter");
				outputText(".\n\n\"<i>Look, [name]. Regarding sexy stuff, I’m a girl who takes what she likes. Maybe the time on the plains gave me some bad habits, since there most company is a bunch of rapey monsters, but here, you’re different, being with you is different.For me, you’re more than a friend, and by the same reason, I don’t want to push you into anything, but if you’d like to try something special with me, I’ll be more than happy.</i>\"\n\n");
				outputText("Looking at Sidonie, you tell her that you’d love to. For you she is more than a friend too, and what would worth saving Mareth, if, at the end of the day, you won’t spend intimate time with those that you care?\n\n");
				outputText("The horse-girl gives you a relieved sigh, and hugs you with all her strength, almost knocking the air out of your lungs. Not wanting to waste more time, the horny equine tosses away the little fabric covering her breast, that jiggle and bounce playfully. Soon her short and undies go away, leaving her horsecock and large nuts exposed to you. ");
				outputText("You do the same, slowly taking off your clothes, until you are naked, every inch of your [skin] covered body exposed to the horse girl, with shamelessly ogles at your ");
				if (player.hasCock()) outputText("[cock]");
				if (player.hasVagina()) outputText("[vagina]");
				outputText(".\n\nBoth of you lie on her couch, groping at each other bodies lustily, the contact between her caramel fur and your ");
				if (player.hasFur()) outputText("own ");
				else outputText("" + player.skinFurScales() + " ");
				outputText("fueling the desire between you two even more. Once you’ve foreplayed enough, you lie on Sidonie’s arms, her erection poking your thigh.\n\n");
				outputText("\"<i>Okay, frisky " + player.mf("boy","girl") + ".</i>\" she ask you, planting a soft kiss on your neck \"<i>What’s on your mind?</i>\"\n\n");
				flags[kFLAGS.SIDONIE_SEX_MENU] = 1;
				dynStats("lus", 33);
			}
			menu();
			addButton(0, "Get fucked", SidonieSexGetFucked);
			addButton(1, "Blow her", SidonieSexBlowHer);
			if (player.hasCock()) addButton(2, "69", SidonieSex69);
			//addButton(3, "Anal", SidonieSexAnal);
			//addButton(4, "Vaginal", SidonieSexVaginal);
			addButton(14, "Back", mainSidonieMenu);
		}
		public function SidonieSexGetFucked():void {
			clearOutput();
			outputText("Feeling a bit bold this time, you look at the juicy horsecock hanging between the blondie equine’s legs, and tell Sidonie that you’d like to receive a good, hard pounding.\n\n");
			outputText("\"<i>Hmm, you sure about that, sweetheart? A ride on my horsie pole isn’t exactly something easy to handle</i>\" she tells you.\n\n");
			outputText("Nodding, you’re assure that you’re eager to have her on you, you eyes locked on the pink pillar of meat dangling near you.\n\n");
			outputText("\"<i>Well, dear...</i>\" the equine girl answers, taking you to her bedroom. \"<i>let’s get started then</i>\" You notice by the way that her horsecock stands proudly erect now, that she’s as eager as you to have her cock buried on your ass.\n\n");
			outputText("As you enter the place, the sweet scent of sandalwood hits your nose, and you quickly find the source, as you see how her bedroom is decorated by finely crafted wooden pieces. Soft furs are placed on the walls and floor, the center of the room occupied by a huge bed in with a cushy mattress over which you’re gently placed.\n\n");
			outputText("Relaxing your muscles, you lie over Sidonie, being quicking enveloped by her strong but tender embrace. The equine girl proceeds to caress every inch of your naked body, kissing your neck and ticking your " + player.skinFurScales() + " with her equine tongue, giving you soft kisses on the process. She then plays with your [nipples], caressing and teasing their soft flesh.\n\n");
			outputText("As both of you grow increasingly aroused, you enjoy how Sidonie’s caresses turn into kinkier gropes, and how her hands go from teasing your [chest] to groping your ");
			if (player.hasCock()) outputText("increasingly hard [cock]");
			else if (player.hasVagina() && !player.hasCock()) outputText("crotch, idly teasingly your clit");
			outputText(".");
			if (player.balls > 0) outputText(" From time to time she grabs your [sack], playing teasingly with the soft " + player.skinFurScales() + " covering your ballsack.");
			outputText("\n\nBefore you realize it, you’re really worked up after all those ministrations, ");
			if (player.gender == 3) outputText("your [cock] achingly hard and your pussy wet and needy");
			if (player.gender == 1) outputText("your [cock] achingly hard ");
			if (player.gender == 2) outputText("your pussy wet and needy ");
			outputText(". Below you, the horse-girl gigantic rod leaks pre against you buttocks, and the idea of having it soon spearing you only excites you even more.\n\n");
			outputText("\"<i>So, pretty little thing...</i>\" Sidonie whispers on your [ears] \"<i>Ready for all the naughty things that I’ve planned for you?</i>\" One of her fingers teasingly prodding your [asshole] as she does that.\n\n");
			outputText("Your only answer is a submissive moan, as she slips another one and starts playing with your soon-to-be-stretched anal walls.\n\n");
			outputText("She places you lying on the bed, ass up, and you shake your ");
			if (player.tail.type > Tail.NONE) outputText("[tail] enticingly");
			else outputText("backside enticingly to her");
			outputText(", which is answered by a playful buttslap. Soon, strong arms grab your butt and spread apart your buttcheeks, leaving your pucker vulnerable to the horse-girl desires. Then you feel it. The unmistakable sensation of her wide flare poing your tailhole, her cumslit soaking the [player.skin.coat.color] " + player.skinFurScales() + " of your butt.\n\n");
			outputText("Done with the foreplay, Sidonie starts pushing her massive meat pole in, taking your breath aways as she impales you in that delicious horsecock. Your anal walls are forced apart, as inch after inch of her cock make its way inside you, her flare spreading your inner muscles. Seeing how you seem to have some issues taking a cock as big as hers, she goes slow and gently, bit by bit, sheathing her cock in your ass slow enough to don’t force your body, but fast enough to be unbelievably wonderful. ");
			outputText("The sensation of her meat spearing you takes away any kind of pain that you may had, and replaces it with a sheer feeling of pleasure. Once all off her equine member is in, the horse-girl gives you a moment of reprieve to get used to its sheer size, and then starts fucking your doggie-style!\n\n");
			outputText("Her hands take a strong grip on your hips, and she pushes her erection deep enough so her hips collide against you butt. You’re utterly filled with her meat, and you’re loving every fucking second of it, feeling her hot rod pulsating inside your slutty ass. Then, she slides her meat out, leaving your bum painfully empty, locked to her dick only by the the wide flare resting inside your tailhole. Thankfully, she doesn’t let you empty for long, her dick quicking ramming her way inside again, ");
			outputText("with such force that you collapse on the bed, your [legs] spread apart as you’re reduced into a slutty, moaning mess under the horse-girl continuous anal assault. Your ");
			if (player.gender == 1) outputText("[cock] is hard and leaking precum, your body taken by lust under the dicking that you’re getting");
			if (player.gender == 2) outputText("[cunt] is wet and needy for the dicking that isn’t getting");
			outputText(".\n\nSidonie’s keeps at her own pace sliding her horsecock in and out of your stretched hole with an almost feral desire. Every now and then she slaps your butt again, earning a surprised yelp from you. Under her, you feel (and see) how her massive dong makes her way in and out from your as its unmistakable bulge appears through your belly.");
			if (player.wings.type > Wings.NONE) outputText("One of her hands puts away your [wings] near your shoulder, so she can see your panting face while she pounds you.");
			outputText("\n\nA horse-like neigh from Sidonie and a particullary strong pump from her horsecock announces you that she’s close to her climax. Not much after, you feel her tensing, her flare growing even wider as she orgasms, her cumslit opening the floodgate to a torrential load of fresh seed that invades your bowels. Jet after jet, the seemingly unending torrent of fresh cum fills your butt and starts inflating your belly. ");
			outputText("The outline of her penis disappears from your belly under the cum deluge that you gut is having. You pant hard, enjoying all that seed filling your innards and that wonderful warm feeling that it gives you");
			if (player.hasCock()) outputText(", your own [cock] erupting below you at the pleasure of having Sidonie cumming inside you");
			outputText(". After a long while, her load seems to subside, and she removes her cock, the last streaks of her seed splattering your buttcheeks.\n\n");
			outputText("Thoroughly ploughed and seeded, your abused butt is left a mess of leaking horse cum. Sidonie’s fresh seed leaks from your overflowed tailhole, staining your " + player.skinFurScales() + ". The horse girl hops to your side on her bed, and embraces your cum-filled form, making your ass leak a little of her load as she grabs you, surrounding your body and drifts to sleep. Not being able to walk given the pounding that you just had, you decide to follow her.\n\n");
			outputText("After a relaxing nap, it seems like your body has absorbed most of her seed and is able to walk again. Waking up Sidonie with a kiss, you thank her for a wonderful fucking and disentangle from her embrace to return to your daily activities, a pleasant tingling on your butt left by the remaining horse seed left on your bum.\n\n");
			player.orgasm();
			player.slimeFeed();
			doNext(camp.returnToCampUseOneHour);
		}
		public function SidonieSexBlowHer():void {
			clearOutput();
			if (player.lib > 75) outputText("Lustily,");
			else outputText("A bit unsure");
			outputText(" you ask Sidonie is she’d like receiving a blowjob. She must be quite pent up after all.\n\n");
			outputText("\"<i>So, you aching of some of Sidonie’s special brand of sugar, huh, [name]?</i>\" The horse-morph answers, grinning. \"<i>Don’t worry, sweetheart, this girl has a lot of love to give you.</i>\" She rubs her groin, moving your focus to her growing erection.\n\n");
			outputText("The equine girl relaxes, splaying her arms over the couch and opening her legs, giving you a easy access to her crotch.\n\n");
			outputText("\"<i>Come on, hon. Don’t leave a girl waiting</i>\" she remarks, pointing at her increasingly hard penis.\n\n");
			outputText("You kneel in front of the horse-morph crotch, taking her equine manhood in your hands, and feeling its sheer size and girth, you gulp, thinking to yourself that maybe you bite off more of than you can chew.\n\n");
			outputText("Closing your ");
			if (player.hasMuzzle()) outputText("muzzle");
			else if (player.hasBeak()) outputText("beak");
			else outputText("lips");
			outputText(" to the gigantic erection, you bask of Sidonie's scent. It's not as overpowering as you may've thought, but soft and pleasant, with a slightly musky undertone. Compelled by her aphrodisiac scent, and the sight of her raging erection in front of you, your lips lean closer to her flared cockhead. You feel your cheeks flushing and your body getting hotter as a result. Soon, you find yourself nuzzling Sidonie's cock, inhaling as much as you can of her sweet fragrance.\n\n");
			outputText("While you do so, one of your hands goes and grabs on one of her equine orbs. They're so big that you barely can hold one with your hands. Allured by their scent, you decide to start with them, [tongue] happily licking the soft furred skin. The cum sacks churn at you ministrations, filled with the hefty reward that you’re seeking to get. You keep worshipping her balls, until a droplet of pre on your shoulder makes you focus your attention back on you wanted on the first place: her cock.\n\n");
			if (player.hasBeak()) outputText("You slide your tongue playfully over Sidonie’s ");
			else outputText("You plant a kiss on Sidonie’s flare, ");
			outputText("earning a pleased moan from the equine and leaving your [face] covered in her pre in the process. Slowly, you sink your ");
			if (player.hasMuzzle()) outputText("muzzle");
			else if (player.hasBeak()) outputText("beak");
			else outputText("mouth");
			outputText(" on her rod, engulfing its flared head the best you can, a task that proves itself quite difficult given how wide is the thing.\n\n");
			outputText("Growing a bit impatient, the equine girl takes your head on her hands, softly pushing her erection into your ");
			if (player.hasMuzzle()) outputText("muzzle");
			else if (player.hasBeak()) outputText("beak");
			else outputText("mouth");
			outputText(" with one hand while she ");
			if (player.hairLength > 0) outputText("tousles your hair");
			else outputText("caresses your head with the other");
			outputText(". She is slow at the start, slowly pushing her horsecock inch by inch into your throat and leaving you enough time to relax your mouth. Inch by inch, her meat slowly but surely starts filling your throat, task only eased by her copious pre leakage that makes for makeshift lube.\n\n");
			outputText("A bit accustomed to Sidonie’s slow pace, you’re taken a bit by surprise when she forces her length down your gullet, which is forced to open wide to accomodate the impossibly thick horsecock. Twenty inches of meat ram you throat, and you soon a bit lightheaded by the sudden lack of air. Luckily, your gag reflex doesn’t fail, and you manage to push it down your throat without blacking out, doing your best to breathe through your ");
			if (player.hasBeak()) outputText("beak");
			else outputText("nose");
			outputText(".You’re given a bit of reprieve as the horse-morph slides most of her dick out, her flared tip being the last bit that locks you mouth to her dong. The horse-girl takes a hold of your head, as if telling you what is to come, and then, she rams her cock inside again. Feeling your throat, you can feel the outline of the bulge made for her thick horsecock through your [skin], and make out some of the pulsing veins of the throbbing member. \n\n");
			outputText("She keeps doing this for a good while, truly sliding in and out and truly face-fucking you, while the heady salty taste of her girth is being left on your mouth, and her overflowing pre splattering your ");
			if (player.hasMuzzle()) outputText("muzzle");
			else if (player.hasBeak()) outputText("beak");
			else outputText("lips");
			outputText(". Down below, your ");
			if (player.gender == 1) outputText("[cock] aches");
			if (player.gender == 2) outputText("[vagina] aches");
			if (player.gender == 3) outputText("[cock] and [vagina] ache");
			outputText(" in arousal from the overstimulating experience.\n\n");
			outputText("Sidonie keeps giving your face a rough fucking for a good while, her virile nuts slapping against your [face] as he does that. Soon, the arousal building in your loins becomes too much, and you unattended ");
			if (player.gender == 1) outputText("cock erupts in a hot, cummy mess.");
			if (player.gender == 2) outputText("pussy wets itself with girlcum.");
			if (player.gender == 3) outputText("cock erupts in a hot, cummy mess, while you pussy wets itself with girlcum.");
			outputText(" Not much later, the horse-girl’s body tenses, as she seems to be reaching her peak.\n\n");
			outputText("\"<i>Huff, here it comes, [name]</i>\" the equine girl announces with a lusty moan. \"<i>Drink it all!</i>\"\n\n");
			outputText("With that, she slams her horsecock down your throat one last time, which soon erupts in a cascade of thick, hot cum. Sidonie releases load after load of her seed down your gullet, bathing your taste buds in its salty flavour. Under the flood of spooge that it’s receiving, your belly quickly inflates, until you look so rotund that anyone would mistake your cum-filled paunch with a nine-months pregnancy. Once that you cannot hold more of her seed on your belly, you let go of Sidonie’s cock, letting her semen spray your face and chest.\n\n");
			outputText("Tired from your sexual high, you let Sidonie take you on her arms and drop to her side on the couch, playfully licking her seed from your body with her equine tongue, until your " + player.skinFurScales() + " is clean.\n\n");
			outputText("\"<i>Seems like you enjoyed it too, sweetheart</i>\" she remarks, seeing the ");
			if (player.hasCock()) outputText("seed");
			else outputText("girlcum");
			outputText(" leaking from your ");
			if (player.hasCock()) outputText("[cock]");
			else outputText("[vagina]");
			outputText(". \"<i>Hope that I wasn’t too rough with you, hon, but you mouth was simply delicious. I think that I got a bit carried away...</i>\"\n\n");
			outputText("A bit rough yes, but you enjoyed it nonetheless, you assure her. Sidonie simply smiles and holds you, your bodies mixing in a post-coital cuddle. Both of you enjoy each other company for a while, until, unfortunately, you have to continue with you daily task, so you disentangle from the equine’s embrace, and, after giving her a departing kiss, you return to your ");
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("cabin");
			else outputText("tent");
			outputText(".\n\n");
			player.orgasm();
			player.slimeFeed();
			doNext(camp.returnToCampUseOneHour);
		}
		public function SidonieSex69():void {
			clearOutput();
			outputText("Aware of the heat on your own loins, but not wanting to leave Sidonie’s delicious cock unattended, you suggest her that you can enjoy more your intimate time if your pleased each other.\n\n");
			outputText("\"<i>So, you want some mutual mouth-on-cock action?</i>\" she answers with a light-hearted laugh. \"<i>Good enough for me. Let’s see how much the ");
			if (player.tallness < 85) outputText("little ");
			outputText("[race] can produce!</i>\"\n\n");
			outputText("With an embarrassed smile, you ");
			if (player.cumQ() > 1500) outputText("assure her that she’ll get surprised");
			else if (player.cumQ() > 200) outputText("tell her while not a cum cascade, you produce quite enough");
			else outputText("timidly answer that you’re not exactly a fountain, but you won’t disappoint her");
			outputText(".\n\n\"<i>Then, my little [race]</i>\" the equine girl answers, taking you to her bedroom. \"<i>What are we waiting for?</i>\" You notice by the way that her horsecock stands proudly erect now, that she’s as eager as you to have her cock buried on your mouth.\n\n");
			outputText("As you enter the place, the sweet scent of sandalwood hits your nose, and you quickly find the source, as you see how her bedroom is decorated by finely crafted wooden pieces. Soft furs are placed on the walls and floor, the center of the room occupied by a huge bed in with a cushy mattress over which you’re gently placed.\n\n");
			outputText("Lying nude, you extend your legs and arms on the comfy bed, enjoying the soft scent floating over them. In front of you, the sight of the naked equine is mesmerizingly beautiful, the sun rays peeking from a small window near the ceiling, bathing the equine’s caramel fur in a golden light.\n\n");
			outputText("She lets you ogle on her body, putting a bit of display for you, making her  blonde hair flow like locks of gold over her head and shoulder, and kneading her pillowy breasts, tantalizing you with the sight the soft-furred orbs. As a result, your [cock] aches painfully, demanding attention.\n\n");
			outputText("Letting out a smirk, Sidonie takes that as her cue and hops to the bed, placing herself over you. ");
			if (player.tallness < 96) outputText("Given how big she is compared to you, you can’t help but feel a little intimidated.");
			else outputText("Being as big as you, you have no trouble accommodating her atop you.");
			outputText(" Soon, equine lips descent upon your manhood, coating it in slobbery licks and teasing slurps, that tenderly lick every sensitive spot, from tip to base.\n\n");
			outputText("As you’re enjoying the horse-morph ministrations, a large hardness poking your face makes you realize that the well hung girl needs some attention too. You engulf her huge erection on your ");
			if (player.hasMuzzle()) outputText("muzzle");
			else if (player.hasBeak()) outputText("beak");
			else outputText("mouth");
			outputText(" having a bit of trouble getting her wide flare in, but once it has past your entrance, most of her meat slides down your mouth, aided a lot by the salty horse pre that she’s leaking.\n\n");
			outputText("While you do your best to suck and please her cock, she does the same with yours, teasingly playing with your cumslit");
			if (player.balls > 0) outputText(" and kneading your balls with one of her free hands");
			outputText(". From a sudden, she soaks one of her digits in saliva, and slips it on your asshole, naughtily fingering your [analcapacity] hole. You moan in delight, feeling her large fingers prodding your vulnerable anus and playing with your insides.\n\n");
			outputText("Her meat forces its way through your mouth, and you can see (and feel) it going down your throat. Resting above your forehead, her heavy nuts churning, on top of the increasing pace of her thrusts, alert you that she’s close to coming. You have little time to prepare, though, as her finger finds its way to your prostate, sending you over the edge, and making you blast your ");
			if (player.cumQ() > 1500) outputText("copious ");
			outputText("load inside Sidonie’s mouth, which she drinks down ");
			if (player.cumQ() > 1500) outputText("with a bit of difficulty");
			else outputText("without issue");
			outputText(".\n\nA bit dazed by your orgasmic high, you’re taken by surprise by the horse-girl sudden thrust, that pushes her massive penis inside you. Having reached her own limit, Sidonie erupts inside your throat, the floodgates to her sexual peak releasing a torrent of fertile equine cum into your stomach. The force of her orgasm pushes her horsecock further into your mouth, forcing you to gulp down every drop of her thick seed in the process.\n\n");
			outputText("The constant flow of her semen into your mouth soon starts inflating your belly, leaving you with a nice, cum-filled paunch when her flow finally subsides. Letting her cock out of your mouth with a wet ‘pop’ you lie on the bed, but soon are grabbed by the strong equine arms, and placed to her side on the bed.  There, after several cum-laced kisses, you enjoy some post-coital cuddle, until you’ve recovered enough of your vigorous lovemaking to continue on your daily tasks.\n\n");
			outputText("With that, you walk away from the Sidonie’s tent gleefully rubbing your horsecum-filled belly.\n\n");
			player.orgasm();
			player.slimeFeed();
			doNext(camp.returnToCampUseOneHour);
		}
		public function SidonieSexAnal():void {
			clearOutput();
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			outputText("WIP\n\n");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		public function SidonieSexVaginal():void {
			clearOutput();
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			outputText("WIP\n\n");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
	}
}