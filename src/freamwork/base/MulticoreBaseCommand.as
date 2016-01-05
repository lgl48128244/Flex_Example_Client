package freamwork.base
{
    import mx.controls.Alert;
    import mx.rpc.IResponder;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    
    
    
   
    
	/**
	 * @author pengcl
	 * @date 2013/01
	 */
    public class MulticoreBaseCommand extends SimpleCommand implements ICommand,IResponder
    {
        public function MulticoreBaseCommand()
        {
            super();
        }

        override public function execute(notification : INotification) : void
        {
            super.execute(notification);
        }
        public function result(data : Object) : void
        {
            
        }

        public function fault(info : Object) : void
        {
//        	var str:String=InitService.getText('system_net_error');
//        	if(str==null){
//        		str='system_net_error';
//        	}
        	Alert.show("网络连接错误，err:"+info);
        }
    }
}