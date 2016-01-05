package mvc.controller
{
	import mx.managers.PopUpManager;
	
	import mvc.model.UserProxy;
	import mvc.view.UpdateUserMediator;
	import mvc.view.components.Edit;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class UpdateUserCommand extends SimpleCommand implements ICommand 
	{
		public static const NAME:String ="UpdateUserCommand";
		override public function execute(notification:INotification):void
		{
			//弹出编辑窗口
			var e:Edit = new Edit();
			var indexApp:index = notification.getBody() as index;
			PopUpManager.addPopUp(e,indexApp,true);
			PopUpManager.centerPopUp(e);
			facade.registerMediator(new UpdateUserMediator(e));

			//远程调用，查询用户详细
			var id:int = indexApp.dg.selectedItem.pk;
			var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			sp.findByID(id);
		}
	}
}