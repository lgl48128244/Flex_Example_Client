package mvc.view
{
	import flash.events.MouseEvent;
	
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	
	import mvc.controller.LoadLoginCommand;
	import mvc.model.UserProxy;
	import mvc.model.vo.User;
	import mvc.view.components.Add;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class AddUserMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "AddUserMediator";
		private var insertApp:Add;
		public function AddUserMediator(viewComponent:Object=null)
		{
			super(AddUserMediator.NAME, viewComponent);
			 insertApp = viewComponent as Add;
			
			//添加事件
			insertApp.sbumitButton.addEventListener(MouseEvent.CLICK,function click():void{
				if(insertApp.nameID.text != "" && insertApp.valued.text != ""){
					var user:User = new User();
					CursorManager.removeBusyCursor();
					insertApp.info.text = "正在添加。。。";
					user.name = insertApp.nameID.text;
					user.value = insertApp.valued.text;
					var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
					sp.logAdd(user);
				}else{
					insertApp.info.text = "用户名和密码不能为空";
				}
			});
		}
		
		//列举监听事件
		override public function listNotificationInterests() : Array
		{ 
			return [
				UserProxy.AddUser
			]; 
		}
		//处理监听事件
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case UserProxy.AddUser:
				{
					PopUpManager.removePopUp(insertApp);
					facade.removeMediator(AddUserMediator.NAME);
					sendNotification(LoadLoginCommand.NAME,insertApp.parentDocument as index);
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}