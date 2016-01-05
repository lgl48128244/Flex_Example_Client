package ActionScript;
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import mx.controls.CheckBox;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	import mx.events.TreeEvent;
	
	public class TreeCheckBoxRender extends TreeItemRenderer {
		private static var _colorForThirdState:int = 0x37BEF8;
		private static var _selectedField:String = "selected";
		
		private var checkBox:CheckBox;
		
		public function TreeCheckBoxRender() {
			super();
		}
		
		private function dispatchRenderEvent():void
		{
			var event:TreeEvent = new TreeEvent("eventString");
			event.itemRenderer = this;
			this.owner.dispatchEvent(event);
		}
		
		override protected function createChildren():void {
			super.createChildren();
			checkBox = new CheckBox();
			addChild(checkBox);
			checkBox.addEventListener(Event.CHANGE, changeHandler);
			checkBox.addEventListener(MouseEvent.CLICK,updateCheck);
		}
		/* 添加事件 */
		protected function updateCheck(e:Event):void{
			var b:Boolean=this.dispatchEvent(new Event("updateTreeEvent",true));
		}
		/**//**
		* Initial data when component initialization
		*
		*/
		override protected function commitProperties():void {
			super.commitProperties();
			if (data && data.@[_selectedField] != null) {
				var s:int = int(data.@[_selectedField]);
				var selected:Boolean = s > 0 ? true : false;
				checkBox.selected = selected;
			} else {
				checkBox.selected = false;
			}
		}
		
		/**//**
		* update dataProvider when user click CheckBox
		*
		*/
		protected function changeHandler(event:Event):void {
			if (data && data.@[_selectedField] != null) {
				data.@[_selectedField] = checkBox.selected ? "1" : "0";
			}
			
			var listData:TreeListData = TreeListData(listData);
			if (listData.hasChildren) {
				var item:XML = XML(listData.item);
				handleAllChildren(item.children());
			}
			handleAllParents(listData.item.parent());
			dispatchRenderEvent();
		}
		
		private function handleAllChildren(children:XMLList):void {
			for each (var item:XML in children) {
				item.@[_selectedField] = checkBox.selected ? "1" : "0";
				var children:XMLList = item.children();
				if (children.length() > 0) {
					handleAllChildren(children);
				}
			}
		}
		
		private function handleAllParents(parent:XML):void {
			if (parent != null) {
				var children:XMLList = parent.children();
				var hasSelected1:Boolean = false;
				var hasSelected2:Boolean = false;
				var hasSelected0:Boolean = false;
				for each (var item:XML in children) {
					if (int(item.@[_selectedField]) == 1) {
						hasSelected1 = true;
					}
					if (int(item.@[_selectedField]) == 2) {
						hasSelected2 = true;
					}
					if (int(item.@[_selectedField]) == 0) {
						hasSelected0 = true;
					}
				}
				if (checkBox.selected == true) {
					if (!hasSelected0 && !hasSelected2) {
						parent.@[_selectedField] = "1";
					} else {
						parent.@[_selectedField] = "2";
					}
				} else {
					if (!hasSelected1 && !hasSelected2) {
						parent.@[_selectedField] = "0";
					} else {
						parent.@[_selectedField] = "2";
					}
				}
				handleAllParents(parent.parent());
			}
		}
		
		/**//**
		* reset itemRenderer's width
		*/
		override protected function measure():void {
			super.measure();
			measuredWidth += checkBox.getExplicitOrMeasuredWidth();
		}
		
		/**//**
		* re-assign layout for tree, move lable to right
		* @param unscaledWidth
		* @param unscaledHeight
		*/
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			var startx:Number = data ? TreeListData(listData).indent : 0;
			
			if (disclosureIcon) {
				disclosureIcon.x = startx;
				startx = disclosureIcon.x + disclosureIcon.width;
				disclosureIcon.setActualSize(disclosureIcon.width, disclosureIcon.height);
				disclosureIcon.visible = data ? TreeListData(listData).hasChildren : false;
			}
			if (icon) {
				icon.x = startx;
				startx = icon.x + icon.measuredWidth;
				icon.setActualSize(icon.measuredWidth, icon.measuredHeight);
			}
			checkBox.move(startx, (unscaledHeight - checkBox.height) / 2);
			label.x = startx + checkBox.getExplicitOrMeasuredWidth();
			
			var node:XML = data as XML;
			if(node == null){fillCheckBox(false);return;}
			if (int(node.@[_selectedField]) == 2) {
				fillCheckBox(true);
			} else {
				fillCheckBox(false);
			}
			
		}
		
		/**//**
		* re-draw check box for the third state
		* @param isFill
		*/
		private function fillCheckBox(isFill:Boolean):void {
			checkBox.validateNow();
			checkBox.graphics.clear();
			if (isFill) {
				var myRect:Rectangle = checkBox.getBounds(checkBox);
				checkBox.graphics.beginFill(_colorForThirdState, 1);
				checkBox.graphics.drawRoundRect(myRect.x, myRect.y, myRect.width, myRect.height, 1, 0x00FF00);
				checkBox.graphics.endFill();
			}
		}
	}
}

