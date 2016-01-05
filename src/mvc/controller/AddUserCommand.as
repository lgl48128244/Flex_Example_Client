package mvc.controller
{
	import mx.managers.PopUpManager;
	
	import mvc.view.AddUserMediator;
	import mvc.view.components.Add;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class AddUserCommand extends SimpleCommand implements ICommand
	{
		public static const NAME:String="AddUserCommand";
		override public function execute(notification:INotification):void
		{
			//新建添加窗口
			var i:Add = new Add();
			var indexApp:index = notification.getBody() as index;
			PopUpManager.addPopUp(i,indexApp,true);
			PopUpManager.centerPopUp(i);
			facade.registerMediator(new AddUserMediator(i));
		}
	}
}