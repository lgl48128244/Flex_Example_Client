package freamwork.common
{
	
	
	/**
	 * 消息通道
	 * @author pengcl
	 * @date 2013/01
	 */
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.events.FaultEvent;
	import mx.controls.Alert;
	
	/**
	 * @author pengcl
	 * @date 2013/01
	 */
	
	public final class MsgChannel
	{
       private static const  amf:AMFChannel=new AMFChannel("my-amf","messagebroker/amf");
       private static const  channel:ChannelSet=new ChannelSet();
       private static var logger:ILogger = Log.getLogger("com.freamwork.common.MsgChannel");
	   
      //通道   在java端没有配置 services-config.xml 时使用
       public static function channelSet():ChannelSet{
       	amf.pollingEnabled=true;
       	amf.pollingInterval=0.5;
       	channel.addChannel(amf);  
       	channel.addEventListener(FaultEvent.FAULT,errorHandler);  
       	return channel;  	
       }
       
      //错误提示
       public static function errorHandler(e:FaultEvent):void{
		  trace(e.toString());
       	  logger.error(e.toString());
		  Alert.show(e.toString());
       }
	}
	
	
}