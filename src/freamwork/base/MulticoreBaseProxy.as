package freamwork.base
{
    import mx.rpc.events.FaultEvent;
    import mx.rpc.remoting.RemoteObject;
    
    import freamwork.common.MsgChannel;
    
    import org.puremvc.as3.multicore.interfaces.IProxy;
    import org.puremvc.as3.multicore.patterns.proxy.Proxy;
    

	/**
	 * @author pengcl
	 * @date 2013/01
	 */
    public class MulticoreBaseProxy extends Proxy implements IProxy
    {
		public var romoteBean:RemoteObject;
        public function MulticoreBaseProxy(proxyName : String = null, data : Object = null)
        {
            super(proxyName, data);
			romoteBean=new RemoteObject();
			romoteBean.showBusyCursor=true;
//			romoteBean.channelSet=MsgChannel.channelSet();
			romoteBean.addEventListener(FaultEvent.FAULT,MsgChannel.errorHandler);
        }
    }
}