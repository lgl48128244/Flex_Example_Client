package mvc.model.vo
{
	[Bindable]
	[RemoteClass(alias="com.ctvit.flex.model.Log")]
	public class User
	{
		public var selected:Boolean = false;//存放复选框的状态
		public var pk:int;
		public var name:String;
		public var value:String;
	}
}