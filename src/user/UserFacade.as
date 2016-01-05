package user
{
	import freamwork.base.StandardBaseFacade;
	
	import user.controller.UserCommand;
	import user.model.UserProxy;
	import user.view.UserMediator;

	public class UserFacade extends StandardBaseFacade
	{
		public static const NAME:String="UserFacade";
		
		public static const USER_COMMAND:String="user_command";
		public static const USER_SEARCH:String="user_search";
		public static const USER_ADD:String="user_add";
		public static const USER_DEL:String="user_del";
		public static const USER_DELMORE:String="user_delmore";
		public static const USER_UPDATE:String="user_update";
		
		public function UserFacade(key:String){
			super(key);
		}
		override protected function initializeController():void
		{
			// TODO Auto Generated method stub
			super.initializeController();
			//把UserCommand 与 常量绑定
			registerCommand(USER_COMMAND,UserCommand);
			
		}
		//单例获得父类instanceMap里的IndexFacade对象
		public static function getInstance(key:String):UserFacade{
			if (instance==null)
				instance=new UserFacade(key);
			return  UserFacade(instance); 
		}
		
		//pengcl 2.7 add 第二次打开时 facade已注册了ProductMediator.NAME，不会调用 onRegister() 导致所有监听的事件失效
		public function startup(view:Object):void{
			this.registerProxy(new UserProxy(UserProxy.NAME));
			this.removeMediator(UserMediator.NAME);
			this.registerMediator(new UserMediator(UserMediator.NAME,view));
		}
		/*public function startup(view:Object):void
		{
			if(this.retrieveProxy(UserProxy.NAME)==null)
				this.registerProxy(UserProxy.getInstance(UserProxy.NAME));
			if(this.retrieveMediator(UserMediator.NAME)!=null)
				this.removeMediator(UserMediator.NAME);
			this.registerMediator(new UserMediator(UserMediator.NAME,view));
			
			var objectPara:Object=new Object();
			objectPara.pageSize=17;
			objectPara.pageNo=0;
			sendNotification(UserFacade.USER_COMMAND,objectPara,UserFacade.USER_SEARCH);//初始化查询
		}*/
	}
}