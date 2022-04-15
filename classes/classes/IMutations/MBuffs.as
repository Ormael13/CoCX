package classes.IMutations {
    import classes.BaseContent;
    public class MBuffs extends BaseContent{
        public function MBuffs() {
        }
        //Arachnid Book Lung
        public static function ABLM(pTier:int = 0):Object{
            var pBuffs:Object = {};
            pBuffs['int.mult'] = 0.05 * pTier;
            return pBuffs
        }

        //Kitsune Thyroid Glands
        public static function KTGM(pTier:int = 0):Object{
            var pBuffs:Object = {};
            pBuffs['spe.mult'] = 0.05 * pTier;
            if (pTier - 1 >= 0) pBuffs['wis.mult'] = 0.05 * (pTier - 1);
            if (pTier - 2 >= 0) pBuffs['int.mult'] = 0.05 * (pTier - 1);
            return pBuffs
        }
    }
}
