package  {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class YardimEkrani extends MovieClip{
		
		public function YardimEkrani() {
			basaDonmeDugmesi.addEventListener(MouseEvent.CLICK,basaDonmeDugmesineBasildi,false,0,true);
			addChild(new Kabarciklar());
			addChild(new Kabarciklar(0xee9977));			
		}

		public function basaDonmeDugmesineBasildi(event:MouseEvent):void{
			dispatchEvent(new NavigationEvent (NavigationEvent.BASA_DON));
		}
	}
	
}