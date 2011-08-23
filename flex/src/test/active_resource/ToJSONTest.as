package test.active_resource
{
	import active_resource.RailsEncoder;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.hamcrest.text.containsString;
	
	import test.models.Employee;
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
				a_datetime  : "2011-08-15 17:06:09",
				a_timestamp : "2011-08-15 17:06:09",
				a_time      : "2011-08-15 17:06:09",
				a_date      : new Date(2011,07,15),
				a_binary    : null,
				a_boolean   : true
			});
			var json:String = RailsEncoder.objectToRails(record);
			assertNotNull(json);
			assertThat(json, containsString('"a_decimal":99.99'));
			assertThat(json, containsString('"a_string":"A String"'));
			assertThat(json, containsString('"a_text":"A text that can be very long"'));
			assertThat(json, containsString('"a_date":{"millisecondsUTC":0,"secondsUTC":0,"fullYear":2011,"day":1,"dayUTC":1'));
			fail("Implement data conversion as a_date should be Rails date format complient.")
		}
	}
}