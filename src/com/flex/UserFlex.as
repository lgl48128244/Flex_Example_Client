package com.flex
{
	[Bindable]
	[RemoteClass(alias="com.ctvit.flex.model.User")]
	public class UserFlex
	{
		public function UserFlex()
		{
		}
		private var _id:int;
		private var _username:String;
		private var _password:String;
		
		
		public function get password():String
		{
			return _password;
		}

		public function set password(value:String):void
		{
			_password = value;
		}

		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}
	}
}