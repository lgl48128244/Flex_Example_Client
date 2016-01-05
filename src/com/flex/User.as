package com.flex
{
	[Bindable]
	[RemoteClass(alias="com.ctvit.flex.model.User")]
	public class User
	{
		public function User()
		{
		}
		
		public var id:int;
		public var uname:String;
		public var pwd:String;
		public var nickname:String;
		public var email:String;
		public var power:String;
		public var teacherid:String;
		public var createTime:Date;
		public var updateTime:Date;
	}
}