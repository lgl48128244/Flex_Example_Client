package freamwork.base
{

	import freamwork.event.DispatchEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * @author pengcl
	 * @date 2013/01
	 */
	
	public class StandardBaseMediator extends Mediator implements IMediator
	{
		public var dispatcher:DispatchEvent;

		public function StandardBaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			dispatcher=DispatchEvent.getInstance();
		}
	}
}