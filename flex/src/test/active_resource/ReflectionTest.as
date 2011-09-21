package test.active_resource
{
	import flash.utils.describeType;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.hasProperties;
	
	import test.models.TypedDepartment;

	public class ReflectionTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}

		[Test]
		public function testGetAttributes():void {
			var d:TypedDepartment = new TypedDepartment;
			var attributes:Object = getAttributes(d);
			assertThat(attributes, hasProperties({id:hasProperties({name:'id', type:'Number', transient:false}),
												  city:hasProperties({name:'city', type:'String', transient:false}), 
												  state:hasProperties({name:'state', type:'String', transient:false}),
				                                  created_at:hasProperties({name:'created_at', name:'Date', transient:false}),
												  updated_at:hasProperties({name:'updated_at', type:'Date', transient:false})
												}));
			assertThat(attributes, hasProperties({a_boolean:hasProperties({name:'a_boolean', type:'Boolean', transient:true}), 
												  an_array:hasProperties({name:'an_array', type:'Array', transient:true})
												  }));
						
			// see http://jimpravetz.com/actionscript-reflection-based-json-validation
			// test also uint, int,
			// support typed Objects
		}
		protected function getAttributes(instance:Object):Object {
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
			
			// TODO: add getter and setter
		}
		
		
	}
}