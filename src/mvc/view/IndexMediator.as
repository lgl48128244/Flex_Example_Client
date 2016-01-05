package mvc.view
{
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import mvc.controller.AddUserCommand;
	import mvc.controller.LoadLoginCommand;
	import mvc.controller.UpdateUserCommand;
	import mvc.model.UserProxy;
	import mvc.model.vo.User;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class IndexMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "IndexMediator";
		private var indexApp:index;
		public function IndexMediator(name:String=null,viewComponent:Object=null)
		{
			super(IndexMediator.NAME, viewComponent);
			 indexApp = viewComponent as index;
			//刷新
			indexApp.refresh.addEventListener(MouseEvent.CLICK,function click():void{
				indexApp.info.text="刷新成功";
				sendNotification(LoadLoginCommand.NAME,indexApp);
			});
			

			//增加操作
			indexApp.add.addEventListener(MouseEvent.CLICK,function click():void{
				sendNotification(AddUserCommand.NAME,indexApp);
			});
			//修改操作
			indexApp.editButton.addEventListener(MouseEvent.CLICK,function click():void{
				sendNotification(UpdateUserCommand.NAME,indexApp);
			});
			
			//执行删除操作事件
			indexApp.deleteButton.addEventListener(MouseEvent.CLICK,function click():void{
				if(indexApp.selectId==0){
					Alert.show("请选择要删除的信息!");
				}else{
					Alert.show("你确定该条数据吗？","删除提示",Alert.OK|Alert.NO,indexApp,function alert(e:CloseEvent):void{
						//如果点击Cancel则不执行任何操作，否则执行删除操作
						if(e.detail == Alert.OK){
							//调用删除方法
							var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
							sp.deleteByPK(indexApp.selectId);
							indexApp.info.text="删除"+indexApp.dg.selectedItem.name+"成功";
							Alert.show("删除"+indexApp.dg.selectedItem.name+"成功");
						}
					},null,Alert.YES);
				}
			});
			
			//打开详细操作事件
			indexApp.detail.addEventListener(MouseEvent.CLICK,function click():void{
				//注册详细页面View层
				//facade.registerMediator(new LoginDetailMediator(d));
				
				//远程调用，查询用户详细
				var selectId:int = indexApp.selectId;
				var sp:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
				sp.findByID(selectId);
			});
		}
		
		//列举监听事件
		override public function listNotificationInterests():Array
		{
			// TODO Auto Generated method stub
			return [ 
				UserProxy.list,
				UserProxy.DelUser,
				UserProxy.findByID
			]; 
		}
		
		override public function handleNotification(notification:INotification):void
		{
			// TODO Auto Generated method stub
			//处理监听事件
			switch (notification.getName()){
				case UserProxy.list:
					indexApp.obj = notification.getBody() as ArrayCollection;
					break;
				case UserProxy.DelUser:
					sendNotification(LoadLoginCommand.NAME,indexApp);
					break;
				case UserProxy.findByID:
					var user:User = notification.getBody() as User;		
					indexApp.dg.selectedItem.pk = user.pk;
					indexApp.dg.selectedItem.name= user.name;
					indexApp.dg.selectedItem.value = user.value;
					break;
				default:
					break;
			}
		}
	}
}


