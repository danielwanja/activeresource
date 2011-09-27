package active_resource
{
	import flash.utils.describeType;

	public class Reflection
	{
		// TODO: add getter and setter support
		static public function getAttributes(instance:Object):Object {
			var result:Object = {};
			var propertyMap:XML = describeType(instance);
			for each (var property:XML in propertyMap.variable) 
			{
				var propertyName:String = property.@name;
				var propertyType:String = property.@type;
				var transient:String = property.metadata.(@name=='Transient').@name.toString();
				result[propertyName] = {name:propertyName, type:propertyType, transient:transient=='Transient'};
			}
			return result;
		}
	}
}