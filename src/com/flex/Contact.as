package com.flex
{

	[Bindable]
	[RemoteClass(alias="flex3Bible.Contact")]
	public class Contact
	{
		public var contactId:int;
		public var firstName:String;
		public var lastName:String;
		
		public function Contact()
		{
		}
	
	}
}