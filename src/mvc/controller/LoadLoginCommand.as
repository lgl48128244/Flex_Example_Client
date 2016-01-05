package mvc.controller
{
	import mvc.model.UserProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadLoginCommand extends SimpleCommand implements ICommand
	{
		public static const NAME:String = "LoadLoginCommand";
		
		override public function execute(notification:INotification):void{
			var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			sp.list();
		}
	}
}