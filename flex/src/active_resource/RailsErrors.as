package active_resource
{
	public class RailsErrors
	{
		protected var errors:Object;
		
		/**
		 * This class represents the Rails validations errors.
		 * 
		 * @param errors an object in the form: {"name":["is too long (maximum is 20 characters)"],"city":["is too long (maximum is 20 characters)"]}
		 */
		public function RailsErrors(errors:Object)
		{
			this.errors = errors;
		}
		
		public function clear():void {
			this.errors = {};
		}
		public function fullMessages(join:String='\n'):String {
			return allErrors.join(join)
		}
		
		public function get allErrors():Array {
			var result:Array = [];
			for (var field:String in errors) {
				var fieldErrors:Array = errors[field];
				for each (var error:String in fieldErrors) {
					result.push(field=="base" ? error : field+" "+error);
				}
			}
			return result;
		}
		
		public function get count():Number {
			return allErrors.length; // FIXME: optimize
		}
		
		public function addBase(message:String):void {
			add("base", message);
		}
		
		public function add(attribute:String, message:String):void {
			if (errors[attribute]==null) {
				errors[attribute] = [];
			}
			errors[attribute].push(message);
		}
		
		public function on(attribute:String):Array {
			return errors[attribute];
		}
		
	}
}