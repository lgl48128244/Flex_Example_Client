package mvc.model
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import mvc.model.vo.User;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class UserProxy extends Proxy implements IProxy
	{
		public static const DATA_FAILED:String = 'loginFailed';
		public static const NAME:String = 'UserProxy';
		public function UserProxy(data:Object=null)
		{
			super(UserProxy.NAME, data);
		}
		
		//初始化页面信息
		public static const list:String="list";
		public function list():void{
		    var remote:RemoteObject = new RemoteObject();
			remote.destination = "logDAO";
			remote.list();
			remote.addEventListener(FaultEvent.FAULT,onFault);
			remote.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserProxy.list,event.result as ArrayCollection);
			});
		}
		
		
		//增加信息
		public static const AddUser:String="AddUser";
		public function logAdd(user:User):void{
			var remote:RemoteObject = new RemoteObject();
			remote.destination = "logDAO";
			remote.addLog(user);
			remote.addEventListener(FaultEvent.FAULT,onFault);
			remote.addEventListener(ResultEvent.RESULT,function callback():void{
				sendNotification(UserProxy.AddUser);
			});
		}
		//删除操作
		public static const DelUser:String="DelUser";
		public function deleteByPK(pk:int):void{
			var remote:RemoteObject = new RemoteObject();
			remote.destination = "logDAO";
			remote.deleteByPK(pk);
			remote.addEventListener(FaultEvent.FAULT,onFault);
			remote.addEventListener(ResultEvent.RESULT,function callback():void{
				sendNotification(UserProxy.DelUser);
			});
		}
		//更新前查询
		public static const findByID:String="findByID";
		public function findByID(pk:int):void{
			var remote:RemoteObject = new RemoteObject();
			remote.destination = "logDAO";
			remote.findByID(pk);
			remote.addEventListener(FaultEvent.FAULT,onFault);
			remote.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserProxy.findByID,event.result as User);
			});
		}
		//执行更新操作
		public static const UpdateUser:String="UpdateUser";
		public function updateUser(user:User):void{
			var remote:RemoteObject = new RemoteObject();
			remote.destination = "logDAO";
			remote.updateLog(user);
			remote.addEventListener(FaultEvent.FAULT,onFault);
			remote.addEventListener(ResultEvent.RESULT,function callback():void{
				sendNotification(UserProxy.UpdateUser);
			});
		}
		protected function onFault(event:FaultEvent):void
		{
			// TODO Auto-generated method stub
			sendNotification(UserProxy.DATA_FAILED);
		}
	}
}