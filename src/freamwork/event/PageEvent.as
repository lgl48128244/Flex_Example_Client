package freamwork.event
{
	import flash.events.Event;

	/**
	 * @author pengcl
	 * @date 2013/01
	 */
	
	public class PageEvent extends Event
	{
		public static const  PAGACHANGE:String="changePageEvent";
		
		public function PageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		private var _currentPage:int=0;
		
		private var _recordOfEveryPage:int =10;
		
		public function get currentPage():int{
			return _currentPage;
		}
		[Bindable]
		public function set currentPage(idata:int):void{
			_currentPage = idata;
		}
		public function get recordOfEveryPage():int{
			return _recordOfEveryPage;
		}
		[Bindable]
		public function set recordOfEveryPage(irecordOfEveryPage:int):void{
			_recordOfEveryPage=irecordOfEveryPage;
		}
		
	}
}