package freamwork.event
{
	import flash.events.Event;
	
	/**
	 * @author pengcl
	 * @date 2013/01
	 */
	
	public class TreeEvent extends Event
	{
		public static const LOADOVER:String="loadover";
		public function TreeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}