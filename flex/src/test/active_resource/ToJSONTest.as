package test.active_resource
{
	import active_resource.RailsEncoder;
	
	import com.adobe.serialization.json.JSONDecoder;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.hamcrest.object.hasProperties;
	import org.hamcrest.text.containsString;
	
	import test.models.Child;
	import test.models.Employee;
	import test.models.Parent;
	import test.models.RcDataTypeTable;

	public class ToJSONTest
	{
		[BeforeClass]
		static public function registerResources():void {
			// Static block that register the resource is only invoked when need...and that is too late for Employee
			// as it needs to be registered before decoding the employees attributes. Hence forning registartion as follows:
			new Employee();
		}
		
		[Test]
		public function testDataTypes():void {
			var record:RcDataTypeTable = new RcDataTypeTable({
				a_string    :  "A String",
				a_text      : "A text that can be very long",
				an_integer  : 3,
				a_float     : 2.5,
				a_decimal   : 99.99,
				a_datetime  : new Date(2011, 07, 15, 17, 06, 09), // "2011-08-15 17:06:09"
				a_timestamp : new Date(2011, 07, 15, 17, 06, 09), // "2011-08-15 17:06:09"
				a_time      : new Date(2011, 07, 15, 17, 06, 09), // "2011-08-15 17:06:09"
				a_date      : new Date(2011,07,15),
				a_binary    : null,
				a_boolean   : true
			});
			var json:String = RailsEncoder.objectToRails(record);
			assertNotNull(json);
			assertThat(json, containsString('"a_decimal":99.99'));
			assertThat(json, containsString('"a_string":"A String"'));
			assertThat(json, containsString('"a_text":"A text that can be very long"'));
			assertThat(json, containsString('"a_date":"2011-08-15T06:00:00-00:00"'));
			assertThat(json, containsString('"a_datetime":"2011-08-15T23:06:09-00:00"'));  // FIXME: check timezone conversion...
			assertThat(json, containsString('"a_timestamp":"2011-08-15T23:06:09-00:00"'));
			assertThat(json, containsString('"a_time":"2011-08-15T23:06:09-00:00"'));
			fail("Check to ensure that we don't have timezone issue between 17:06:09 and T23:06:09.")
		}
		
		// see http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
		[Test]
		public function testNestedAttributes():void {
			var parent:Parent = parentFixture();
			var json:String = RailsEncoder.objectToRails(parent, {nestedAttributes:"children"});
			var actual:Object = new JSONDecoder(json, /*strict*/true).getValue();
			assertNotNull(actual.parent);
			var parentObject:Object = actual.parent;
			assertTrue(parentObject.children_attributes is Array);
			assertEquals(5, parentObject.children_attributes.length);
			assertEquals("Expected order of association to be respected", "Noah", parentObject.children_attributes[0].name); 
			var firstChild:Object = parentObject.children_attributes[0];
			assertThat(firstChild, hasProperties({name:"Noah",   favorite_food:"Jelly Beans", id:1 }));
			// assertNotNull(firstChild._local_id);    // FIXME: check if we want to have a _local_id
		}
		
		
		private function parentFixture():Parent {
			var parent:Parent = new Parent();
			parent.name = "Daniel";
			parent.id = 1;
			parent.favorite_food = "Cheese";
			parent.children = new ArrayCollection();
			parent.children.addItem(new Child({name:"Noah",   favorite_food:"Jelly Beans", id:1 }));
			parent.children.addItem(new Child({name:"Joshua", favorite_food:"Salami", id:2 }));
			parent.children.addItem(new Child({name:"Nina",   favorite_food:"Ice cream", id:3 }));
			parent.children.addItem(new Child({name:"Future",   favorite_food:"Milk" }));
			parent.children.addItem(new Child({name:"Rockie", favorite_food:"Dog food", _destory:true }));
			return parent;			
		}		
	}
}