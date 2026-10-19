package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.internals.*;

public class ElderDryad extends Dryad
	{
		
	public function ElderDryad() 
	{
		this.a = "the ";
		this.short = "corrupted elder dryad";
        this.imageName = "dryad";
		this.long = "The elder dryad before you is brimming with corruption, her hair is composed of dark chocolate brown leaves. Her skin looks to be made of corrupted wood, especially her fingers which are shaped like sharp long claws. Her clothing is nothing more than leaves and straw put into a gown. Her eyes are a deep and hungry dark red. Her bark-like skin seeps a thick pink substance.";
		this.magicuser = true;
        this.createStatusEffect(StatusEffects.BonusVCapacity, 50, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("D"));
        this.createStatusEffect(StatusEffects.BonusACapacity, 40, 0, 0, 0);
        this.tallness = 120;
        this.hairColor = "dark chocolate brown";
        this.hairLength = 8;
        initStrTouSpeInte(209, 157, 141, 221);
        initWisLibSensCor(143, 411, 270, 90);
        this.weaponAttack = 175;
        this.armorDef = 320;
		this.armorMDef = 40;
        this.bonusHP = 1700;
		this.bonusLust = 733;
        this.level = 52;
        this.gems = rand(5) + 50;
		this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
		checkMonster();
	}
}
}
