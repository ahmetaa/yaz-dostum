package {

	import flash.events.Event;
	public class OyunOlayi extends Event {

		public static const BITTI:String="bitti";
		public static const TAMAMLANDI:String="tamamlandi";
		
		public function OyunOlayi( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) {
			super( type, bubbles, cancelable );
		}

		public override function clone():Event {
			return new OyunOlayi( type, bubbles, cancelable );
		}

		public override function toString():String {
			return formatToString( "OyunOlayi", "type", "bubbles", "cancelable", "eventPhase" );
		}
	}

}