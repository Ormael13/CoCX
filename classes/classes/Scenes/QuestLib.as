package classes.Scenes {
import classes.BaseContent;
import classes.Scenes.API.AbstractQuest;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Scenes.Quests.FactoryQuest;
import classes.Scenes.Quests.SimpleGuildQuest;
import classes.Scenes.Quests.ZetazQuest;
import classes.StatusEffects;

public class QuestLib extends BaseContent {
	
	// Quest groups
	public static const QGRP_MAIN:String   = "Main";
	public static const QGRP_SIDE:String   = "Side";
	public static const QGRP_AGUILD:String = "Adv. Guild";
	public static const QGRP_OTHER:String  = "Other";
	
	// Main quets
	public const MQ_Factory:FactoryQuest = new FactoryQuest();
	public const MQ_Zetaz:ZetazQuest = new ZetazQuest();
	
	// Adv. Guild quests
	
	public const AGQ_Imps:SimpleGuildQuest      =
						 new SimpleGuildQuest(
								 "AGQ_Imps",
								 "Imps Hunt",
								 AdventurerGuild.RANK_COPPER,
								 useables.IMPSKLL,[3, 4, 5],
								 StatusEffects.AdventureGuildQuests1,1
						 );
	public const AGQ_Demons:SimpleGuildQuest    =
						 new SimpleGuildQuest(
								 "AGQ_Demons",
								 "Demons Hunt",
								 AdventurerGuild.RANK_IRON,
								 useables.DEMSKLL,[1, 2, 3],
								 StatusEffects.AdventureGuildQuests1,2
						 );
	public const AGQ_Minotaurs:SimpleGuildQuest =
						 new SimpleGuildQuest(
								 "AGQ_Minotaurs",
								 "Minotaurs Hunt",
								 AdventurerGuild.RANK_COPPER,
								 useables.MINOHOR,[2, 3, 4],
								 StatusEffects.AdventureGuildQuests1,3
						 );
	public const AGQ_FeralImps:SimpleGuildQuest =
						 new SimpleGuildQuest(
								 "AGQ_FeralImps",
								 "Feral Imps Hunt",
								 AdventurerGuild.RANK_COPPER,
								 useables.FIMPSKL,[3, 4, 5],
								 StatusEffects.AdventureGuildQuests2,2
						 );
	public const AGQ_FeralTB:SimpleGuildQuest   =
						 new SimpleGuildQuest(
								 "AGQ_FeralTB",
								 "Feral Tentacle Beasts Hunt",
								 AdventurerGuild.RANK_COPPER,
								 useables.SEVTENT, [1, 2, 3],
								 StatusEffects.AdventureGuildQuests2, 1
						 );
	public const AGQ_Gel:SimpleGuildQuest       =
						 new SimpleGuildQuest(
								 "AGQ_Gel",
								 "Green Gel Gathering",
								 AdventurerGuild.RANK_COPPER,
								 useables.GREENGL, [5, 5],
								 StatusEffects.AdventureGuildQuests4, 2
						 );
	public const AGQ_Chitin:SimpleGuildQuest    =
						 new SimpleGuildQuest(
								 "AGQ_Chitin",
								 "Black Chitin Gathering",
								 AdventurerGuild.RANK_COPPER,
								 useables.B_CHITN, [5, 5],
								 StatusEffects.AdventureGuildQuests4, 1
						 );
	
	public function allQuests(group:String=null):/*AbstractQuest*/Array {
		if (group != null) {
			return AbstractQuest.ALL_QUESTS_LIST.filter(function (q:AbstractQuest, i:*, j:*):Boolean {
				return q.group == group;
			});
		} else {
			return AbstractQuest.ALL_QUESTS_LIST.slice();
		}
	}
	public function allKnownQuests(group:String=null):/*AbstractQuest*/Array {
		if (group != null) {
			return AbstractQuest.ALL_QUESTS_LIST.filter(function (q:AbstractQuest, i:*, j:*):Boolean {
				return q.group == group && q.isKnown;
			});
		} else {
			return AbstractQuest.ALL_QUESTS_LIST.filter(function (q:AbstractQuest, i:*, j:*):Boolean {
				return q.isKnown;
			});
		}
	}
	
	public function QuestLib() {
	}
}
}
