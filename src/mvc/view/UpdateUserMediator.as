package mvc.view
{
	import flash.events.MouseEvent;
	
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	
	import mvc.controller.LoadLoginCommand;
	import mvc.model.UserProxy;
	import mvc.model.vo.User;
	import mvc.view.components.Edit;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;


	public class UpdateUserMediator extends Mediator
	{
		public static const NAME:String = "UpdateUserMediator";
		private var editApp:Edit;
		public function UpdateUserMediator(viewComponent:Object=null)
		{
			super(UpdateUserMediator.NAME, viewComponent);
			 editApp = viewComponent as Edit;
			//重置
			editApp.reset_link.addEventListener(MouseEvent.CLICK,function click():void{
				var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
				var id:int = editApp.parentDocument.selectId;
				sp.findByID(id);
			});
			//修改事件
			editApp.edit_link.addEventListener(MouseEvent.CLICK,function click():void{
				if(editApp.nameID.text != "" && editApp.valued.text != ""){
					var user:User = new User();
					CursorManager.removeBusyCursor();
					editApp.info.text = "正在修改。。。";
					user.pk = int(editApp.pk.text);
					user.name = editApp.nameID.text;
					user.value = editApp.valued.text;
					//远程调用，查询用户详细
					var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
					sp.updateUser(user);	
				}else{
					editApp.info.text = "用户名和密码不能为空";
				}
			});
		}
		
		//列举监听事件
		override public function listNotificationInterests() : Array
		{ 
			return [
				UserProxy.findByID,
				UserProxy.UpdateUser
			]; 
		}
	
		//处理监听事件
		override public function handleNotification( note : INotification ) : void{
			switch (note.getName()){
				case UserProxy.findByID:
					var user:Object = note.getBody();		
					editApp.pk.text = user.pk;
					editApp.nameID.text = user.name;
					editApp.valued.text = user.value;
					break;
				case UserProxy.UpdateUser:
					PopUpManager.removePopUp(editApp);
					sendNotification(LoadLoginCommand.NAME,editApp);
					facade.removeMediator(UpdateUserMediator.NAME);
					break;
				default:
					break;
			}
		}
	}
}