package freamwork.base
{

	import freamwork.event.DispatchEvent;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	
	/**
	 * @author pengcl
	 * @date 2013/01
	 */
	
	public class MulticoreBaseMediator extends Mediator implements IMediator
	{
		public var dispatcher:DispatchEvent;

		public function MulticoreBaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			dispatcher=DispatchEvent.getInstance();
		}
	}
}