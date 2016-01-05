package freamwork.event
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author pengcl
	 * @date 2013/01
	 */
	
	public class DispatchEvent extends EventDispatcher
	{
		public function DispatchEvent(target:IEventDispatcher=null)
		{
			super(target);
		}
		private static var instant:DispatchEvent;
		public static function getInstance():DispatchEvent
		{
			if (instant == null)
			{
				instant = new DispatchEvent();
			}
			return instant;
		}
	}
}