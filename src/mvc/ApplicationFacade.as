package mvc
{
	import mvc.controller.AddUserCommand;
	import mvc.controller.LoadLoginCommand;
	import mvc.controller.UpdateUserCommand;
	import mvc.model.UserProxy;
	import mvc.view.IndexMediator;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade
	{
		
		public function ApplicationFacade()
		{
			super();
		}
		//1.初始化MVC，并映射command与notification通信 
		override protected function initializeController():void{
			super.initializeController();
			//增删改查
			registerCommand(AddUserCommand.NAME,AddUserCommand);
			registerCommand(LoadLoginCommand.NAME,LoadLoginCommand);
			registerCommand(UpdateUserCommand.NAME,UpdateUserCommand);	
		}
		//2.实例化自己
		public static function getInstance():ApplicationFacade{
			if(instance==null){instance=new ApplicationFacade();}
			return instance as ApplicationFacade;
		}
		//3.启动pureMVC
		public function startup(view:Object):void{
			//向facade中注册Mediator 和 proxy
			if(this.retrieveProxy(UserProxy.NAME)==null)
				this.registerProxy(new UserProxy(UserProxy.NAME));
			if(this.retrieveMediator(IndexMediator.NAME)!=null)
				this.removeMediator(IndexMediator.NAME);
			this.registerMediator(new IndexMediator(IndexMediator.NAME,view));
			sendNotification(LoadLoginCommand.NAME,view);
		}
	}
}