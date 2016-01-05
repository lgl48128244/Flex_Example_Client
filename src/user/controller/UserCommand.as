package user.controller
{
	
	import mx.collections.ArrayCollection;
	
	import freamwork.base.StandardBaseCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import user.UserFacade;
	import user.model.UserProxy;
	import user.model.vo.UserVO;

	public class UserCommand extends StandardBaseCommand
	{
		private var userProxy:UserProxy
		public function UserCommand(){
			super();
		}
		override public function execute(notification:INotification):void
		{
			userProxy=facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			var type:String=notification.getType();	
			var userVO:UserVO;
			switch(type){
				case UserFacade.USER_SEARCH:
					var objectPara:Object = notification.getBody() as Object;
					userProxy.getSearchUserList(objectPara);
					break;	
				case UserFacade.USER_DELMORE:
					var userIds:ArrayCollection = notification.getBody() as ArrayCollection;
					userProxy.delMoreUser(userIds);
					break;	
				case UserFacade.USER_DEL:
					var userId:int = notification.getBody() as int;
					userProxy.delUser(userId);
					break;	
				case UserFacade.USER_ADD:
					userVO = notification.getBody() as UserVO;
					userProxy.userAdd(userVO);
					break;	
				case UserFacade.USER_UPDATE:
					userVO = notification.getBody() as UserVO;
					userProxy.userUpdate(userVO);
					break;	
				default: 
					break;
			}
		}
	}
}