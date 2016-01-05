package user.model
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import freamwork.base.StandardBaseProxy;
	
	import user.UserFacade;
	import user.model.vo.UserVO;

	public class UserProxy extends StandardBaseProxy
	{
		public static const NAME:String="UserProxy";
		
		public function UserProxy(proxyName:String=null, data:Object=null){
			super(proxyName,data);
			romoteBean.destination="userService";
		}
		
		//按钮查询
		public function getSearchUserList(objectPara:Object):void{
			romoteBean.getSearchUserList(objectPara.pageNo,objectPara.pageSize,objectPara.uname,objectPara.nickname);
			romoteBean.getSearchUserList.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserFacade.USER_SEARCH,event.result);
			});
		}
		//增加信息
		public function userAdd(user:UserVO):void{
			romoteBean.save(user);
			romoteBean.save.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserFacade.USER_ADD,event.result);
			});
		}
		//更新操作
		public function userUpdate(user:UserVO):void{
			romoteBean.update(user);
			romoteBean.update.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserFacade.USER_UPDATE,event.result);
			});
		}
		//删除(多)操作
		public function delMoreUser(ids:ArrayCollection):void{
			romoteBean.delMoreUser(ids);
			romoteBean.delMoreUser.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserFacade.USER_DELMORE,event.result);
			});
		}
		//删除(单)操作
		public function delUser(id:int):void{
			romoteBean.delUser(id);
			romoteBean.delUser.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserFacade.USER_DEL,event.result);
			});
		}
		
		//更新前查询
		public function findByID(pk:int):void{
			romoteBean.findByID(pk);
			romoteBean.addEventListener(ResultEvent.RESULT,function callback(event:ResultEvent):void{
				sendNotification(UserFacade.USER_UPDATE,event.result as UserVO);
			});
		}
		//执行更新操作
		public function updateUser(user:UserVO):void{
			romoteBean.update(user);
			romoteBean.addEventListener(ResultEvent.RESULT,function callback():void{
				sendNotification(UserFacade.USER_UPDATE);
			});
		}
		
		private static var instance:UserProxy;
		public static function getInstance(key:String):UserProxy{
			if(instance==null){
				instance=new UserProxy(key);
			}
			return instance;
		}
	}
}