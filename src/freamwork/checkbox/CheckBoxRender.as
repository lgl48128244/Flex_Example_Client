package freamwork.checkbox
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	
	/**
	 * 使用方法：
	 *    eg: <mx:DataGridColumn  headerRenderer="itemrender.CheckBoxRender" itemRenderer="itemrender.CheckBoxRender"/>
	 *    itemRenderer="utils.itemrender.CheckBoxRender"   ：渲染列
	 *    headerRenderer="utils.itemrender.CheckBoxRender" ：渲染头（全选）
	 */
	public class CheckBoxRender extends CheckBox
	{
		private static var headerFlag:Boolean ;
		public var itemobj:Object;
		
		public function CheckBoxRender(func:Function=null)
		{
			
			super();
			this.addEventListener(Event.CHANGE,onchange);
			this.addEventListener(MouseEvent.CLICK,clickFunction);
		}
		
		private function onchange(evt:Event):void
		{
          if(itemobj is DataGridColumn){
			  return;
		  }
		  
          itemobj.selectedFlag=this.selected;  
		  
		  var dg:DataGrid = this.owner as DataGrid;
		  if(!this.selected){
			  headerFlag = false;
			  dg.dataProvider.refresh();
			  return;
		  }
		  
		  for each(var item:Object in dg.dataProvider){
			  if(!item.selectedFlag)
				  return;
		  }
		  
		  headerFlag = true;
		  dg.dataProvider.refresh();
		  
		}
		
		override public function set data(value:Object):void
		{
			
			  if(value is DataGridColumn)
				{ 
					this.selected=headerFlag;
				}else{
			      if(value.hasOwnProperty("selectedFlag"))
			        {
				       if(value is XML)
				       this.selected=(value as XML).elements("selectedFlag").text().toString()=="true"?true:false; 
				       else
				       this.selected=value.selectedFlag;
			         }else{
				       this.selected=false;
				       value.selectedFlag=false;
			         }					
				}					
			    itemobj=value;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void    
		{    
			super.updateDisplayList(unscaledWidth, unscaledHeight);    
			var n:int = numChildren;   
			for(var i:int = 0; i < n; i++)    
			{    
				var c:DisplayObject = getChildAt(i);    
				if( !(c is TextField))    
				{    
					c.x = Math.round((unscaledWidth - c.width) / 2);    
					c.y = Math.round((unscaledHeight - c.height) /2 );    
				}    
			}    
		}  
		
        private function clickFunction(evt:MouseEvent):void
        {       	
         	if(this.itemobj is DataGridColumn)
         	{
         	var grid:DataGrid=this.owner as DataGrid;
			headerFlag=this.selected;			
            selctr(grid.dataProvider,this.selected); 
            }
        }
        
        private function selctr(list:Object,flag:Boolean):void
		{
			if(list == null)
				return;
			for each(var item:Object in list)
            item.selectedFlag=flag;
			list.refresh();				
		}
		
		public static function selectArray(dg:DataGrid):ArrayCollection{
			var selectArray:ArrayCollection=new ArrayCollection();
			for each(var obj:Object in dg.dataProvider as ArrayCollection){
				if(obj.selectedFlag)
					selectArray.addItem(obj);	
			}
			return selectArray;
		}
	}
}