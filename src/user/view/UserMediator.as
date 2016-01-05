package user.view
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.registerClassAlias;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import freamwork.base.StandardBaseMediator;
	import freamwork.checkbox.CheckBoxRender;
	import freamwork.event.PageEvent;
	
	import org.puremvc.as3.interfaces.INotification;
	
	import user.UserFacade;
	import user.model.vo.UserVO;
	import user.view.components.Add;
	import user.view.components.Edit;
	
	public class UserMediator extends StandardBaseMediator
	{
		public static const NAME:String = "IndexMediator";
		private var userApp:user;
		private var currentNo:int;
		private var userTitleWindow:Add;
		private var edit:Edit;
		private var flag:Boolean = false;
		public function UserMediator(name:String=null,viewComponent:Object=null)
		{
			super(UserMediator.NAME, viewComponent);
			 userApp = viewComponent as user;
		}
		
		override public function onRegister():void
		{
			this.userApp.add.addEventListener(MouseEvent.CLICK,addUser);//添加按鈕
			this.userApp.del.addEventListener(MouseEvent.CLICK,delUser);//刪除按鈕
			this.userApp.deleteFunction=deleteHandler;//删除
			this.userApp.updateFunction=updateHandler;//更新
			this.userApp.page.addEventListener(PageEvent.PAGACHANGE,changePageHandler);//分页
			this.userApp.refresh.addEventListener(MouseEvent.CLICK,refreshHandler);//刷新按钮
			this.userApp.searchButton.addEventListener(MouseEvent.CLICK,searchButtonHandler);//查询按钮
			query();//初始化页面
			registerClassAlias("com.ctvit.flex.model.User",UserVO);
		}
		
		private function query():void{
			var queryCond:Object=new Object();

			if(userApp.userName.text != ""){
				queryCond.uname = userApp.userName.text;
			}
			
			if(userApp.realName.text != ""){
				queryCond.nickname = userApp.realName.text;
			}
			queryCond.pageNo = userApp.page.currentPage * userApp.page.pageSize;
			queryCond.pageSize = userApp.page.pageSize;
			this.sendNotification(UserFacade.USER_COMMAND,queryCond,UserFacade.USER_SEARCH);//初始化查询
		}
		
		/**
		 * 详情
		 */
		protected function detailUser(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		/**
		 * 搜索按钮
		 */
		protected function searchButtonHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			/*var objectPara:Object=new Object();
			objectPara.pageSize=userApp._pageSize;
			objectPara.pageNo=0;
			objectPara.uname=userApp.userName.text;
			objectPara.nickname=userApp.realName.text;
			sendNotification(UserFacade.USER_COMMAND,objectPara,UserFacade.USER_SEARCHBUTTON);*///初始化查询
			
			userApp.page.currentPage = 0;
			query();
		}
		/**
		 * 初始化
		 */
		protected function changePageHandler(event:PageEvent):void
		{
			// TODO Auto-generated method stub
			/*var objectPara:Object=new Object();
			objectPara.pageSize=userApp._pageSize;
			objectPara.pageNo=this.userApp.page.currentPage*this.userApp._pageSize;
			sendNotification(UserFacade.USER_COMMAND,objectPara,UserFacade.USER_SEARCH);*///初始化查询
			query();
		}
		
		private function refreshHandler(event:MouseEvent):void{
			/*当前查询结果集刷新*/
			/*userApp.page.currentPage = 0;
			userApp.page.nsPageNum.value = 1;
			query();*/
			
			/*全局刷新*/
			userApp.userName.text="";
			userApp.realName.text="";
			userApp.page.pageSize=userApp._pageSize;
			userApp.page.currentPage=0;
			query();
		}
		/**
		 * 更新操作
		 */
		private function updateHandler(userVO:UserVO):void{
			edit = PopUpManager.createPopUp(Application.application as Sprite,Edit,true,null) as Edit;
			edit.height=400;
			edit.width=330;
			PopUpManager.centerPopUp(edit);
			
			edit.ID.text = String(userVO.id);
			trace(edit.ID.text);
			edit.uname.text = userVO.uname;
			edit.pwd.text = userVO.pwd;
			edit.pwd2.text = userVO.pwd;
			edit.nickname.text = userVO.nickname;
			edit.email.text = userVO.email;
			edit.power.text = userVO.power;
			edit.teacherid.text = userVO.teacherid;
		   //edit.createTime.text=String(userVO.createTime);
		   //edit.updateTime.text=String(userVO.updateTime);
			edit.sbumitButton.addEventListener(MouseEvent.CLICK,updateSaveHandler);
			edit.addEventListener(CloseEvent.CLOSE,closeHandler1);
		}
		
		protected function closeHandler1(event:CloseEvent):void
		{
			// TODO Auto-generated method stub
			PopUpManager.removePopUp(edit);
		}
		
		private function updateSaveHandler(event:MouseEvent):void
		{
			if(!flag&&edit.pwd.text != edit.pwd2.text){
				Alert.show("两次输入密码不一致!");
				return;
			}
			var reg:RegExp = /^([a-z0-9A-Z]+[-|\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$/;
			if(edit.email.text != ""&&!reg.test(edit.email.text)){
				Alert.show("邮箱格式不正确!");
				return;
			}
			if(edit.power.text.length>3){
				Alert.show("权限长度为3个字符，请重新输入!");
				return;
			}
			if(edit.pwd.text == ""){
				Alert.show("密码不能为空!");
			}else{
				var newUserVO:UserVO = new UserVO;
				newUserVO.id = Number(edit.ID.text);//ID
				newUserVO.uname = edit.uname.text;//用户名
				newUserVO.pwd = edit.pwd.text;//密码
				newUserVO.nickname = edit.nickname.text;//网络昵称
				newUserVO.email = edit.email.text;//电子邮件
				newUserVO.power=edit.power.text;//权限
				newUserVO.teacherid = edit.teacherid.text;//教师ID
				//newUserVO.createTime=DateFormatter.parseDateString(edit.createTime.text);//创建时间
				//newUserVO.updateTime=DateFormatter.parseDateString(edit.updateTime.text);//更新时间
				this.sendNotification(UserFacade.USER_COMMAND,newUserVO,UserFacade.USER_UPDATE);
				PopUpManager.removePopUp(edit);
			}
		}
		/**
		 * 多项删除操作 
		 */
		private function delUser(event:MouseEvent):void{//删除
			var selectItems:ArrayCollection=CheckBoxRender.selectArray(userApp.dg);
			if(selectItems==null || selectItems.length==0){
				Alert.show("请选择要删除的项","提示");
				return;
			}
			var userIdArray:ArrayCollection=new ArrayCollection();
			for each(var item:Object in selectItems){
				userIdArray.addItem(item.id);
			}
			Alert.show("确定要删除吗？","删除",Alert.YES|Alert.NO,null,function(event:CloseEvent):void{
				if(event.detail == Alert.YES){
					sendNotification(UserFacade.USER_COMMAND,userIdArray,UserFacade.USER_DELMORE);
				}
			});
		}
		/**
		 * 删除
		 */
		private function deleteHandler(userId:int):void{
			var userIds:int = userId;
			var userVO:UserVO = userApp.dg.selectedItem as UserVO;
			if(userVO.uname == "admin"){
				Alert.show("admin用户不允许删除!");
				return;
			}
			Alert.show("确定要删除吗？","删除",Alert.YES|Alert.NO,null,function(event:CloseEvent):void{
				if(event.detail == Alert.YES){
					sendNotification(UserFacade.USER_COMMAND,userIds,UserFacade.USER_DEL);
				}
			});
		}
		
		/**
		 * 添加操作
		 */
		protected function addUser(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			userTitleWindow = PopUpManager.createPopUp(Application.application as Sprite,Add,true,null) as Add;
			userTitleWindow.height=380;
			userTitleWindow.width=330;
			PopUpManager.centerPopUp(userTitleWindow);
			userTitleWindow.sbumitButton.addEventListener(MouseEvent.CLICK,saveHandler);
			userTitleWindow.addEventListener(CloseEvent.CLOSE,closeHandler2);
		}		
		
		private function closeHandler2(event:CloseEvent):void
		{
			PopUpManager.removePopUp(userTitleWindow);
		}
		
		private function saveHandler(event:MouseEvent):void
		{
			if(!flag&&userTitleWindow.pwd.text != userTitleWindow.pwd2.text){
				Alert.show("两次输入密码不一致!");
				return;
			}
			var reg:RegExp = /^([a-z0-9A-Z]+[-|\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$/;
			if(userTitleWindow.email.text != ""&&!reg.test(userTitleWindow.email.text)){
				Alert.show("邮箱格式不正确!");
				return;
			}
			if (userTitleWindow.power.text=="") 
			{
				Alert.show("权限不能为空");	
				return;
			}
			if(userTitleWindow.power.text.length > 3 && userTitleWindow.power.length < 3){
				Alert.show("权限长度为3个字符，请重新输入!");
				return;
			}
			if (userTitleWindow.nickname.text=="") 
			{
				Alert.show("网络昵称不能为空");	
				return;
			}
			if (userTitleWindow.teacherid.text=="") 
			{
				Alert.show("教师ID不能为空");
				return;
			}
			if (userTitleWindow.email.text=="") 
			{
			 	Alert.show("邮箱不能为空");	
				return;
			}
			if(userTitleWindow.uname.text == "" || userTitleWindow.pwd.text == ""){
				Alert.show("用户名或密码不能为空!");
				return;
			}else{
				var newUserVO:UserVO = new UserVO;
				newUserVO.uname = userTitleWindow.uname.text;//用户名
				newUserVO.pwd = userTitleWindow.pwd.text;//密码
				newUserVO.nickname = userTitleWindow.nickname.text;//网络昵称
				newUserVO.email = userTitleWindow.email.text;//电子邮件
				newUserVO.power=userTitleWindow.power.text;//权限
				newUserVO.teacherid = userTitleWindow.teacherid.text;//教师ID
				//newUserVO.createTime=DateFormatter.parseDateString(userTitleWindow.createTime.text);//创建时间
				//newUserVO.updateTime=DateFormatter.parseDateString(userTitleWindow.updateTime.text);//更新时间
				this.sendNotification(UserFacade.USER_COMMAND,newUserVO,UserFacade.USER_ADD);
				PopUpManager.removePopUp(userTitleWindow);
			}
		}
		
		//列举监听事件
		override public function listNotificationInterests():Array
		{
			// TODO Auto Generated method stub
			return [ 
				UserFacade.USER_DEL,
				UserFacade.USER_ADD,
				UserFacade.USER_UPDATE,
				UserFacade.USER_SEARCH,
				UserFacade.USER_DELMORE
			]; 
		}
		
		override public function handleNotification(notification:INotification):void
		{
			// TODO Auto Generated method stub
			//处理监听事件
			switch (notification.getName()){
				case UserFacade.USER_SEARCH:
					var searchObject:Object=notification.getBody();
					var resultList:ArrayCollection =searchObject.result as ArrayCollection;
					var totalRows:int=currentNo=searchObject.totalRows as int;
					this.userApp.page.totalRows=totalRows;
					this.userApp.dg.dataProvider=resultList;	
					break;
				case UserFacade.USER_DEL:
					var userDelResult:int = notification.getBody() as int;
					var userVO:UserVO = userApp.dg.selectedItem as UserVO;
					if(userDelResult >0){
						Alert.show("删除["+userVO.nickname+"]成功。","提示");
						//pageSearch(0);
					}else{
						Alert.show("删除用户出错。","提示");
					}
					query();
					break;
				case UserFacade.USER_DELMORE:
					var userDel:int = notification.getBody() as int;
					if(userDel >0){
						Alert.show("删除成功。","提示");
						//pageSearch(0);
					}else{
						Alert.show("删除用户出错。","提示");
					}
					query();
					break;
				case UserFacade.USER_UPDATE:
					var update:int = notification.getBody() as int;
					if(update >0){
						Alert.show("操作成功。","提示");
						//this.pageSearch(0);
					}else{
						Alert.show("更新用户出错。","提示");
					}
					query();
					break;
				case UserFacade.USER_ADD:
					var result:int = notification.getBody() as int;
					if(result == 1){
						Alert.show("操作成功。","提示");
						//this.pageSearch(0);
					}else{
						Alert.show("添加用户出错。","提示");
					}
					query();
					break;
				default:
					break;
			}
		}
		
		override public function onRemove():void
		{
			// TODO Auto Generated method stub
			this.userApp.add.removeEventListener(MouseEvent.CLICK,addUser);//添加按鈕
			this.userApp.del.removeEventListener(MouseEvent.CLICK,delUser);//刪除按鈕
			this.userApp.page.removeEventListener(PageEvent.PAGACHANGE,changePageHandler);//分页
			this.userApp.searchButton.removeEventListener(MouseEvent.CLICK,searchButtonHandler);//查询按钮
			this.userApp.refresh.removeEventListener(MouseEvent.CLICK,refreshHandler);//刷新按钮
		}
		
		
		//跳转当前页面
		public function pageSearch(pageNo:int):void{
			var objectPara:Object=new Object();
			objectPara.pageSize=userApp._pageSize;
			objectPara.pageNo=pageNo;
			sendNotification(UserFacade.USER_COMMAND,objectPara,UserFacade.USER_SEARCH);
		}
		
		//实例化自己
		private static var instance:UserMediator;
		public static function getInstance(key:String,view:Object):UserMediator{
			if(instance==null){
				instance=new UserMediator(UserMediator.NAME,view);
			}
			return instance;
		}
	}
}


