package test.active_resource
{
	import active_resource.Reflection;
	
	import flash.utils.describeType;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.hasProperties;
	import org.hamcrest.object.hasProperty;
	
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
			var department:TypedDepartment = new TypedDepartment;
			var attributes:Object = Reflection.getAttributes(department);
			assertThat(attributes, hasProperty('name', hasProperties({name:'name', type:'String', transient:false})));

			assertThat(attributes, hasProperties({id:hasProperties({name:'id', type:'*', transient:false}),
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

		
		
	}
}