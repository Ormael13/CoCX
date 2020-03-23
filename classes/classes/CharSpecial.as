package classes 
{
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;

/**
	 * ...
	 * @author ...
	 */
	public class CharSpecial extends BaseContent
	{
		
		public function CharSpecial() {}
		
		// 2d array name | function | skip creation | description
		public const customs:Array = [
			// 
			[ "Without pre-defined history:", null, false, "" ],
			[ "Aria", customAria, false, "It's really no surprise that you were sent through the portal to deal with the demons - you look enough like one as-is.  Your numerous fetish-inducing piercings, magical fox-tails, and bimbo-licious personality were all the motivation the elders needed to keep you from corrupting the village youth." ],
			[ "Betram", customBetram, false, "You're quite the foxy herm, and as different as you were compared to the rest of Ingnam, it's no surprise you were sent through first." ],
			[ "Charaun", customCharaun, false, "As a gifted fox with a juicy, thick knot, a wet cunt, and magical powers, you have no problems with being chosen as champion." ],
			[ "Cody", customCody, false, "Your orange and black tiger stripes make you cut a more imposing visage than normal, and with your great strength, armor, and claymore, you're a natural pick for champion." ],
			[ "Galatea", customGalatea, false, "You've got large breasts prone to lactation.  You aren't sure WHY you got chosen as a champion, but with your considerable strength, you're sure you'll do a good job protecting Ingnam." ],
			[ "Gundam", customGundam, false, "You're fabulously rich, thanks to a rather well-placed bet on who would be the champion.  Hopefully you can buy yourself out of any trouble you might get in." ],
			[ "Hikari", customHikari, false, "As a herm with a super-thick cat-cock, D-cup breasts, and out-of-this-world armor, you're a natural pick for champion." ],
			[ "Katti", customKatti, false, "You have big breasts with big, fuckable nipples on them, and no matter what, your vagina always seems to be there to keep you company." ],
			[ "Lucina", customLucina, false, "You're a blond, fair-skinned lass with a well-made bow and the skills to use it.  You have D-cup breasts and a very moist cunt that's seen a little action.  You're fit and trim, but not too thin, nor too well-muscled.  All in all, you're a good fit for championing your village's cause." ],
			[ "Navorn", customNavorn, false, "There's been something special about you since day one, whether it's your numerous sexual endowments or your supernatural abilities.  You're a natural pick for champion." ],
			[ "Rope", customRope, false, "Despite outward appearances, you're actually something of a neuter, with shark-like teeth, an androgynous face, and a complete lack of genitalia." ],
			[ "Sora", customSora, false, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic..." ],
			
			[ "With a bloodline history:", null, false, "" ],
			[ "Grigori", customGrigori, true, "You are a normal villager if not for that dragon cock and the ability to use an ice dragon's breath. That damn ancestor of yours had to go and fuck some dragoness, didn't he?" ],
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],kitsune start
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],cow/mino start
			[ "Teekna", customTeekna, true, "You were a pretty normal villager, the only oddity other people noticed was your dyed pink hair and yellow eyes. Your ancestor just couldn't keep it in his pants apparently. At least they left some goodies behind for you!" ],
			[ "Veseshe", customVeseshe, true, "The village sure liked to pierce their arrows into you. But with your natural agility and a bit of elven blood flowing in your veins they sure were trying..." ],
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],raiju start
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],oni start
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],orc start
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],chimera start (Layla - based on FoE companion - female herm pc)
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],race 1 start
			//[ "Sora", customSora, true, "As a Kitsune, you always got weird looks, but none could doubt your affinity for magic......." ],race 2 start
			
			[ "With pre-defined history:", null, false, "" ],
			[ "Annetta", customAnnetta, true, "You're a rather well-endowed hermaphrodite that sports a thick, dog-knotted cock, an unused pussy, and a nice, stretchy butt-hole.  You've also got horns and demonic high-heels on your feet.  It makes you wonder why you would ever get chosen to be champion!" ],
			[ "Ceveo", customCeveo, true, "As a wandering mage you had found your way into no small amount of trouble in the search for knowledge." ],
			[ "Charlie", customCharlie, true, "You're strong, smart, fast, and tough.  It also helps that you've got four dongs well beyond what others have lurking in their trousers.  With your wings, bow, weapon, and tough armor, you're a natural for protecting the town." ],
			[ "Chimera", customChimera, true, "Your body is wrecked by your own experiments with otherworldly transformation items, and now you have no more money to buy any more from smugglers... But you would make your body as strong as your will. Or die trying." ],
			[ "Etis", customEtis, true, "Kitsune-dragon hybrid with 3 tentacle cocks, tentacle hair, tentacle (well, draconic) tongue and very strong magic affinity." ],
			[ "Isaac", customIsaac, true, "Born of a disgraced priestess, Isaac was raised alone until she was taken by illness.  He worked a number of odd jobs until he was eventually chosen as champion." ],
			//[ "XXXname", customXXXname, true, "" ],
			[ "Leah", customLeah, true, "No Notes Available." ],
			[ "Lukaz", customLukaz, true, "No Notes Available." ],
			[ "Mara", customMara, true, "You're a bunny-girl with bimbo-tier curves, jiggly and soft, a curvy, wet girl with a bit of a flirty past." ],
			[ "Mihari", customMihari, true, "The portal is not something you fear, not with your imposing armor and inscribed spellblade.  You're much faster and stronger than every champion that came before you, but will it be enough?" ],
			[ "Mirvanna", customMirvanna, true, "You're an equine dragon-herm with a rather well-proportioned body.  Ingnam is certainly going to miss having you whoring yourself out around town.  You don't think they'll miss cleaning up all the messy sex, though." ],
			[ "Nami", customNami, true, "Your exotic appearance caused you some trouble growing up, but you buried your nose in books until it came time to go through the portal." ],
			[ "Nixi", customNixi, true, "As a German-Shepherd morph, the rest of the village never really knew what to do with you... until they sent you through the portal to face whatever's on the other side..." ],
			[ "Prismere", customPrismere, true, "You're more of a scout than a fighter, but you still feel confident you can handle your responsibilities as champion.  After all, what's to worry about when you can outrun everything you encounter?  You have olive skin, deep red hair, and a demonic tail and wings to blend in with the locals." ],
			[ "Rann Rayla", customRannRayla, true, "You're a young, fiery redhead who\'s utterly feminine.  You've got C-cup breasts and long red hair.  Being a champion can\'t be that bad, right?" ],
			[ "Sera", customSera, true, "You're something of a shemale - three rows of C-cup breasts matched with three, plump, juicy cocks.  Some decent sized balls, bat wings, and cat-like ears round out the package." ],
			[ "Siveen", customSiveen, true, "You are a literal angel from beyond, and you take the place of a vilage's champion for your own reasons..." ],
			[ "Tyriana", customTyriana, true, "Your many, posh tits, incredible fertility, and well-used cunt made you more popular than the village bicycle.  With your cat-like ears, paws, and tail, you certainly had a feline appeal.  It's time to see how you fare in the next chapter of your life." ],
			[ "Vahdunbrii", customVahdunbrii, true, "You're something of a powerhouse, and you wager that between your odd mutations, power strong enough to threaten the village order, and talents, you're the natural choice to send through the portal." ],
			[ "Zavos", customZavos, true, "You are a local sorcerer, with a deep affinity for the dark arts.  You were assigned the role of champion as punishment for a crime you never committed." ],
		];
		
		private function customAnnetta():void {
			outputText("You're a rather well-endowed hermaphrodite that sports a thick, dog-knotted cock, an unused pussy, and a nice, stretchy butt-hole.  You've also got horns and demonic high-heels on your feet.  It makes you wonder why you would ever get chosen to be champion!");
			//Specific Character	"Gender: Herm
			//Penis: 13 inch long 3 inch wide penis, dog shaped, 6.5 inch knot
			//Balls: Four 5 inch wide
			//Vagina: Tight, virgin, 0.5 inch clitoris
			player.createVagina();
			player.createCock();
			player.createBreastRow();
			player.clitLength = 0.5;
			player.tallness = 67;
			player.femininity = 90;
			player.balls = 2;
			player.ballSize = 5;
			player.cocks[0].cockLength = 13;
			player.cocks[0].cockThickness = 3;
			player.cocks[0].knotMultiplier = 2.2;
			//Butt: Loose"	"Skin: Purple
			player.ass.analLooseness = 3;
			player.skinTone = "purple";
			//Hair: Back length orange
			player.hairLength = 30;
			player.hairColor = "orange";
			//Face: Elf ears, 4x demonic horns
			player.ears.type = Ears.ELFIN;
			player.horns.count = 4;
			player.horns.type = Horns.DEMON;
			//Body: Plump, no muscle tone, wide thighs, badonkulous ass, demon tail, demonic high heels
			player.thickness = 75;
			player.tone = 0;
			player.hips.type = 17;
			player.butt.type = 17;
			player.tailType = Tail.DEMONIC;
			player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			//Breasts: J-cups with 5 inch fuckable nipples, leaking milk
			player.breastRows[0].breastRating = 28;
			player.nippleLength = 5;
			player.breastRows[0].lactationMultiplier += 20;
			
			//Equipment: Starts with spiked fist
			player.setWeapon(weapons.S_GAUNT);
			//Perks: Fighter and Lotsa Jizz"	Annetta
			if (!player.hasPerk(PerkLib.PastLifeFighter)) player.createPerk(PerkLib.HistoryFighter,0,0,0,0);
			player.createPerk(PerkLib.MessyOrgasms, 1.5, 0, 0, 0);
			player.cumMultiplier = 40;
		}
		
		private function customAria():void {
			outputText("It's really no surprise that you were sent through the portal to deal with the demons - you look enough like one as-is.  Your numerous fetish-inducing piercings, magical fox-tails, and bimbo-licious personality were all the motivation the elders needed to keep you from corrupting the village youth.");
			//2/26/2013 8:18:21	rdolave@gmail.com	Character Creation	"female DD breasts feminity 100 butt size 5 hip size 5 body thickness 10 clit I would like her nipples pierced with Ceraphs piercing
			//(on a side note how much do you think it would cost to add bell nipple,labia and clit piercings as well as an option for belly button piercings would like to see belly button piecings with a few different options as well.  Also would love to have handcuff ear piercings.)"	Would like the bimbo brain and bimbo body perks as well as the nine tail PerkLib.  demonic high heels, pink skin, obscenely long pink hair  would like her to be a kitsune with the nine tails.  pink fur.  starting equipment would like to be the succubus whip and nurse's outfit.  Also would like the xmas perk and all three Vday perks	Aria
			if(!player.hasVagina()) player.createVagina();
			if(player.femininity < 80) player.femininity = 80;
			player.createPerk(PerkLib.BimboBody, 0, 0, 0, 0);
			player.createPerk(PerkLib.BimboBrains, 0, 0, 0, 0);
			player.tailType = Tail.FOX;
			player.tailCount = 9;
			player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);
			player.breastRows[0].breastRating = 5;
			player.femininity = 100;
			player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			player.skin.growFur({color:"pink"});
			player.hairColor = "pink";
			player.hairLength = 50;
			player.hips.type = 5;
			player.butt.type = 5;
			player.thickness = 10;
			flags[kFLAGS.PC_FETISH] = 2;
			player.earsPierced = 1;
			player.earsPShort = "green gem-stone handcuffs";
			player.earsPLong = "Green gem-stone handcuffs";
			player.nipplesPierced = 1;
			player.nipplesPShort = "seamless black nipple-studs";
			player.nipplesPLong = "Seamless black nipple-studs";
			flags[kFLAGS.PC_FETISH] = 2;
			player.vaginas[0].clitPierced = 1;
			player.vaginas[0].clitPShort = "emerald clit-stud";
			player.vaginas[0].clitPLong = "Emerald clit-stud";
			player.vaginas[0].labiaPierced = 2;
			player.vaginas[0].labiaPShort = "ruby labia-rings";
			player.vaginas[0].labiaPLong = "Ruby labia-rings";
			player.createPerk(PerkLib.ElvenBounty,0,15,0,0);
			player.createPerk(PerkLib.PureAndLoving,0,0,0,0);
			player.createPerk(PerkLib.SensualLover,0,0,0,0);
			player.createPerk(PerkLib.OneTrackMind,0,0,0,0);
			player.setWeapon(weapons.SUCWHIP);
			player.setArmor(armors.NURSECL);
		}
		
		private function customBetram():void {
			//Character Creation	
			//herm, canine cock - 8", virgin, tight, wet	
			//fox ears, tails, A cup breasts with normal nipples	Betram															
			player.ears.type = Ears.FOX;
			player.tailType = Tail.FOX;
			player.tailCount = 1;
			if(player.biggestTitSize() > 1) player.breastRows[0].breastRating = 1;
			if(!player.hasCock()) {
				player.createCock();
				player.cocks[0].cockType = CockTypesEnum.DOG;
				player.cocks[0].cockLength = 8;
				player.cocks[0].cockThickness = 1;
				player.cocks[0].knotMultiplier = 1.4;
			}
			if(!player.hasVagina()) {
				player.createVagina();
				player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
				player.clitLength = 0.25;
			}
			outputText("You're quite the foxy herm, and as different as you were compared to the rest of Ingnam, it's no surprise you were sent through first.");
		}
		
		private function customCeveo():void {
			//Male. 2 cock. 5.5 average thickness and 12 in with excessive thickness both pierced with silver rings. Balls, large, about the size of a billiard ball, four of them. All humanish, more details on the character.
			player.createCock();
			player.createCock();
			player.balls = 4;
			player.ballSize = 3;
			player.cocks[0].cockThickness = 5.5;
			player.cocks[1].cockThickness = 5.5;
			player.cocks[0].cockLength = 12;
			player.cocks[1].cockLength = 12;
			player.cocks[0].pierced = 2;
			player.cocks[1].pierced = 2;
			player.cocks[0].pShortDesc = "silver cock-ring";
			player.cocks[1].pShortDesc = "silver cock-ring";
			player.cocks[0].pLongDesc = "Silver cock-ring";
			player.cocks[1].pLongDesc = "Silver cock-ring";
			//"Androgynous face, large brown eyes, long black hair down to about ass level, full lips, pirced with one silver ring ass itself is round and thick, chest is flat, only two nipples, about nickle sized pierced with silver studs, skin of a pale ghostly transparent complexion, rest of the body is not notably muscular or chubby in any definite way, feet seem to taper off into full transparency. Full body housed in the lewd Inquisitor Armor, wielding a Wizard Staff. Starting at level 5 with tank, regeneration, healing, smarts, channeling, mage and incorperability perks, a full knowledge of
			player.tallness = 72;
			player.femininity = 50;
			player.hairLength = 35;
			player.hairColor = "black";
			player.lipPierced = 2;
			player.lipPShort = "silver lip-ring";
			player.lipPLong = "Silver lip-ring";
			player.butt.type = 8;
			player.hips.type = 8;
			player.createBreastRow();
			player.nipplesPierced = 1;
			player.nipplesPShort = "silver studs";
			player.nipplesPLong = "Silver studs";
				
			player.skinTone = "ghostly pale";
			player.createPerk(PerkLib.Incorporeality, 0, 0, 0, 0);
			player.setArmor(armors.I_CORST);
			player.level = 5;
			player.setWeapon(weapons.W_STAFF);
	
			player.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			player.createPerk(PerkLib.Smart, 1, 0, 0, 0);
			player.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			player.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeHealer)) player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
			player.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.KnowsArouse,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsHeal,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsMight,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsCharge,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
			//magic, 50 Int, 50 tough, Speed 15, Str 10, 30 corruption, 30 libido, 10 sensitivity.
			player.inte = 50;
			player.tou = 50;
			player.spe = 15;
			player.str = 10;
			player.cor = 30;
			player.lib = 30;
			player.sens = 10;
			outputText("As a wandering mage you had found your way into no small amount of trouble in the search for knowledge.  A strange tome here, a ritual there, most people found your pale form unsettling. They would be further troubled if they could see your feet!  Lets not even begin on the blood magic.  Yes, your interest in examining every aspect of magic has run you down a strange path, so when you wandered into Ingram and began to hear of the exile of the Champion, and the superstitions that surrounded it you were intrigued, as every little rumor and ritual often had a grain of truth.  You snuck into the cave prior to the ritual, where the old man supposedly led every Champion, and there you found a strange portal that emanated a certain degree of spacial transparency -  more than the portal's own.  Within it must have been a whole new world!  Throwing caution to the wind, your curiosities engulfing you, you dove in with nary a thought for the consequences.");
		}
		
		private function customCharaun():void {
			outputText("As a gifted fox with a juicy, thick knot, a wet cunt, and magical powers, you have no problems with being chosen as champion.");
			//Herm, Fox Cock: (27"l x 1.4"w, knot multiplier 3.6), No Balls, Cum Multiplier: 7,500, Vaginal Wetness: 5, Clit length: 0.5, Virgin, Fertility: 15	9-tailed "enlightened" kitsune( a pure-blooded kitsune with the "Enlightened Nine-tails" perk and magic specials) 
			if(!player.hasCock()) player.createCock();
			if(!player.hasVagina()) player.createVagina();
			player.cocks[0].cockLength = 27;
			player.cocks[0].cockThickness = 1.4;
			player.cocks[0].knotMultiplier = 3.6;
			player.cocks[0].cockType = CockTypesEnum.DOG;
			player.balls = 0;
			player.ballSize = 2;
			player.cumMultiplier = 7500;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLAVERING;
			player.clitLength = 0.5;
			player.fertility = 15;
			player.tailType = Tail.FOX;
			player.tailCount = 9;
			player.createPerk(PerkLib.EnlightenedNinetails,0,0,0,0);
			//if possible with fur, Hair color: "midnight black", Skin/Fur color: "ashen grayish-blue",  Height: 65", Tone: 100, Thickness: 0, Hip rating: 6, Butt rating: 3,Feminimity: 50,  ( 4 rows of breasts (Descending from the top ones: D,C,B,A), nipple length: 0.1", Fuckable, 1 nipple per breast, Tongue type: demon
			player.hairColor = "midnight black";
			player.skin.growFur({});
			player.skin.base.color = "ashen grayish-blue";
			player.tallness = 65;
			player.tone = 100;
			player.thickness = 0;
			player.hips.type = 6;
			player.butt.type = 3;
			player.femininity = 50;
			player.createBreastRow();
			player.createBreastRow();
			player.createBreastRow();
			player.breastRows[0].breastRating = 4;
			player.breastRows[0].fuckable = true;
			player.breastRows[1].breastRating = 3;
			player.breastRows[1].fuckable = true;
			player.breastRows[2].breastRating = 2;
			player.breastRows[2].fuckable = true;
			player.breastRows[3].breastRating = 1;
			player.breastRows[3].fuckable = true;
			player.tongue.type = Tongue.DEMONIC;
			player.nippleLength = 0.1;
			//Starting with an Inscribed Spellblade and Bondage Straps.	Charaun
			player.setArmor(armors.BONSTRP);
			player.setWeapon(weapons.S_BLADE);
		}
		
		private function customCharlie():void {
			outputText("You're strong, smart, fast, and tough.  It also helps that you've got four dongs well beyond what others have lurking in their trousers.  With your wings, bow, weapon, and tough armor, you're a natural for protecting the town.");
			player.tou +=2;
			player.str += 3;
			player.fertility = 5;
			player.hairLength= 26;
			player.hairColor = "blond";
			player.skinTone = "light";
			player.nippleLength = 0.2;
			player.createBreastRow();
			player.breastRows[0].breastRating = 0;
			player.balls = 2;
			player.ballSize = 3;
			player.tallness = 113;
			player.tone = 50;
			player.thickness = 50;
			player.femininity = 50;
			player.hips.type = 5;
			player.butt.type = 5;
			player.teaseLevel = 1;
			//Large feathered wings (Any chance in heck I could get 'angel' as the race descriptor? Just asking. I'm fine if the answer is 'no')
			player.wings.type = Wings.FEATHERED_LARGE;
			player.wings.desc = "large, feathered";
			
			//While we're on the subject, would glowing eyes be possible? I'll take normal eyes if not.
			//Beautiful Sword
			player.setWeapon(weapons.B_SWORD);
			player.setArmor(armors.SSARMOR);
			//Beautiful Armor (Or just Spider Silk Armor)
			//Pure Pearl
			//Tallness 84 (8 feet 0 inches)
			player.tallness = 84;
			//Femininity 10
			player.femininity = 10;
			//Thickness 50
			player.thickness = 50;
			//Tone 90
			player.tone = 90;
			//Int 50 (if possible)
			player.inte = 50;
			//Str/Tou/Spd 25 (if possible)
			player.str = 25;
			player.tou = 25;
			player.spe = 25;
			//Bow
			//player.createKeyItem("Bow",0,0,0,0);
			player.setWeaponRange(weaponsrange.BOWOLD_);
			//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
			player.createStatusEffect(StatusEffects.Kelt,100,0,0,0);
			//Is it possible to get extra starting perks added? If so, I'd like History: Religious added to whatever is selected on creation. If not, please ignore this line.
			//Freckled skinAdj
			player.skinAdj = "freckled";
			//10 Perk Points (if possible, feel free to make it less if you feel it necessary)
			player.perkPoints = 10;
			//Would it be possible to code a cock type that morphs into different cock types? (i.e. it loads a different cock type description each sex scene) If so, I'd like him to have a pair of them, one 24 inches long and 3 inches wide and the second 12-inches long and 2 inches wide. If not, I'll take a dragon and horse cock at 24/3 each as well as a dog and cat cock at 12/2 each.
			player.createCock();
			player.createCock();
			player.createCock();
			player.createCock();
			player.cocks[0].cockLength = 24;
			player.cocks[0].cockThickness = 3;
			player.cocks[0].cockType = CockTypesEnum.HORSE;
			player.cocks[1].cockLength = 24;
			player.cocks[1].cockThickness = 3;
			player.cocks[1].cockType = CockTypesEnum.DRAGON;
			player.cocks[2].cockLength = 12;
			player.cocks[2].cockThickness = 2;
			player.cocks[2].cockType = CockTypesEnum.DOG;
			player.cocks[3].cockLength = 12;
			player.cocks[3].cockThickness = 2;
			player.cocks[3].cockType = CockTypesEnum.CAT;
	
			//A pair of 8-inch balls
			player.balls = 2;
			player.ballSize = 8;
			//A virility boost would be nice too if possible.
			player.cumMultiplier = 50;
		}
		
		private function customCody():void {
			outputText("Your orange and black tiger stripes make you cut a more imposing visage than normal, and with your great strength, armor, and claymore, you're a natural pick for champion.");
			//well to start off the name would be Cody
			//-Cat with (black and orange tiger fur if possible) if not just Orange fur
			player.hairColor = "black and orange";
			player.skin.growFur({});
			//-Chainmail armor
			player.setArmor(armors.FULLCHN);
			//-Large Claymore (i understand 40 Strength is need so if he could start with that would be great if not hit the gyms)"
			player.str = 40;
			player.setWeapon(weapons.CLAYMOR);
		}
		
		private function customGalatea():void {
			//"(Dangit Fenoxo!  Stop adding sexy must-have things to the game!  If it's not too late to update it I've added in that sexy new armor.  Thanks!)		
			//Other:
			if(!player.hasVagina()) {
				player.createVagina();
				if(player.clitLength == 0) player.clitLength = 0.25;
			}
			//Hair length: Very long
			player.hairLength = 22;
			//Breast size: HH
			player.breastRows[0].breastRating = 21;
			//Femininity/Beauty: Very high
			player.femininity = 90;
			// Height: 5'4
			player.tallness = 64;
	
			//Perks: Feeder, Strong Back, Strong Back 2
			player.createStatusEffect(StatusEffects.Feeder,0,0,0,0);
			player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
	
			player.createPerk(PerkLib.StrongBack, 0, 0, 0, 0);
			player.createPerk(PerkLib.StrongBack2, 0, 0, 0, 0);
			player.createPerk(PerkLib.StrongBack3, 0, 0, 0, 0);
	
			//Equipment: 
			//Weapon: Warhammer
			player.setWeapon(weapons.WARHAMR);
			//Armor: Lusty shit
			player.setArmor(armors.LMARMOR);
			//player.createPerk(PerkLib.SluttySeduction, 10 + flags[kFLAGS.BIKINI_ARMOR_BONUS], 0, 0, 0);
	
			//Stats: (if possible)
			//Strength: 90
			player.str = 90;
			//Fertility: 100
			player.fertility = 100;
			player.cor = 25;
			//Inventory: Lactaid, GroPlus, BimboLq
			player.itemSlot1.setItemAndQty(consumables.LACTAID,5);
			player.itemSlot2.setItemAndQty(consumables.GROPLUS,5);
			player.itemSlot3.setItemAndQty(consumables.BIMBOLQ,1);
			player.itemSlot4.setItemAndQty(armors.BIMBOSK,1);
			player.itemSlot6.unlocked = true;
			player.itemSlot7.unlocked = true;
			player.itemSlot8.unlocked = true;
			outputText("You've got large breasts prone to lactation.  You aren't sure WHY you got chosen as a champion, but with your considerable strength, you're sure you'll do a good job protecting Ingnam.");
		}
		
		private function customGundam():void {
			outputText("You're fabulously rich, thanks to a rather well-placed bet on who would be the champion.  Hopefully you can buy yourself out of any trouble you might get in.");
			player.gems = 1500 + rand(1000);
			//for my custom character profile i want the name to be gundam all i want is to start out with around 1000-2500 gems like as a gift from the elder or something to help me out.
		}
		
		private function customHikari():void {
			//Character Creation	If possible I would like a herm with a cat cock that is 10 inches by 4 inches. Anything else is up to you.	I would like a herm catmorph with two large d breasts and shoulder length hair. Also if possible I would like to start with some gel armor. Everything else is fair game.	Hikari
			outputText("As a herm with a super-thick cat-cock, D-cup breasts, and out-of-this-world armor, you're a natural pick for champion.");
			if(!player.hasCock()) player.createCock();
			player.cocks[0].cockType = CockTypesEnum.CAT;
			player.cocks[0].cockLength = 10;
			player.cocks[0].cockThickness = 4;
			if(!player.hasVagina()) player.createVagina();
			player.breastRows[0].breastRating = 4;
			player.hairLength = 10;
			player.setArmor(armors.GELARMR);
		}
		
		private function customIsaac():void {
			outputText("Born of a disgraced priestess, Isaac was raised alone until she was taken by illness.  He worked a number of odd jobs until he was eventually chosen as champion.");
			//- gift: fast
			player.spe += 5;
			player.tone += 10;
			player.createPerk(PerkLib.Fast, 1, 0, 0, 0);
			//- history: religion 
			if (!player.hasPerk(PerkLib.PastLifeReligious)) player.createPerk(PerkLib.HistoryReligious,0,0,0,0);
			//(and if possible)
			//- history: fighter
			if (!player.hasPerk(PerkLib.PastLifeFighter)) player.createPerk(PerkLib.HistoryFighter,0,0,0,0);
			//- history: smith
			if (!player.hasPerk(PerkLib.PastLifeSmith)) player.createPerk(PerkLib.HistorySmith,0,0,0,0);
			//in my ar, Issac was born to a disgraced priestess (she was raped by marauders) and raised by her alone until she died from an illness and was pretty much left to fend for and earn a living for himself (hence the fighter and smith background's too) until, years later he was chosen as 'champion'~
			//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			player.balls = 2;
			//- a pair of apple sized balls each measuring three inches across
			player.ballSize = 3;
			//anatomy - twin dicks
			//the first, a vulpine dick (12 in. long, 2.8 in. thick with a knot roughly 4.5 in. at full size) with a Fertite jacob's ladder piercing
			//and the second, a barbed feline dick (10 in. long and 2.5 in thick) with an Emerald jacob's ladder
			//heh, ribbed for their pleasure ;d lol
			player.createCock();
			player.createCock();
			player.cocks[0].cockLength = 12;
			player.cocks[0].cockThickness = 2.8;
			player.cocks[0].cockType = CockTypesEnum.DOG;
			player.cocks[0].knotMultiplier = 1.8;
			player.cocks[1].cockLength = 10;
			player.cocks[1].cockThickness = 2.5;
			player.cocks[1].cockType = CockTypesEnum.TENTACLE;
			player.cocks[0].pierced = 3;
			player.cocks[0].pShortDesc = "fertite cock-jacob's ladder";
			player.cocks[0].pLongDesc = "Fertite cock-jacob's ladder";
			player.createPerk(PerkLib.PiercedFertite,5,0,0,0);
			//- and one tight asshole
			player.ass.analLooseness = 0;
			//- kitsune
			//- moderately long white hair (9 inches)
			player.hairLength = 9;
			player.hairColor = "silver-white";
			//- human face
			//- fox ears 
			player.ears.type = Ears.FOX;
			//- olive complexion
			player.skinTone = "olive";
			//- demon tongue (oral fetish ;d)
			player.tongue.type = Tongue.DEMONIC;
			//- 5 foot 9 inch tall
			player.tallness = 69;
			//- average build
			player.thickness = 50;
			//- body thickness of  around 50
			player.tone = 70;
			//- 'tone of about 70  
			//- two flat breasts each supporting one 0.2-inch nipple
			player.nippleLength = 0.2;
			player.createBreastRow();
			//- three fox tails
			player.tailType = Tail.FOX;
			player.tailCount = 3;
			//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			//equipment;
			//- katana (don't suppose you could rename the katana 'Zon'ith' could you? ~.^)
			//Items: Katana, Leather Armor
			player.setWeapon(weapons.KATANA);
			//- robes
			player.setArmor(armors.M_ROBES);
		}
		
		private function customKatti():void {
			outputText("You have big breasts with big, fuckable nipples on them, and no matter what, your vagina always seems to be there to keep you company.");
			//Gender: Female	
			if(!player.hasVagina()) {
				player.createVagina();
			}
			//"Ears: Bunny
			player.ears.type = Ears.BUNNY;
			//Tail: Bunny
			player.tailType = Tail.RABBIT;
			//Face: Human
			//Breasts: H-cup with 4.5 inch fuckable nipples"
			player.breastRows[0].breastRating = 19;
			player.nippleLength = 4.5;
			player.breastRows[0].fuckable = true;
		}
		
		private function customLeah():void {
			player.setArmor(armors.LEATHRA);
	//		if(player.findPerk(PerkLib.WizardsEndurance) < 0) player.createPerk(PerkLib.WizardsEndurance,30,0,0,0);
			player.setWeapon(weapons.W_STAFF);
			player.itemSlot1.setItemAndQty(consumables.B__BOOK, 1);
			player.itemSlot2.setItemAndQty(consumables.W__BOOK, 2);
	
			player.createBreastRow();
			player.createVagina();
			player.breastRows[0].breastRating = 4;
			player.clitLength = .5;
			player.fertility = 10;
			player.hips.type = 8;
			player.butt.type = 8;
			player.str = 15;
			player.tou = 15;
			player.spe = 18;
			player.inte = 17;
			player.wis = 17;
			player.sens = 15;
			player.lib = 15;
			player.cor = 0;
			player.HP = EngineCore.maxHP();
			player.hairLength=13;
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 85;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 30;
			player.thickness = 50;
			player.skinTone = "olive";
			player.hairColor = "black";
			player.balls = 0;
			player.cumMultiplier = 1;
			player.ballSize = 0;
			player.hoursSinceCum = 0;
			player.clitLength = 0;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tallness = 67;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			player.tone = 30;
			player.thickness = 65;
		}
		
		private function customLucina():void {
			//428347355782040	Character Creation	Female,wetness=wet, Looseness=normal,not a virgin, Fertility high i guess i dont really care can be up to you.	for her face normal human, ears i want Elvin, no tails, just normal skin, body thickness i want to be slender, body tone kinda athletic but not too much, hair i want really long i think like a 30 on the codex number i think and her hair color light blonde, i want her to have normal D size breast with you can choose how you want them really though i dont think i really care, nipple size i dont care, her skin color a fair light light color but not too pale, for her starting equipment i want im not sure what i want her to wear but basically i want a Elvin archer with a bow. so maybe you can do something about the clothing. i just want a Elvin character in the game since theres goblins plus another archer besides kelt a female one add to that.	Lucina
			outputText("You're a blond, fair-skinned lass with a well-made bow and the skills to use it.  You have D-cup breasts and a very moist cunt that's seen a little action.  You're fit and trim, but not too thin, nor too well-muscled.  All in all, you're a good fit for championing your village's cause.");
			if(!player.hasVagina()) player.createVagina();
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;
			player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
			player.vaginas[0].virgin = false;
			if(player.femininity < 80) player.femininity = 80;
			player.fertility = 40;
			player.ears.type = Ears.ELFIN;
			player.thickness = 25;
			player.tone = 60;
			player.hairLength = 30;
			player.hairColor = "light blonde";
			player.breastRows[0].breastRating = 4;
			player.skinTone = "light";
			//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
			player.createStatusEffect(StatusEffects.Kelt,100,0,0,0);
			//player.createKeyItem("Bow",0,0,0,0);
			player.setWeaponRange(weaponsrange.BOWOLD_);
		}
		
		private function customLukaz():void {
			//Specific Character	
			//Male. 11.5 inch dog dick, 4 balls, 2 inches in diameter.	
			player.createCock();
			player.cocks[0].cockLength = 11.5;
			player.cocks[0].cockThickness = 2;
			player.cocks[0].cockType = CockTypesEnum.DOG;
			player.cocks[0].knotMultiplier = 1.5;
			player.createBreastRow();
			player.breastRows[0].breastRating = 0;
			player.tallness = 71;
			player.hips.type = 4;
			player.butt.type = 4;
			player.femininity = 30;
			player.createCock();
			player.balls = 4;
			player.cumMultiplier = 8;
			player.ballSize = 2;
			player.str = 18;
			player.tou = 17;
			player.spe = 15;
			player.inte = 15;
			player.wis = 15;
			player.sens = 15;
			player.lib = 15;
			player.cor = 0;
			player.HP = EngineCore.maxHP();
			player.hairLength = 1;
			player.skin.setAllProps({base:{color:"light"}});
			player.hairColor = "brown";
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 50;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.thickness = 50;
			player.hoursSinceCum = 0;
			player.clitLength = 0;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			//"dog face, dog ears, draconic tail, blue fur.
			player.faceType = Face.DOG;
			player.ears.type = Ears.DOG;
			player.tailType = Tail.DRACONIC;
			player.hairColor = "blue";
			player.skin.growFur({});
			player.tone = 88;
			player.tongue.type = Tongue.DRACONIC;
			//gel plate armor, warhammer, 88 body tone, 1 breast row, flat manly breasts, 0.2 inch nipples, 1 on each breast, draconic tongue, short hair-blue, light skin."	Lukaz
			if (!player.hasPerk(PerkLib.PastLifeFighter)) player.createPerk(PerkLib.HistoryFighter,0,0,0,0);
			player.createPerk(PerkLib.MessyOrgasms, 1.5, 0, 0, 0);
		}
		
		private function customMara():void {
			//#226096893686530
			//For the custom PC Profile can you make a Bimbo Bunny girl (no bunny feet) (named Mara) dont really care about clothes i can get what i want pretty quickly and I change from time to time.
			outputText("You're a bunny-girl with bimbo-tier curves, jiggly and soft, a curvy, wet girl with a bit of a flirty past.");
			player.spe+=3;
			player.inte+=2;
			player.clitLength = .5;
			player.tone = 30;
			player.fertility = 10;
			player.hairLength= 15;
			player.createBreastRow();
			player.createVagina();
			player.tallness = 67;
			player.breastRows[0].breastRating = 7;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;
			player.vaginas[0].virgin = false;
			player.tone = 20;
			player.hips.type = 12;
			player.butt.type = 12;
			player.femininity = 100;
			player.thickness = 33;
			if (!player.hasPerk(PerkLib.PastLifeSlut)) player.createPerk(PerkLib.HistorySlut, 0, 0, 0, 0);
			player.createPerk(PerkLib.BimboBody, 0, 0, 0, 0);
			player.createPerk(PerkLib.BimboBrains, 0, 0, 0, 0);
			player.createPerk(PerkLib.BigTits, 1.5, 0, 0, 0);
			player.ears.type = Ears.BUNNY;
			player.tailType = Tail.RABBIT;
			player.skinTone = "tan";
			player.hairColor = "platinum blonde";
			player.teaseLevel = 3;
		}
		
		private function customMihari():void {
			//[Values will be listed as if taken from Minerva]
			//I'm kinda going under the assumption you are letting us go hog wild if not, take what's allowed and do what you wish out of what's below
			outputText("The portal is not something you fear, not with your imposing armor and inscribed spellblade.  You're much faster and stronger than every champion that came before you, but will it be enough?");
			//Core Stats:
			player.str = 40;
			player.tou = 20;
			player.spe = 100;
			player.inte = 80;
			player.lib = 25;
			player.sens = 15;
			
			//Body Values:
			//breastRows
			player.createBreastRow();
			//-breastRating: 5
			//-breasts: 2
			//-nipplesPerBreast: 1
			player.breastRows[0].breastRating = 5;
			player.butt.type = 2;
			player.createVagina();
			player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLAVERING;
			player.vaginas[0].virgin = true;
			player.clitLength = 0.2;
			player.ears.type = Ears.CAT;
			player.faceType = Face.CAT;
			player.femininity = 100;
			player.fertility = 100;
			player.hairColor = "blonde";
			player.hairLength = 24;
			player.hips.type = 6;
			player.lowerBody = LowerBody.CAT;
			player.nippleLength = 0.5;
			//perks:
			player.createPerk(PerkLib.Agility, 0, 0, 0, 0);
			player.createPerk(PerkLib.Evade, 0, 0, 0, 0);
			player.createPerk(PerkLib.Runner, 0, 0, 0, 0);
			player.createPerk(PerkLib.Fast, 1, 0, 0, 0);
			player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			player.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			player.skin.growFur({color:"ashen"});
			player.tailType = Tail.CAT;
			player.tallness = 55;
			player.teaseLevel = 4;
			player.thickness = 10;
			player.tone = 75;
			player.tongue.type = Tongue.HUMAN;
			
			//Posted everything above sorry if it wasn't supposed to go there.
			//starting equipment: black leather armor surrounded by voluminous robes
			//starting weapon: Spellblade if not gamebreaking otherwise spear is fine.
			player.setArmor(armors.LTHRROB);
			player.setWeapon(weapons.S_BLADE);
		}
		
		private function customMirvanna():void {
			//Any equine or dragonny attributes accompanying it a big plus! As I'm a dragon-unicorn furry (Qilin~). Bonus points if you add a horns type for unicorn horns.
			outputText("You're an equine dragon-herm with a rather well-proportioned body.  Ingnam is certainly going to miss having you whoring yourself out around town.  You don't think they'll miss cleaning up all the messy sex, though.");
			player.spe+=3;
			player.inte+=2;
			player.str += 3;
			player.clitLength = .5;
			player.fertility = 20;
			player.hairLength= 15;
			player.createBreastRow();
			player.createVagina();
			player.createCock();
			player.tallness = 73;
			player.breastRows[0].breastRating = 5;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;
			player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
			player.vaginas[0].virgin = false;
			player.tone = 20;
			player.hips.type = 8;
			player.butt.type = 8;
			player.femininity = 75;
			player.thickness = 33;
			player.hairColor = "platinum blonde";
			player.teaseLevel = 1;
			//Mirvanna;
			//Gender = Herm
			//Ears = Horse
			player.ears.type = Ears.HORSE;
			//Horns = Dragon
			player.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
			player.horns.count = 12;
			//Face = Horse
			player.faceType = Face.HORSE;
			//Skin type = Black Fur
			player.skinTone = "brown";
			player.hairColor = "black";
			player.skin.growFur({});
			//Legs/Feet = Digigrade hooved 
			player.lowerBody = LowerBody.HOOFED;
			//Wing type = Dragon
			player.wings.type = Wings.DRACONIC_LARGE;
			player.wings.desc = "large, draconic";
			//Tail type = Dragon
			player.tailType = Tail.DRACONIC;
			//Cock type = Equine
			player.cocks[0].cockType = CockTypesEnum.HORSE;
			player.cocks[0].cockLength = 14;
			player.cocks[0].cockThickness = 2.5;
			//Vulva Type = Equine
			
			//Beautiful Sword & Wizard Robe
			player.setWeapon(weapons.B_SWORD);
			player.setArmor(armors.W_ROBES);
			//Herm, lots of jizz.
			player.femininity -= 2;
			player.cumMultiplier = 11;
			player.createPerk(PerkLib.MessyOrgasms, 1.5, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeWhore)) player.createPerk(PerkLib.HistoryWhore,0,0,0,0);
		}
		
		private function customNami():void {
			//Female with the sand-trap black pussy
			//Non-Virgin
			//Fertility- Normal Starting Value
			//Wetness- Above Average
			//Looseness- Normal Starting Value
			//Clit-size- Normal Value"
			player.createVagina();
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;
			player.clitLength = 0.25;
			player.vaginas[0].type = 5;
			player.vaginas[0].virgin = false;
			player.ass.analLooseness = 1;
			//Face- Canine
			player.faceType = Face.DOG;
			//Ears- Canine
			player.ears.type = Ears.DOG;
			//Tail- Canine
			player.tailType = Tail.DOG;
			//Lower body- Canine
			player.lowerBody = LowerBody.DOG;
			//White Fur (if possible)
			player.hairColor = "white";
			player.skin.growFur({});
			//Body Thickness/breastsize/- As if I had selected the ""Average"" body type from the start.
			player.createBreastRow();
			player.breastRows[0].breastRating = 3;
			//Muscle Tone- A bit above average enough to trigger a mention of it in the desc.
			player.tone = 55;
			//Nipples-  As above on size but the black sand trap nipples.
			player.createStatusEffect(StatusEffects.BlackNipples,0,0,0,0);
			//Hair Length- Long
			player.hairLength = 16;
			//Hair Color- Black
			//Skin Color- Light
			player.skinTone = "light";
			//Starting Equipment: Wizard's Robe, Wizards Staff, and one White and one Black book in inventory.
			//equipArmor("inquisitor's corset",false);
			player.setArmor(armors.W_ROBES);
	
			player.setWeapon(weapons.W_STAFF);
			//Gift Perk- Smarts
			player.createPerk(PerkLib.Smart,1,0,0,0);
			//History- Schooling
			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar,0,0,0,0);
			player.itemSlot1.setItemAndQty(consumables.W__BOOK,1);
			player.itemSlot2.setItemAndQty(consumables.B__BOOK,1);
			player.tallness = 64;
			player.femininity = 75;
			player.butt.type = 7;
			player.hips.type = 7;
			player.inte = 40;
			player.str = 20;
			player.spe = 25;
			player.tou = 15;
			
			clearOutput();
			outputText("Your exotic appearance caused you some trouble growing up, but you buried your nose in books until it came time to go through the portal.");
		}
		
		private function customNavorn():void {
			outputText("There's been something special about you since day one, whether it's your numerous sexual endowments or your supernatural abilities.  You're a natural pick for champion.");
			//Character Creation	"Herm same number and types of cocks from email sent earlier. 
			//Special abilities: Fire breath, fox fire?
			player.createPerk(PerkLib.DragonFireBreath,0,0,0,0);
			player.createPerk(PerkLib.DragonIceBreath,0,0,0,0);
			//equipment: Large claymore, and platemail
			//-Chainmail armor
			player.setArmor(armors.FULLPLT);
			//-Large Claymore (i understand 40 Strength is need so if he could start with that would be great if not hit the gyms)"
			player.setWeapon(weapons.CLAYMOR);
	
			player.str = 41;
			//femininity: 95
			player.femininity = 95;
			//(0 lust cum production: 10000)
			player.cumMultiplier += 500;
			//(base fertility 20 if possible?)
			player.fertility = 20;
			//Appearence: 7ft 9in tall covered in thick shining silver fur, has a vulpine head and ears, eight breast all the same size at DD, dragon like wings, tail, and legs. With a large mare like pussy, 6 dicks, two equine, two dragon, two vulpine, all 15in long and 3 in wide, and four nuts 5 in across
			player.tallness = 93;
			player.skinTone = "black";
			player.hairColor = "silver";
			player.skin.growFur({});
			player.faceType = Face.FOX;
			player.ears.type = Ears.FOX;
			player.createBreastRow();
			player.createBreastRow();
			player.createBreastRow();
			player.breastRows[0].breastRating = 5;
			player.breastRows[0].nipplesPerBreast = 4;
			player.breastRows[0].fuckable = true;
			player.breastRows[1].breastRating = 5;
			player.breastRows[1].nipplesPerBreast = 4;
			player.breastRows[1].fuckable = true;
			player.breastRows[2].breastRating = 5;
			player.breastRows[2].nipplesPerBreast = 4;
			player.breastRows[2].fuckable = true;
			player.breastRows[3].breastRating = 5;
			player.breastRows[3].nipplesPerBreast = 4;
			player.breastRows[3].fuckable = true;
			if(!player.hasCock()) player.createCock();
			player.createCock();
			player.createCock();
			player.createCock();
			player.createCock();
			player.createCock();
			player.cocks[0].cockType = CockTypesEnum.HORSE;
			player.cocks[0].cockLength = 15;
			player.cocks[0].cockThickness = 3;
			player.cocks[1].cockType = CockTypesEnum.HORSE;
			player.cocks[1].cockLength = 15;
			player.cocks[1].cockThickness = 3;
			player.cocks[2].cockType = CockTypesEnum.DOG;
			player.cocks[2].cockLength = 15;
			player.cocks[2].cockThickness = 3;
			player.cocks[2].knotMultiplier = 2;
			player.cocks[3].cockType = CockTypesEnum.DOG;
			player.cocks[3].cockLength = 15;
			player.cocks[3].cockThickness = 3;
			player.cocks[3].knotMultiplier = 2;
			player.cocks[4].cockType = CockTypesEnum.DRAGON;
			player.cocks[4].cockLength = 15;
			player.cocks[4].cockThickness = 3;
			player.cocks[5].cockType = CockTypesEnum.DRAGON;
			player.cocks[5].cockLength = 15;
			player.cocks[5].cockThickness = 3;
			player.balls = 4;
			player.ballSize = 5;
			//hair length: 15 in
			player.hairLength = 15;
			//hip size: 15/20
			player.hips.type = 15;
			//butt size: 15/20
			player.butt.type = 15;
			//body thickness: 50/100
			player.thickness = 50;
			//Muscle: 75/100"
			player.tone = 75;
			//for wetness a squirter, looseness a 2 and capacity at 140.
			if(!player.hasVagina()) player.createVagina();
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLAVERING;
			player.createStatusEffect(StatusEffects.BonusVCapacity,132,0,0,0);
			//Virgin, high fertility like in the email I sent before.  dragon wings, nine fox tails,  dragon legs, eight DD breasts with four fuckable nipples each, dragon tongue, waist length hair, large dragon wings.
			player.wings.type = Wings.DRACONIC_LARGE;
			player.wings.desc = "large, draconic";
			player.tailType = Tail.FOX;
			player.tailCount = 9;
			player.lowerBody = LowerBody.DRAGON;
			player.tongue.type = Tongue.DRACONIC;
			player.hairLength = 45;
			player.createPerk(PerkLib.EnlightenedNinetails,0,0,0,0);
		}
		
		private function customNixi():void {
			//-Perks
			//fertility AND messy orgasm (hope that's not pushing it)
			player.createPerk(PerkLib.MessyOrgasms, 1.5, 0, 0, 0);
			player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			//fighting history
			if (!player.hasPerk(PerkLib.PastLifeFighter)) player.createPerk(PerkLib.HistoryFighter,0,0,0,0);
			//3 starting perk points
			player.perkPoints = 3;
			//some starting gems (just go ahead and surprise me on the amount)
			player.gems = rand(800);
			//Specific Character
			//-Female... with a dog cock
			//11"" long, 2"" wide, 2.4"" knot
			//no balls
			//virgin pussy, 0.2"" clit
			//wetness 2
			//fertility 30 
			//virgin bum
			//anal wetness 1
			player.ass.analWetness = 2;
			player.createCock();
			player.cocks[0].cockLength = 11;
			player.cocks[0].cockThickness = 2;
			player.cocks[0].knotMultiplier = 1.2;
			player.cocks[0].cockType = CockTypesEnum.DOG;
			player.balls = 0;
			player.createBreastRow();
			player.createVagina();
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
			//1 pair DD's, 0.5"" nipples"
			player.breastRows[0].breastRating = 5;
			player.nippleLength = 0.5;
			player.clitLength = .5;
			player.fertility = 45;
			player.hips.type = 6;
			player.butt.type = 6;
			player.str = 15;
			player.tou = 15;
			player.spe = 18;
			player.inte = 17;
			player.sens = 15;
			player.lib = 15;
			player.cor = 0;
			player.HP = EngineCore.maxHP();
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 85;
			player.beardLength = 0;
			player.beardStyle = 0;
			//75 muscle tone
			player.tone = 75;
			//25 thickness
			player.thickness = 25;
			player.skin.growFur({});
			player.skinTone = "light";
			player.hairColor = "silver";
			player.hairLength=10;
			//shoulder length silver hair
	
			player.balls = 0;
			player.cumMultiplier = 2;
			player.ballSize = 0;
			player.hoursSinceCum = 0;
			player.clitLength = 0;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tallness = 82;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			//6' 10"" german-shepherd morph, face ears hands feet tail, the whole nine yards
			player.faceType = Face.DOG;
			player.lowerBody = LowerBody.DOG;
			player.tailType = Tail.DOG;
			player.ears.type = Ears.DOG;
			////"	"I'm picturing a tall, feminine German-Shepherd morph, solid white and gorgeous. She has both sets of genitals, with no balls, and a large set of breasts. She wields a large claymore and is dressed in a full chain vest and pants. 
			//large claymore (and the strength to use it)
			player.setWeapon(weapons.CLAYMOR);
			player.str = 40;
			//full chain
			player.setArmor(armors.FULLCHN);
			outputText("As a German-Shepherd morph, the rest of the village never really knew what to do with you... until they sent you through the portal to face whatever's on the other side...");
		}
		
		private function customPrismere():void {
			//Specific Character	Female, virgin, high fertility, tight with standard wetness and clit.
			player.createVagina();
			player.clitLength = 0.25;
			player.fertility = 4;
			player.spe += 20;
			outputText("You're more of a scout than a fighter, but you still feel confident you can handle your responsibilities as champion.  After all, what's to worry about when you can outrun everything you encounter?  You have olive skin, deep red hair, and a demonic tail and wings to blend in with the locals.");
			//Perk is speed, she was a scout, and it'd be neat (if possible) to give her something akin to the Runner perk. She might not start out very strong or tough, but at least she's fast.
			player.createPerk(PerkLib.Fast, 1, 0, 0, 0);
			player.createPerk(PerkLib.Runner, 0, 0, 0, 0);
			//In the human world, Prismere began as a scout, helping patrol areas with portals to make sure demonspawn and corruption didn't reach the human homeland. She's gotten herself into a few tight spots because of it, but she's hard to keep pinned down. She has a fiance back in her village whom she fully intends to get back to, so her libido isn't especially high. 
			//As of the time the PC takes her on, she has some signs of demonic taint, so Corruption might start at 5 to 10 points."	"Breasts at E, height at 5'0, a curvy build with a more narrow waist and substantial hips and butt. Skin is olive, like a mocha, hair is long and wildly wavy, a deep red, and eyes are a stormy blue. Muscles are barely visible; what muscle she has is the lean build of a runner, not a fighter. Nipples aren't especially long, but more soft. 
			player.cor = 5;
			player.createBreastRow();
			player.breastRows[0].breastRating = 7;
			player.tallness = 60;
			player.hips.type = 8;
			player.butt.type = 8;
			player.thickness = 25;
			player.tone = 40;
			player.skinTone = "olive";
			player.hairLength = 30;
			player.hairColor = "deep red";
			player.femininity = 90;
			//She has a demonic tail and small demonic wings thanks to some encounters early on with succubus milk (that stuff is delicious!) but is otherwise still human.
			player.wings.type = Wings.BAT_LIKE_LARGE;
			player.wings.desc = "large, bat-like";
			player.tailType = Tail.DEMONIC;
			//I feel really weird talking about all this, so if there's anything you need to change or can't do, or if I totally misinterpreted this, just shoot me an email! jordie.wierenga@gmail.com . Thanks in advance... I'm a big fan. "	Prismere
		}
		
		private function customRannRayla():void {
			//Specific Character	Virgin female.	Max femininity. Thin with a little muscle. Size C breasts. Long red hair. Light colored skin. 5'5" tall. 	Rann Rayla
			outputText("You're a young, fiery redhead who\'s utterly feminine.  You've got C-cup breasts and long red hair.  Being a champion can\'t be that bad, right?");
			player.createVagina();
			player.clitLength = 0.25;
			player.createBreastRow();
			player.breastRows[0].breastRating = 3;
			player.nippleLength = 0.5;
			player.hairLength = 22;
			player.hairColor = "red";
			player.skin.setAllProps({base:{color:"light"}});
			player.femininity = 100;
			player.thickness = 25;
			player.tone = 65;
			player.tallness = 65;
		}
		
		private function customRope():void {
			//529315025394020	Character Creation	Neuter (no genitals) "50-50 masculine-feminine ratio. Shark teeth."	Rope
			outputText("Despite outward appearances, you're actually something of a neuter, with shark-like teeth, an androgynous face, and a complete lack of genitalia.");
			if(player.hasCock()) player.removeCock(0,1);
			if(player.hasVagina()) player.removeVagina();
			player.femininity = 50;
			player.faceType = Face.SHARK_TEETH;
		}
		
		private function customSera():void {
			outputText("You're something of a shemale - three rows of C-cup breasts matched with three, plump, juicy cocks.  Some decent sized balls, bat wings, and cat-like ears round out the package.");
			player.tou +=2;
			player.str += 3;
			player.fertility = 5;
			player.hairLength= 26;
			player.hairColor = "white";
			player.skinTone = "light";
			player.nippleLength = 0.2;
			player.createBreastRow();
			player.createBreastRow();
			player.createBreastRow();
			player.breastRows[0].breastRating = 3;
			player.breastRows[1].breastRating = 3;
			player.breastRows[2].breastRating = 3;
			player.createCock();
			player.createCock();
			player.createCock();
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.6;
			player.cocks[1].cockLength = 8;
			player.cocks[1].cockThickness = 1.6;
			player.cocks[2].cockLength = 8;
			player.cocks[2].cockThickness = 1.6;
			player.balls = 2;
			player.ballSize = 3;
			player.tallness = 113;
			player.tone = 50;
			player.thickness = 50;
			player.femininity = 50;
			player.hips.type = 5;
			player.butt.type = 5;
			player.teaseLevel = 1;
			//Build: average
			//Complexion: light
			//9 foot 5 inches tall
			//Hair: very long white
			//Gift: Lotz of Jizz
			//History: Schooling
			player.cumMultiplier = 11;
	
			player.createPerk(PerkLib.MessyOrgasms, 1.5, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			//Apperance: Cat Ears, Large Bat Like Wings, 3 Rows of breasts (C cub, 0,2 nipples)
			player.ears.type = Ears.CAT;
			player.wings.type = Wings.BAT_LIKE_LARGE;
			player.wings.desc = "large, bat-like";
			//Items: Katana, Leather Armor
			player.setWeapon(weapons.KATANA);
			player.setArmor(armors.URTALTA);
			//Key Item: Deluxe Dildo
			player.createKeyItem("Deluxe Dildo",0,0,0,0);
		}
		
		private function customSiveen():void {
			//Female
			//Virgin
			player.createVagina();
			player.clitLength = 0.25;
			//has a self-repairing hymen in her cunt"	"Angel
			//(means feathered wings on her back)
			player.wings.type = Wings.HARPY;
			//Halo (Flaming)
			//D-cups
			player.createBreastRow();
			player.breastRows[0].breastRating = 4;
			//human skin
			//heart-shaped ass
			player.butt.type = 9;
			player.hips.type = 6;
			//Ass-length white and black hair
			player.hairLength = 30;
			player.hairColor = "white and black";
			//heterochromia (one blue eye one red eye)
			//7"" nips
			player.nippleLength = 7;
			//waif thin body
			player.thickness = 0;
			//Fallen Angel gear (complete with flaming sword and light arrows)
			//dark skin tone
			player.skinTone = "dark";
			player.setWeapon(weapons.S_BLADE);
			//Elfin ears
			player.ears.type = Ears.ELFIN;
			//tight asshole
			//human tongue
			//human face
			//no tail, fur, or scales"
			flags[kFLAGS.HISTORY_PERK_SELECTED] = 0;
			player.str = 25;
			player.tou = 25;
			player.spe = 25;
			player.inte = 25;
			player.wis = 25;
			outputText("You are a literal angel from beyond, and you take the place of a vilage's champion for your own reasons...");
		}
		
		private function customSora():void {
			//Character Creation	Female,virgin	A kitsune with a snake-like tongue	Sora
			if(player.hasVagina()) player.vaginas[0].virgin = true;
			player.tongue.type = Tongue.SNAKE;
			player.ears.type = Ears.FOX;
			player.tailType = Tail.FOX;
			player.tailCount = 2;
			player.inte = 30;
			if(!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
			else player.addStatusValue(StatusEffects.BonusVCapacity,1, 5 + rand(10));
			outputText("As a Kitsune, you always got weird looks, but none could doubt your affinity for magic...");
		}
		
		private function customGrigori():void {
			//Character Creation	Male	A human with dragon bloodline	Grigori
			player.createPerk(PerkLib.DragonIceBreath,0,0,0,0);
			player.createPerk(PerkLib.BloodlineDragon,0,0,0,0);
			player.balls = 2;
			player.ballSize = 1;
			player.clitLength = 0;
			player.createCock();
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.5;
			player.cocks[0].cockType = CockTypesEnum.DRAGON;
			player.cocks[0].knotMultiplier = 1.3;
			player.createBreastRow();
			player.str = 20;
			player.tou = 30;
			player.spe = 40;
			player.gems += 300;
			player.tone = 60;
			player.femininity = 30;
			player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeFighter)) player.createPerk(PerkLib.HistoryFighter,0,0,0,0);
			if (!player.hasPerk(PerkLib.PastLifeFortune)) player.createPerk(PerkLib.HistoryFortune,0,0,0,0);
			outputText("You are a normal villager if not for that dragon cock and the ability to use an ice dragon's breath. That damn ancestor of yours had to go and fuck some dragoness, didn't he?");
		}
		
		private function customSora2():void {
			//Character Creation	Female,virgin	A human with kitsune bloodline	Sora
			player.createPerk(PerkLib.BloodlineKitsune,0,0,0,0);
			if (player.hasVagina()) player.vaginas[0].virgin = true;
			if (!player.hasPerk(PerkLib.PastLifeAlchemist)) player.createPerk(PerkLib.HistoryAlchemist,0,0,0,0);
			player.inte = 30;
			outputText("As a Kitsune, you always got weird looks, but none could doubt your affinity for magic...");
		}
		
		private function customSora3():void {
			//Character Creation	Female,virgin	A human with cow/mintaur bloodline	Sora
			player.createPerk(PerkLib.BloodlineMinotaur,0,0,0,0);
			if (player.hasVagina()) player.vaginas[0].virgin = true;
			if (!player.hasPerk(PerkLib.PastLifeAlchemist)) player.createPerk(PerkLib.HistoryAlchemist,0,0,0,0);
			player.inte = 30;
			outputText("As a Kitsune, you always got weird looks, but none could doubt your affinity for magic...");
		}
		
		private function customVeseshe():void {
			//Character Creation	Herm	A human with elf bloodline	Veseshe
			player.createPerk(PerkLib.BloodlineElf,0,0,0,0);
			player.createBreastRow();
			player.breastRows[0].breastRating = 2;
			player.balls = 2;
			player.ballSize = 1;
			player.createVagina();
			player.vaginas[0].virgin = false;
			player.createCock();
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.5;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.butt.type = 9;
			player.hips.type = 6;
			player.createPerk(PerkLib.WetPussy, 2, 0, 0, 0);
			player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
			player.createStatusEffect(StatusEffects.Kelt, 100, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeSlut)) player.createPerk(PerkLib.HistorySlut,0,0,0,0);
			if (!player.hasPerk(PerkLib.PastLifeWhore)) player.createPerk(PerkLib.HistoryScout,0,0,0,0);
			outputText("The village sure liked to pierce their arrows into you. But with your natural agility and a bit of elven blood flowing in your veins they sure were trying...");
		}
		
		private function customTeekna():void {
			//Character Creation	Female,virgin	A human with goblin bloodline	Teekna
			player.createPerk(PerkLib.BloodlineGoblin,0,0,0,0);
			player.createBreastRow();
			player.breastRows[0].breastRating = 4;
			player.butt.type = 9;
			player.hips.type = 6;
			player.createVagina();
			player.vaginas[0].virgin = true;
			player.inte = 40;
			player.wis = 40;
			player.gems += 250;
			player.tallness = 45;
			player.tone = 30;
			player.femininity = 70;
			player.hairColor = "pink";
			player.eyes.colour = "yellow";
			player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar,0,0,0,0);
			if (!player.hasPerk(PerkLib.PastLifeAlchemist)) player.createPerk(PerkLib.HistoryAlchemist,0,0,0,0);
			player.createKeyItem("Mechanic's Wrench", 0, 0, 0, 0);
			player.createKeyItem("Engineer's Toolbox", 0, 0, 0, 0);
			player.createKeyItem("Toolbelt", 0, 0, 0, 0);
			player.createKeyItem("Blueprint - Energy Core", 0, 0, 0, 0);
			player.createKeyItem("Blueprint - Mechanism", 0, 0, 0, 0);
			if(!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
			else player.addStatusValue(StatusEffects.BonusVCapacity,1, 5 + rand(10));
			outputText("You were a pretty normal villager, the only oddity other people noticed was your dyed pink hair and yellow eyes. Your ancestor just couldn't keep it in his pants apparently. At least they left some goodies behind for you!");
		}
		
		private function customSora6():void {
			//Character Creation	Female,virgin	A human with raiju bloodline	Sora
			player.createPerk(PerkLib.BloodlineRaiju,0,0,0,0);
			if(player.hasVagina()) player.vaginas[0].virgin = true;
			player.inte = 30;
			outputText("As a Kitsune, you always got weird looks, but none could doubt your affinity for magic...");
		}
		
		private function customSora7():void {
			//Character Creation	Female,virgin	A human with oni bloodline	Sora(tone at 100, fighter past story + second for fight too? oni beard necklace?)keeping titanic strength perk at any race score? start with this event perk?
			player.createPerk(PerkLib.BloodlineOni,0,0,0,0);
			if(player.hasVagina()) player.vaginas[0].virgin = true;
			player.inte = 30;
			outputText("As a Kitsune, you always got weird looks, but none could doubt your affinity for magic...");
		}
		
		private function customTestChar():void {
			player.XP = 500000;
			player.level = 20;
			player.createBreastRow();
			player.createVagina();
			player.breastRows[0].breastRating = 5;
			player.breastRows[0].lactationMultiplier = 2;
			player.clitLength = 0.5;
			player.fertility = 50;
			player.hips.type = 6;
			player.butt.type = 6;
			player.str = 100;
			player.tou = 100;
			player.spe = 100;
			player.inte = 100;
			player.sens = 100;
			player.wis = 100;
			player.lib = 30;
			player.cor = 71;
			player.HP = EngineCore.maxHP();
			player.hairLength = 10;
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.FOX;
			player.tailCount = 4;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 90;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 0;
			player.thickness = 100;
			player.skinTone = "pale";
			player.hairColor = "black";
			player.balls = 2;
			player.cumMultiplier = 1;
			player.ballSize = 3;
			player.hoursSinceCum = 0;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 50;
			player.fatigue = 0;
			player.horns.count = 0;
			player.horns.type = Horns.NONE;
			player.tallness = 109;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.wings.type = Wings.DRACONIC_LARGE;
			player.wings.desc = "non-existant";
			player.ears.type = Ears.HUMAN;
			player.lowerBody = LowerBody.HUMAN;
			player.arms.type = Arms.HUMAN;
			player.hairLength = 69.2;
			player.hairType = 4;
			//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
			player.createStatusEffect(StatusEffects.Kelt,100,0,0,0);
			
			player.createKeyItem("Zetaz's Map", 0, 0, 0, 0);
			
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			player.createKeyItem("Camp - Chest",0,0,0,0);
			player.createKeyItem("Equipment Rack - Weapons",0,0,0,0);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] = 1;
			player.createKeyItem("Equipment Rack - Armor",0,0,0,0);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] = 1;
			player.createKeyItem("Equipment Storage - Jewelry Box",0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsWhitefire, 0, 0, 0, 0);
			
			if (!player.hasPerk(PerkLib.PastLifeFighter)) player.createPerk(PerkLib.HistoryFighter, 		0, 0, 0, 0);
			player.createPerk(PerkLib.Acclimation, 			0, 0, 0, 0);
			player.createPerk(PerkLib.Berzerker, 			0, 0, 0, 0);
			player.createPerk(PerkLib.BrutalBlows, 			0, 0, 0, 0);
			player.createPerk(PerkLib.DoubleAttack, 		0, 0, 0, 0);
			player.createPerk(PerkLib.ImmovableObject, 		0, 0, 0, 0);
			player.createPerk(PerkLib.LightningStrikes, 	0, 0, 0, 0);
			player.createPerk(PerkLib.LungingAttacks, 		0, 0, 0, 0);
			player.createPerk(PerkLib.Precision, 			0, 0, 0, 0);
			player.createPerk(PerkLib.Regeneration, 		0, 0, 0, 0);
			player.createPerk(PerkLib.ResistanceI,			0, 0, 0, 0);
			player.createPerk(PerkLib.Resolute,				0, 0, 0, 0);
			player.createPerk(PerkLib.SpeedyRecovery,		0, 0, 0, 0);
			player.createPerk(PerkLib.Tactician,			0, 0, 0, 0);
			player.createPerk(PerkLib.RefinedBodyI,			0, 0, 0, 0);
			player.createPerk(PerkLib.TankI,				0, 0, 0, 0);
			player.createPerk(PerkLib.ThunderousStrikes,	0, 0, 0, 0);
			player.createPerk(PerkLib.WeaponMastery,		0, 0, 0, 0);
			player.createPerk(PerkLib.WellAdjusted,			0, 0, 0, 0);
			
			player.createPerk(PerkLib.SensualLover, 		0, 0, 0, 0);
			player.createPerk(PerkLib.SensualLover, 		0, 0, 0, 0);
			
			flags[kFLAGS.VALARIA_AT_CAMP] = 1;
			
			player.gems += 30000;
			outputText("You're something of a powerhouse, and you wager that between your odd mutations, power strong enough to threaten the village order, and talents, you're the natural choice to send through the portal.");
			
			player.itemSlot6.unlocked = true;
			player.itemSlot7.unlocked = true;
			player.itemSlot8.unlocked = true;
			player.itemSlot1.setItemAndQty(consumables.P_LBOVA, 5);
			player.itemSlot2.setItemAndQty(consumables.L_PNKEG, 1);
			player.itemSlot3.setItemAndQty(consumables.OVIELIX, 1);
			player.itemSlot4.setItemAndQty(consumables.REPTLUM, 1);
			
			player.createStatusEffect(StatusEffects.TelAdre, 1, 0, 0, 0);
			//player.createStatusEffect(StatusEffects.MetWhitney, 2, 0, 0, 0);
			
			// Izma
			flags[kFLAGS.IZMA_FOLLOWER_STATUS] = 1;
			
			// Vapula
			flags[kFLAGS.VAPULA_FOLLOWER] = 1;
			
			// Amily
			//flags[kFLAGS.AMILY_FOLLOWER] = 2;
			
			// Jojo
			//CoC.instance.monk = 5;
			
			// Bimbo Sophie
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] = 1;
			
			// Isabella
			flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] = 1;
			
			// Latexy
			flags[kFLAGS.GOO_SLAVE_RECRUITED] = 1;
			flags[kFLAGS.GOO_NAME] = "Latexy";
			flags[kFLAGS.GOO_FLUID_AMOUNT] = 100;
			flags[kFLAGS.GOO_HAPPINESS] = 100;
			flags[kFLAGS.GOO_OBEDIENCE] = 100;
			
			// Ceraph
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00286] = 1;
			
			// Holli
			flags[kFLAGS.FUCK_FLOWER_LEVEL] = 4;
			
			// Milky
			flags[kFLAGS.MILK_NAME] = "Milky";
			flags[kFLAGS.MILK_SIZE] = 2;
			
			// Rubi Testing
			//flags[kFLAGS.RUBI_SUITCLOTHES] = 1;
			//flags[kFLAGS.RUBI_FETISH_CLOTHES] = 1;
			//flags[kFLAGS.RUBI_GREEN_ADVENTURER] = 1;
			//flags[kFLAGS.RUBI_TUBE_TOP] = 1;
			//flags[kFLAGS.RUBI_BODYSUIT] = 1;
			//flags[kFLAGS.RUBI_LONGDRESS] = 1;
			//flags[kFLAGS.RUBI_TIGHT_PANTS] = 1;
			//flags[kFLAGS.RUBI_NURSE_CLOTHES] = 1;
			//flags[kFLAGS.RUBI_SWIMWEAR] = 1;
			//flags[kFLAGS.RUBI_BIMBO_MINIDRESS] = 1;
			//flags[kFLAGS.RUBI_BONDAGE_STRAPS] = 1;
			//flags[kFLAGS.RUBI_INQUISITORS_CORSET] = 1;
			flags[kFLAGS.RUBI_AFFECTION] = 75;
			flags[kFLAGS.RUBI_INTRODUCED] = 1;
			
			// Bazaar
			flags[kFLAGS.BAZAAR_ENTERED] = 1;
		}
		
		private function customTyriana():void {
			outputText("Your many, posh tits, incredible fertility, and well-used cunt made you more popular than the village bicycle.  With your cat-like ears, paws, and tail, you certainly had a feline appeal.  It's time to see how you fare in the next chapter of your life.");
			//"Gender: Female
			//Vagina: Ridiculously loose, 3 inch clitoris, dripping constantly, fertile like a bunny on steroids and non-virgin
			player.createVagina();
			player.clitLength = 3;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_DROOLING;
			player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR;
			player.vaginas[0].virgin = false;
			player.fertility = 65;
			//Butt: Just as loose
			player.ass.analLooseness = 5;
			//"Skin: Tanned
			player.skinTone = "tan";
			//Hair: Ridiculously long red
			player.hairLength = 80;
			player.hairColor = "red";
			//Face: Gorgeous Feminine, long demonic tongue, cat ears
			player.femininity = 100;
			player.tongue.type = Tongue.DEMONIC;
			player.ears.type = Ears.CAT;
			//Body: Very muscular, average weight, plump ass, above average thighs, cat tail and cat paws
			player.tone = 80;
			player.thickness = 50;
			player.butt.type = 12;
			player.hips.type = 10;
			player.tailType = Tail.CAT;
			player.lowerBody = LowerBody.CAT;
			//Breasts: 2 E-cups on top, 2 DD-cups mid, 2 D-cups bottom, 3.5 inch nipples
			player.createBreastRow();
			player.createBreastRow();
			player.createBreastRow();
			player.tallness = 67;
			player.breastRows[0].breastRating = 7;
			player.breastRows[1].breastRating = 5;
			player.breastRows[2].breastRating = 4;
			player.nippleLength = 3.5;
			//Perks: Slut and Fertile"	
			
			player.spe+=3;
			player.inte+=2;
	
			if (!player.hasPerk(PerkLib.PastLifeSlut)) player.createPerk(PerkLib.HistorySlut, 0, 0, 0, 0);
			player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			player.teaseLevel = 3;
		}
		
		private function customVahdunbrii():void {
			player.createBreastRow();
			player.createVagina();
			player.breastRows[0].breastRating = 3;
			player.clitLength = .5;
			player.fertility = 25;
			player.hips.type = 6;
			player.butt.type = 6;
			player.str = 15;
			player.tou = 15;
			player.spe = 18;
			player.inte = 17;
			player.sens = 15;
			player.lib = 15;
			player.cor = 0;
			player.HP = EngineCore.maxHP();
			player.hairLength = 10;
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 70;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 30;
			player.thickness = 50;
			player.skinTone = "light";
			player.hairColor = "brown";
			player.balls = 0;
			player.cumMultiplier = 1;
			player.ballSize = 0;
			player.hoursSinceCum = 0;
			player.clitLength = 0;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tallness = 67;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			player.ears.type = Ears.CAT;
			player.lowerBody = LowerBody.CAT;
			player.tailType = Tail.CAT;
			player.createPerk(PerkLib.Incorporeality,0,0,0,0);
			player.wings.type = Wings.FEATHERED_LARGE;
			player.arms.type = Arms.HARPY;
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.count = 4;
			player.faceType = Face.SPIDER_FANGS;
			player.hairLength = 69.2;
			player.hairColor = "dark blue";
			player.hairType = 2;
			player.skinAdj = "smooth";
			player.skinTone = "sanguine";
			player.tallness = 68;
			player.hips.type = 7;
			player.butt.type = 6;
			player.thickness = 4;
			player.tone = 98;
			player.breastRows[0].breastRating = 3;
			player.clitLength = 0.2;
			player.femininity = 85;
			//Beautiful Sword
			player.setWeapon(weapons.B_SWORD);
			player.setArmor(armors.SSARMOR);
			//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
			player.createStatusEffect(StatusEffects.Kelt,100,0,0,0);
			//player.createKeyItem("Bow",0,0,0,0);
			player.setWeaponRange(weaponsrange.BOWOLD_);
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			inventory.createStorage();
			player.createKeyItem("Camp - Chest",0,0,0,0);
			player.createKeyItem("Equipment Rack - Weapons",0,0,0,0);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] = 1;
			player.createKeyItem("Equipment Rack - Armor",0,0,0,0);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] = 1;
			//(Flexibility), (Incorporeality), History: Religious, Dragonfire, Brood Mother, Magical Fertility, Wet Pussy, Tough, Strong, Fast, Smart, History: Scholar, History: Slacker, Strong Back, Strong Back 2: Stronger Harder
			player.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeReligious)) player.createPerk(PerkLib.HistoryReligious, 0, 0, 0, 0);
			player.createPerk(PerkLib.DragonFireBreath, 0, 0, 0, 0);
			player.createPerk(PerkLib.DragonIceBreath,0,0,0,0);
			player.createPerk(PerkLib.BroodMother, 0, 0, 0, 0);
			player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
			player.createPerk(PerkLib.WetPussy,2,0,0,0);
			player.createPerk(PerkLib.Tough, 1, 0, 0, 0);
			player.createPerk(PerkLib.Strong, 1, 0, 0, 0);
			player.createPerk(PerkLib.Fast, 1, 0, 0, 0);
			player.createPerk(PerkLib.Smart, 1, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			player.createPerk(PerkLib.StrongBack,0,0,0,0);
			player.createPerk(PerkLib.StrongBack2,0,0,0,0);
			player.createPerk(PerkLib.StrongBack3,0,0,0,0);
			player.itemSlot6.unlocked = true;
			player.itemSlot7.unlocked = true;
			player.itemSlot8.unlocked = true;
			if (!player.hasPerk(PerkLib.PastLifeSlacker)) player.createPerk(PerkLib.HistorySlacker,0,0,0,0);
			player.str += 4;
			player.tou += 4;
			player.inte += 2;
			player.spe += 2;
			player.gems += 300;
			outputText("You're something of a powerhouse, and you wager that between your odd mutations, power strong enough to threaten the village order, and talents, you're the natural choice to send through the portal.");
		}
		
		private function customZavos():void {
			player.createCock();
			player.balls = 2;
			player.ballSize = 1;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockLength = 5.8;
			player.tallness = 70;
			player.femininity = 30;
			player.hairLength = 1;
			player.hairColor = "black";
			player.butt.type = 3;
			player.hips.type = 3;
			player.createBreastRow();
			player.skinTone = "fair";

			player.setArmor(armors.H_GARB_);
			player.setShield(shields.BLASPHE);
			player.setJewelry(jewelries.MSIGNIT);
			player.setUndergarment(undergarments.C_LOIN);
			player.createKeyItem("Dark Mage’s Grimoire",0,0,0,0);
			if (player.hasKeyItem("Backpack") < 0) player.createKeyItem("Backpack", 3, 0, 0, 0);
			player.itemSlot1.setItemAndQty(consumables.H_BISCU, 5);

			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeHealer)) player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
			player.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			player.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			player.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			player.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			player.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			player.createPerk(PerkLib.DarkCharm, 0, 0, 0, 0);
			player.createPerk(PerkLib.BlackHeart, 0, 0, 0, 0);
			player.createPerk(PerkLib.Pervert, 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.KnowsArouse,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsHeal,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsManyBirds,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
			player.inte = 40;
			player.tou = 25;
			player.spe = 20;
			player.str = 15;
			player.cor = 30;
			player.lib = 30;
			player.sens = 10;
			outputText("You have been fascinated with magic as long as you can remember.  The villagers humored this at first, regaling you with stories about mages of old and providing “spellbooks” that were more superstition than fact.  When you learned to cast whitefire without any instruction, the villagers got worried. Your salvation came in the form of a traveling mage, a hero himself in his youth. He provided the apprenticeship you craved and focused your eccentricities into mastering the art of magical healing.  While you had earned yourself a respectable livelihood well before your coming of age, your fascination with the unnatural has always unnerved your friends and neighbors.  One year, an unknown disease passed through the town.  You saw this peculiar sickness as a challenge, and devised a spell to neutralize it.  ");
			outputText("While you saved several lives, a handful of villagers died before you bested the plague. Rumors spread that you used their deaths to fuel unnatural rituals, bringing all the fear and suspicion focused on you over the years to a crux.  Your trial was swift, but you accepted the outcome without a second thought.  Whatever lay beyond that portal, you knew it would fall to your powers.");
		}
		
		private function customKitteh6660():void { //Not yet implemented.
			
		}
		
		private function customEtis():void {
			// Herm kitsune-dragon with 3 tentacle cocks. And tentacle hair. And tentacle (well, draconic, but sort of) tongue.
			// Was really struggling between dragonne and kitsune for alter ego character, 'cause feline body is more appealing, but kitsune's magic affinity turns the scales.
			
			// ascension cleanup
			while (player.hasVagina())			
				player.removeVagina();
			while (player.hasCock())			
				player.removeCock(0, 1);				
			while (player.bRows() > 1)			
				player.removeBreastRow(0, 1);			

			player.createVagina();
			player.vaginas[0].vaginalLooseness = 0;
			player.vaginas[0].vaginalWetness = 2; // wet
			player.vaginas[0].virgin = false;
			player.createStatusEffect(StatusEffects.BonusVCapacity, 8000, 0, 0, 0); // Vag of Holding kitsune trait
			player.clitLength = 0.3;
			player.fertility = 5;
			
			if (player.bRows() == 0) player.createBreastRow();			
			player.breastRows[0].breastRating = 1; // a-cup, 'cause huge boobs wouldn't fit your small frame... in fact, you almost considered to have flats
			player.breastRows[0].fuckable = true; // some people have hammerspace to store gear when they don't need it, and you are jealous. from other side, you have cockspace to store cocks when you need them!
			
			player.ballSize = 0;
			player.balls = 0;
			player.cumMultiplier = 100; // don't ask how it works, copyright for this potion was sold for Joey

			player.ass.analWetness = 2; // moist
			player.ass.analLooseness = 1; // not virgin
			player.createStatusEffect(StatusEffects.BonusACapacity, 100, 0, 0, 0);

			player.createCock(12, 1.6, CockTypesEnum.TENTACLE); // as most kitsune you love tentackles
			player.createCock(12, 1.6, CockTypesEnum.TENTACLE); // and while they aren't really fitting your body...
			player.createCock(12, 1.6, CockTypesEnum.TENTACLE); // do anyone really need a reason to have TENTACLES?
			player.tallness = 48; // 120 cm
			player.hips.type = Hips.RATING_BOYISH;
			player.butt.type = Butt.RATING_TIGHT;
			player.thickness = 20; // thin
			player.tone = 20; // soft
			player.skin.setAllProps({base:{adj:"smooth",color:"light"}});
			player.hairColor   = "silver blonde"; // not just flavor - it actually counts towards kitsune score
			player.hairType    = Hair.ANEMONE; flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 1; // tentacle hair... never can have enough tentacles!
			player.hairLength  = 42; // obscenely long, you still can use ext serum to get more, but they would drag the floor, and this wouldn't be pleasant
			player.femininity  = 50; // androgynous
			player.beardLength = 0;
			player.beardStyle  = 0;
			
			player.ears.type = Ears.FOX;
			player.tailType = Tail.FOX; // soft fur feels so lovely... too bad having too much fox fur would make you dumber, and while you would enjoy feline body, channeling magic using nine tails is great benefit which is hard to give up
			player.tailCount = 9;
			player.tongue.type = Tongue.DRACONIC; // tongue as long as your whole body height! almost tentackle! and so much fun to use!
			player.horns.type = Horns.DRACONIC_X2; // draconic horns adds to your exotic look, counts towards dragon score and keeps your tentacle hair out of your face! and your partners can use them as handles on occasions, letting your delicate ears uncrumpled!
			player.horns.count = 12;
			player.wings.type = Wings.DRACONIC_LARGE; // wings! to fly!
			player.wings.desc = "large, draconic";
			
			player.str += -10; // strength? not a kitsune way, besides, you are small and really neglected physical training
			player.tou += 0; // still, your dragon blood makes you surprisingly tough for your size and condition
			player.spe += 5; // can take some advantage from small frame
			player.inte += 55; // your mind is your power!
			player.wis += 55; // your mind is your power!
			player.lib += 85; // yes, you have problems
			player.cor += 31; // have high initial corruption, but also have religious history to meditate
			
			// bow and concealing leather armor with robes, also can handle rapier well, but doesn't have one
			if (player.armor == ArmorLib.NOTHING || player.armor == armors.C_CLOTH) player.setArmor(armors.LTHRROB); // you like concealing clothes, your body is your masterpiece, but your extra benefits are more fun when not expected... ok, you are a bit shy of your tentacles
			if (player.weapon == WeaponLib.FISTS) player.setWeapon(weapons.SUCWHIP); // have succubus whip, to get corruption quickly when desired
			//if (player.jewelry == JewelryLib.NOTHING) player.setJewelry(jewelries.PURERNG);
			if (debug) {
				if (!player.hasStatusEffect(StatusEffects.Kelt)) player.createStatusEffect(StatusEffects.Kelt, 100, 0, 0, 0); // Kelt, you are dick.
				player.setWeaponRange(weaponsrange.BOWOLD_);
				flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 4; // Raphael is too picky, and also pretty much unfinished - you can't continue training after chase scene.			
				if (player.teaseLevel < 3) player.teaseLevel = 3; }			
			
			// almost compulsive hoarder, start with backpack, chests and racks... never enough storage space
			if (player.findPerk(PerkLib.StrongBack) < 0) { player.createPerk(PerkLib.StrongBack, 0, 0, 0, 0); player.itemSlot6.unlocked = true; }
			if (player.findPerk(PerkLib.StrongBack2) < 0) { player.createPerk(PerkLib.StrongBack2, 0, 0, 0, 0); player.itemSlot7.unlocked = true; }
			if (player.findPerk(PerkLib.StrongBack3) < 0) { player.createPerk(PerkLib.StrongBack3, 0, 0, 0, 0); player.itemSlot8.unlocked = true; }
			var i:int = 0;			
			if (player.hasKeyItem("Backpack") < 0) player.createKeyItem("Backpack", 5, 0, 0, 0);			
			if (player.hasKeyItem("Camp - Chest") < 0) { player.createKeyItem("Camp - Chest", 0, 0, 0, 0); for (i = 0; i < 6; i++) inventory.createStorage(); }			
			if (player.hasKeyItem("Camp - Murky Chest") < 0) { player.createKeyItem("Camp - Murky Chest", 0, 0, 0, 0); for (i = 0; i < 4; i++) inventory.createStorage(); }			
			if (player.hasKeyItem("Camp - Ornate Chest") < 0) { player.createKeyItem("Camp - Ornate Chest", 0, 0, 0, 0); for (i = 0; i < 4; i++) inventory.createStorage(); }			
			if (player.hasKeyItem("Equipment Rack - Weapons") < 0) { player.createKeyItem("Equipment Rack - Weapons", 0, 0, 0, 0); flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] = 1; }			
			if (player.hasKeyItem("Equipment Rack - Armor") < 0) { player.createKeyItem("Equipment Rack - Armor", 0, 0, 0, 0); flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] = 1; }			
			
			// have lots of different traits
			if (!player.hasPerk(PerkLib.PastLifeReligious) && player.findPerk(PerkLib.HistoryReligious) < 0) player.createPerk(PerkLib.HistoryReligious, 0, 0, 0, 0); // abandoned religion after obtaining nine tails and being disappointed in achieved enlightment
			if (!player.hasPerk(PerkLib.PastLifeFighter) && player.findPerk(PerkLib.HistoryAlchemist) < 0) player.createPerk(PerkLib.HistoryAlchemist, 0, 0, 0, 0); // and resorted to your hobby - alchemy
			if (player.findPerk(PerkLib.TransformationResistance) < 0) player.createPerk(PerkLib.TransformationResistance, 0, 0, 0, 0);  // tf resistance and alchemist are actually mutually nullifying each other - this is flavor mostly
			if (!player.hasPerk(PerkLib.PastLifeHealer) && player.findPerk(PerkLib.HistoryHealer) < 0) player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);  // with religious and alchemical knowlege you are skilled healer
			if (player.findPerk(PerkLib.Medicine) < 0) player.createPerk(PerkLib.Medicine, 0, 0, 0, 0); // able to treat wounds and poisoning alike
			if (player.findPerk(PerkLib.AscensionMoralShifter) < 0) player.createPerk(PerkLib.AscensionMoralShifter, 5, 0, 0, 0); // your kitsune's trickster nature makes you susceptable to corruption
			if (player.findPerk(PerkLib.AscensionTolerance) < 0) player.createPerk(PerkLib.AscensionTolerance, 10, 0, 0, 0); // but in the same time your enlightment keeps you from really turning to demon, so corruption level does not really affect you much
			if (player.findPerk(PerkLib.Fast) < 0) player.createPerk(PerkLib.Fast, 1, 0, 0, 0); // gaining speed is pain in ass... this one is not for history flavor
			if (player.findPerk(PerkLib.Smart) < 0) player.createPerk(PerkLib.Smart, 1, 0, 0, 0); // int is easy to get, just for history flavor
			if (player.findPerk(PerkLib.Lusty) < 0) player.createPerk(PerkLib.Lusty, 1, 0, 0, 0); // have a lust problem
			if (player.findPerk(PerkLib.HotBlooded) < 0) player.createPerk(PerkLib.HotBlooded, 20, 0, 0, 0); // even with your willpower and religious training you sometimes struggling to restrain your impulse
			if (player.findPerk(PerkLib.Pervert) < 0) player.createPerk(PerkLib.Pervert, 0.25, 0, 0, 0); // you always ready for something VERY lewd
			if (player.findPerk(PerkLib.Masochist) < 0) player.createPerk(PerkLib.Masochist, 0, 0, 0, 0); // with your knowlege of healing and innatural body it is easy for you to enjoy things which would be really painful for others
			if (player.findPerk(PerkLib.Sadist) < 0) player.createPerk(PerkLib.Sadist, 0, 0, 0, 0); // and you are always ready to return favor
			if (player.findPerk(PerkLib.SensualLover) < 0) player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0); // still you tend to care about mutual enjoyment - there are difference between extreme entertainment and torture, and you are mischievous, not evil
			if (player.findPerk(PerkLib.SpellcastingAffinity) < 0) player.createPerk(PerkLib.SpellcastingAffinity, 80, 0, 0, 0); // very strong magic affinity, can even be effective as mage without robe
			if (player.findPerk(PerkLib.Channeling) < 0) player.createPerk(PerkLib.Channeling, 0, 0, 0, 0); // despite strong magic affinity wasn't actually much interested in combat magic before, so only can use fox fire as offensive spell
			if (player.findPerk(PerkLib.Spellpower) < 0) player.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			// have some racial traits
			if (player.findPerk(PerkLib.EnlightenedNinetails) < 0) player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);			
			if (player.findPerk(PerkLib.DragonFireBreath) < 0) player.createPerk(PerkLib.DragonFireBreath, 0, 0, 0, 0);				
			if (player.findPerk(PerkLib.DragonIceBreath) < 0) player.createPerk(PerkLib.DragonIceBreath, 0, 0, 0, 0);				
			if (player.findPerk(PerkLib.DragonLightningBreath) < 0) player.createPerk(PerkLib.DragonLightningBreath, 0, 0, 0, 0);				
			if (player.findPerk(PerkLib.DragonDarknessBreath) < 0) player.createPerk(PerkLib.DragonDarknessBreath, 0, 0, 0, 0);				
			// some experiments with your body gave unusual results
			if (player.findPerk(PerkLib.LustyRegeneration) < 0) player.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0); // some of your experiments had nice returns
			if (player.findPerk(PerkLib.Incorporeality) < 0) player.createPerk(PerkLib.Incorporeality, 0, 0, 0, 0);	// some was... strange
			if (player.findPerk(PerkLib.ChiReflowMagic) < 0) player.createPerk(PerkLib.ChiReflowMagic, 0, 0, 0, 0);	// and some brought much more problems than benefits, but you wasn't able to reverse all of them. well, this is occupational hazard for alchemist
			// you have no idea how you got this... heritage, maybe?
			if (debug && player.findPerk(PerkLib.FerasBoonAlpha) < 0) player.createPerk(PerkLib.FerasBoonAlpha, 0, 0, 0, 0);			
			if (debug && player.findPerk(PerkLib.FerasBoonBreedingBitch) < 0) player.createPerk(PerkLib.FerasBoonBreedingBitch, 0, 0, 0, 0);		
			// Metamorph, Magic Metabolism and Puppeteer suggested perks would be also nice addition to character, but they are not implemented yet
			player.createPerk(PerkLib.GeneticMemory, 0, 0, 0, 0);
			player.createPerk(PerkLib.Metamorph, 0, 0, 0, 0);
			player.createPerk(PerkLib.MagicMetabolism, 0, 0, 0, 0);
			flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			
			// you still aren't sure about gender preferences, but have some stashed eggs just in case... [why almost all inventory functions are private?]
			if (player.itemSlot1.isEmpty())  player.itemSlot1.setItemAndQty(consumables.L_PNKEG, 1); // if you want to get rid of tentacles, but still maintain dragon one you'll have to find Ceraph
			if (player.itemSlot2.isEmpty())  player.itemSlot2.setItemAndQty(consumables.L_BLUEG, 1);
			if (debug && player.itemSlot3.isEmpty())  player.itemSlot3.setItemAndQty(consumables.REDUCTO, 5); 			
			if (debug && player.itemSlot4.isEmpty())  player.itemSlot4.setItemAndQty(consumables.GROPLUS, 5); 
			
			player.earsPierced = 1;
			player.earsPShort = "crimstone earrings";
			player.earsPLong = "Crimstone earrings";
			player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0); // with Omnibus' Gift it would give 50 min lust... perfect!
			
			player.createStatusEffect(StatusEffects.KnowsHeal, 0, 0, 0, 0); // to compliment history
			
			if (debug) { player.createStatusEffect(StatusEffects.TelAdre, 1, 1, 0, 0); flags[kFLAGS.BAZAAR_ENTERED] = 1; } // small straightforward cheating
			
			player.hoursSinceCum = 0;
			player.fatigue = 0;
			player.HP = EngineCore.maxHP();
			
			player.gems += 20;
			
			outputText("You are young (by kitsune measure), but very talented.\n\nFormer priestess, you abandoned religion after obtaining nine tails due to disappointment in achieved enlightment and resorted to your hobby - alchemy.\n\nYou tried to improve your body with controlled transformations, and mostly successfull. Now you are half-dragon, and while most changes are hidden inside your body, you still possess magnificent wings, imposing horns, incredibly long tongue and odd cock. Sharing common for kitsune tentacle obsession, you was unable to resist temptation, and now you have 3 tentacle cocks and venomous tentacle hair. Otherwise you body is mostly what you would expect from kitsune - cute, graceful and having capacity, straightforward impossible for your thin and small 4 foot frame.\n\nWith both religious and alchemical training you are skilled healer, able to treat wounds and poisonings alike. Your kitsune's trickster nature and pervert inclinations are making you susceptable to corruption, but at the same time your enlightment keeps you from really turning into demon, so corruption level does not really affect you much. Even with your willpower and religious training you sometimes struggle to restrain your impulse, and you always are ready for something very lewd. With your knowledge of healing and innatural body it is easy for you to enjoy things which would be really painful for others, and you are always ready to return favor. Still, you tend to care about mutual enjoyment - there are difference between extreme entertainment and torture, and you are mischievous, not evil. Natural gift, strong even by kitsune's measures and complimented by nine tails, granted you with very strong magic affinity, so you can cast spells not exhausting yourself even without enchanted robe, but despite strong magic affinity you wasn't actually much interested in combat magic before, so only can use fox fire as offensive spell.\n\nYour experiments left some strange effects within your body. Some are nice (you have unusually fast regeneration), some are strange (you can shift to incorporeality for a few seconds and even try to possess someone while in this state), and some brought more problems than benefits (insignificant improvement in magic power came with crippling penalty for your physical abilities).\n\nAlso, you are almost compulsive hoarder, so you developed ability to carry and store huge amount of things.\n\nNow you want to give your new body thorough test run, and portal to demon infested world looks appealing. No one said that common sense is one of your strong sides...\n\nTroublesome villagers near portal had strange demands about things which you can carry to other side, but you managed to conceal magic whip, so you wouldn't be unarmed, bud damned (literally) thing takes it's toll on user.\n\nYou still aren't really sure about your gender - having both sets doubles the fun, you still are a bit shy of your tentacles (that's main reason for your concealing clothes - your body is your doubtless masterpiece in all other parts), and being female in demon infested worlds tends to be a problem, so you decided to bring few transformative eggs, just in case.");
 		}
		
		private function customChimera():void {		
			// This one is sort of challenge character. It is supposed to be mage, at least at start.
			// always one vagina with random stats
			player.createVagina();
			player.vaginas[0].vaginalLooseness = rand(4); // from tight to gaping
			player.vaginas[0].vaginalWetness = rand(4)+1; // from normal to slavering
			player.vaginas[0].virgin = false;

			player.clitLength = rand(3) == 0 ? (rand(10)+1)*0.25 : 0.25; // from 0.25 to 2.5
			player.fertility = (rand(5)+1)*5; // from 5 to 25 with 5 step
			
			// 1-4 breast rows, from flats to dd sized
			var row:Number = 0;
			do{
			player.createBreastRow();
			var size:Number = 0;
			if(row==0)
				player.breastRows[row].breastRating = rand(6);
			else
				player.breastRows[row].breastRating = player.breastRows[row-1].breastRating - rand(2); // lower rows are same size or one size smaller than upper
			row++;
			}while(row < 4 && rand(2) == 0 && player.breastRows[0].breastRating > 1); // if last row was flat do not add more
						
			var tent:Boolean = rand(5) == 0; // 20% chance to have tentacle cluster
			var cocks:Number = rand(5)+(tent ? 4 : 2); // 2-6 mixed cocks
			var i:int; 
			for (i = 0; i < cocks; i++) 
			{
				player.createCock();
				player.cocks[i].cockLength = Math.round((rand(220)/10+3)*10)/10; // 3-25 inches
				player.cocks[i].cockThickness = Math.round((rand(player.cocks[i].cockLength)/10+1)*10)/10;
				var type:Number = rand(90);			
				if (tent)
					player.cocks[i].cockType = CockTypesEnum.TENTACLE;
				else if(type < 25) // high chance
					player.cocks[i].cockType = CockTypesEnum.HUMAN;
				else if(type < 30)
					player.cocks[i].cockType = CockTypesEnum.HORSE;
				else if(type < 40)
				{
					player.cocks[i].cockType = CockTypesEnum.DOG; // double chance, since it is fox one as well
					player.cocks[i].knotMultiplier = 1.4;
				}
				else if(type < 45)
					player.cocks[i].cockType = CockTypesEnum.DEMON;
				else if(type < 50)
					player.cocks[i].cockType = CockTypesEnum.CAT;
				else if(type < 60)
					player.cocks[i].cockType = CockTypesEnum.TENTACLE; // double chance, for no reason
				else if(type < 65)
					player.cocks[i].cockType = CockTypesEnum.LIZARD;
				else if(type < 70)
					player.cocks[i].cockType = CockTypesEnum.ANEMONE;
				else if(type < 75)
					player.cocks[i].cockType = CockTypesEnum.KANGAROO;
				else if(type < 80)
				{
					player.cocks[i].cockType = CockTypesEnum.DRAGON;
					player.cocks[i].knotMultiplier = 1.3;
				}
				else if(type < 85)
				{
					player.cocks[i].cockType = CockTypesEnum.DISPLACER;
					player.cocks[i].knotMultiplier = 1.5;
				}
				else
					player.cocks[i].cockType = CockTypesEnum.PIG;				
					
				if (player.cocks[i].knotMultiplier == 1 && rand(5) == 0)
					player.cocks[i].knotMultiplier = 1.2 + rand(9) / 10.;
			}
			
			
			// 40% to have no balls, 40% to one pair, 20% to 2 pairs
			var balls:Number = rand(5);
			if(balls <= 1){player.balls = 0;}
			else if(balls <= 3){player.balls = 2;}
			else if(balls == 4){player.balls = 4;}
			if(player.balls>0)player.ballSize = rand(4)+1;
			player.cumMultiplier = 5+player.ballSize*player.balls*2.5+rand(25);
			
			player.ass.analLooseness = rand(3);
			player.ass.analWetness = rand(3)+1;

			// lean build
			player.tallness = 47+rand(43); // 118-230 cm
			player.hips.type = Hips.RATING_BOYISH;
			player.butt.type = Butt.RATING_TIGHT;
			player.thickness = rand(10)+10; // lithe
			player.tone = rand(10)+10; // not in a good shape...
			player.skinTone = "light";
			player.hairColor = "black";
			player.hairLength = rand(50)+5;
			player.femininity = rand(30)+35;
			player.beardLength = 0;
			player.beardStyle = 0;
			
			// wrecked body and obsessed mind...
			player.str -= 15;
			player.tou -= 15;
			player.spe -= 15;
			player.inte += 60;
			//player.sens = 15;
			//player.lib = 15;
			player.cor += 2;

			var skin:Number = rand(100);			
			if(skin < 50){
				player.skin.restore(); // skin, 50%
			} else if(skin < 80){
				player.skin.growFur();// fur, 30%
			} else if(skin < 95){
				player.skin.growCoat(Skin.SCALES); // scales, 15%
			} else{
				player.skin.base.type = Skin.GOO; // goo, 5%
			}
					
			if(rand(3) != 0) // 2/3 to have human face
				player.faceType = Face.HUMAN;
			else // totally random one
				player.faceType = rand(20)+1; // since it is not a enum, it is impossible to make it auto-ajust...
				
			if(player.faceType == Face.SPIDER_FANGS && rand(2) == 0)
					player.eyes.type = Eyes.FOUR_SPIDER_EYES; // 50% to have spider eyes with spider fangs
			else if(rand(20) == 0) // 5% for inhuman eyes otherwise
				if(rand(2) == 0)
					player.eyes.type = Eyes.FOUR_SPIDER_EYES;
				else
					player.eyes.type = Eyes.BLACK_EYES_SAND_TRAP;

			if(player.faceType == Face.HUMAN && rand(2)!=0) // if human face, 50% to have human ears
				player.ears.type = Ears.HUMAN;
			else // totally random one
				player.ears.type = rand(14) + 1; // since it is not a enum, it is impossible to make it auto-ajust...


			if(rand(2) != 0) // 50% to have human lower body
				player.lowerBody = LowerBody.HUMAN;
			else // totally random one
			{
				player.lowerBody = rand(21) + 1; // since it is not a enum, it is impossible to make it auto-ajust...
				if (player.lowerBody == LowerBody.CENTAUR) {
					player.lowerBody = LowerBody.HOOFED;
					player.legCount = 4;
				}
				else if (player.lowerBody == LowerBody.DRIDER)
					player.legCount = 8;
				else if (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.GOO)
					player.legCount = 1;
				else if (rand(15) == 0)
					player.legCount = 4;
			}
			
			player.tailType = rand(21); // always have totally random tail
			if(player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN)
			{ // insect abdomens comes with poison
				player.tailVenom = 5;
				player.tailRecharge = 5;
				if(player.tailType == Tail.SPIDER_ADBOMEN && rand(2)==0)
					player.createPerk(PerkLib.SpiderOvipositor, 0, 0, 0, 0); // spider abdomen have chance 50/50 to have ovipositor
			}
			
			// 70% normal tongue, 30% to non-human with even chances of every one
			if(rand(100)<70)
				player.tongue.type = Tongue.HUMAN;
			else
				player.tongue.type = randomChoice(Tongue.DEMONIC, Tongue.DRACONIC, Tongue.SNAKE);
			
			
			var horns:Number = rand(100); // 70% no horns, 30% to random
			if(horns<70)
				player.horns.type = Horns.NONE;
			else if(horns<80){
				player.horns.type = Horns.DEMON;
				player.horns.count = (rand(4) + 1) * 2; // 1-4 pairs
				}
			else if(horns<90){
				player.horns.type = Horns.COW_MINOTAUR;
				player.horns.count = 2;}
			else{
				player.horns.type = Horns.DRACONIC_X2;
				player.horns.count = 2;}
			
			var wings:Number = rand(4); // always have wings to fly... small boon to make up for lack of fighting power
			if(wings == 0){
				player.wings.type = Wings.BAT_LIKE_LARGE;
				player.wings.desc = "large, bat-like";}
			else if(wings == 1){
				player.wings.type = Wings.FEATHERED_LARGE;
				player.wings.desc = "large, feathered";}
			else if(wings == 2){
				player.wings.type = Wings.DRACONIC_LARGE;
				player.wings.desc = "large, draconic";}
			else{
				player.wings.type = Wings.GIANT_DRAGONFLY;
				player.wings.desc = "giant dragonfly";}
				
			
			var arms:Number = rand(100); // if have harpy wings 33% chance to have harpy hands, otherwise 5% to have spider hands
			if(player.wings.type == Wings.FEATHERED_LARGE && rand(4) == 0)
				player.arms.type = Arms.HARPY;
			else if(rand(20) == 0)
				player.arms.type = Arms.SPIDER;
			else
				player.arms.type = Arms.HUMAN;
			
			
			// 90% to have normal hair, even chances to have feathers, anemone or goo otherwise
			if(rand(100) < 90)	player.hairType = Hair.NORMAL;
			else player.hairType = randomChoice(Hair.FEATHER, Hair.GOO, Hair.ANEMONE);
			
			// wizard staff and modest robes
			player.setWeapon(weapons.W_STAFF);
			player.setArmor(armors.M_ROBES);
			
			// have some perks from past
			player.createPerk(PerkLib.Smart, 1, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeScholar)) player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
			if (!player.hasPerk(PerkLib.PastLifeAlchemist)) player.createPerk(PerkLib.HistoryAlchemist, 0, 0, 0, 0);
			player.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			player.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			player.createPerk(PerkLib.SpellcastingAffinity, 50, 0, 0, 0);
			
			// and knows white magic
			player.createStatusEffect(StatusEffects.KnowsCharge,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
			player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);

			player.hoursSinceCum = 0;
			player.fatigue = 0;
			player.HP = EngineCore.maxHP();

			player.gems += 15+ rand(55);
			
			outputText("Your body is wrecked by your own experiments with otherworldly transformation items, and now you have no more money to buy any more from smugglers... But you would make your body as strong as your will. Or die trying.");
		}
		
	}

}