package freamwork.base
{
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;


	/**
	 * @author pengcl
	 * @date 2013/01
	 */
    public class MulticoreBaseFacade extends Facade implements IFacade
    {

		public function MulticoreBaseFacade(key : String)
		{
			super(key);
		}
        override protected function initializeController():void
		{
			super.initializeController();
		}
    }
}