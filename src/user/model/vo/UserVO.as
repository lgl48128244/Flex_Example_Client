package user.model.vo
{
	[Bindable]
	[RemoteClass(alias="com.ctvit.flex.model.User")]
	public class UserVO
	{
		
		private var _id:int;
		private var _uname:String;
		private var _pwd:String;
		private var _nickname:String;
		private var _email:String;
		private var _power:String;
		private var _teacherid:String;
		private var _createTime:Date;
		private var _updateTime:Date;
		public var selectedFlag:Boolean;

		public function UserVO()
		{
			
		}
		public function get updateTime():Date
		{
			return _updateTime;
		}

		public function set updateTime(value:Date):void
		{
			_updateTime = value;
		}

		public function get createTime():Date
		{
			return _createTime;
		}

		public function set createTime(value:Date):void
		{
			_createTime = value;
		}

		public function get teacherid():String
		{
			return _teacherid;
		}

		public function set teacherid(value:String):void
		{
			_teacherid = value;
		}

		public function get power():String
		{
			return _power;
		}

		public function set power(value:String):void
		{
			_power = value;
		}

		public function get email():String
		{
			return _email;
		}

		public function set email(value:String):void
		{
			_email = value;
		}

		public function get nickname():String
		{
			return _nickname;
		}

		public function set nickname(value:String):void
		{
			_nickname = value;
		}

		public function get pwd():String
		{
			return _pwd;
		}

		public function set pwd(value:String):void
		{
			_pwd = value;
		}

		public function get uname():String
		{
			return _uname;
		}

		public function set uname(value:String):void
		{
			_uname = value;
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