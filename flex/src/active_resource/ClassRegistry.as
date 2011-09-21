package active_resource
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassRegistry
	{
		
		public static function classForResource(resourceName:String):Class {
			var clazz:Class = resourceMap[resourceName];
			return clazz ? clazz : Object;
		}
				
		public static function resourceForClass(clazz:Class):String {
			return reverseMap[clazz];
		}
		
		public static function resourceForInstance(instance:ActiveResource):String {
			var clazz:Class = getDefinitionByName(getQualifiedClassName(instance)) as Class;			
			return resourceForClass(clazz);
		}	
		
		static protected var resourceMap:Object = {};
		static protected var reverseMap:Object = {};
		static public function resource(resourceName:String, clazz:Class):void {
			resourceMap[resourceName] = clazz;
			reverseMap[clazz] = resourceName;
		}
		
	}
}