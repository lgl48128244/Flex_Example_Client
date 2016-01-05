package mvc.controller
{
	import mvc.model.UserProxy;
	import mvc.view.IndexMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class StartUpCommand extends SimpleCommand implements ICommand
	{
		public static const NAME:String="StartUpCommand";
		override public function execute(notification:INotification):void
		{
			// TODO Auto Generated method stub
			//获取主程序mxml
			var app:index = notification.getBody() as index;
			
			//向facade中注册mvc
			facade.registerMediator(new IndexMediator(app));
			facade.registerProxy(new UserProxy());
			
			//增删改查
			facade.registerCommand(LoadLoginCommand.NAME,LoadLoginCommand);
			facade.registerCommand(AddUserCommand.NAME,AddUserCommand);
			facade.registerCommand(UpdateUserCommand.NAME,UpdateUserCommand);
			
			sendNotification(LoadLoginCommand.NAME,app);
		}
	}
}