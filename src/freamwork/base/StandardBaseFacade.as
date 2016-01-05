package freamwork.base
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	/**
	 * @author pengcl
	 * @date 2013/01
	 */
    public class StandardBaseFacade extends Facade implements IFacade
    {

        public function StandardBaseFacade(key : String)
        {
			super();
        }
        override protected function initializeController():void
		{
			super.initializeController();
		}
    }
}