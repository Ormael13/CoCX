/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.SceneLib;
import classes.PerkLib;

import coc.xlogic.ExecContext;

public class StoryContext extends ExecContext{
	public var game:CoC;
	public function StoryContext(game:CoC) {
		super([
			game,
			CoC,
			{
				Appearance:Appearance,
				CockTypesEnum:CockTypesEnum,
				kFLAGS:kFLAGS,
				kGAMECLASS:CoC.instance,
				Math:Math,
                PerkLib:PerkLib,
				SceneLib:SceneLib,
				Skin:Skin
			}
		]);
		this.game = game;
	}
}
}
