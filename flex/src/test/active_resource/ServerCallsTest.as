package test.active_resource
{
	import active_resource.ActiveResource;
	import active_resource.RailsErrors;
	
	import com.adobe.serialization.json.JSONDecoder;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertStrictlyEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.object.hasProperties;
	
	import test.helper.BaseServerTestCase;
	import test.models.Department;
	import test.models.RcDataTypeTable;

	public class ServerCallsTest extends BaseServerTestCase
	{	
		
		
		[Before(async)]
		public function setUp():void
		{
			loadFixtures("setup_data_type_table");
		}
		
		[After]
		public function tearDown():void
		{
		}

		[Test(async)]
		public function testFindAll():void {
			assertCall(ActiveResource.findAll(RcDataTypeTable), function(result:Object):void {
				assertNotNull(result);
				assertTrue(result is ArrayCollection);
				assertEquals(1, result.length);
				assertTrue(result.getItemAt(0) is RcDataTypeTable);				
			})
		}
		
		[Test(async)]
		public function testFind():void {
			var id:Number = fixtures.rc_data_type_table.id;
			assertCall(ActiveResource.find(RcDataTypeTable, id), function(result:Object):void {
				assertNotNull(result);
				assertTrue(result is RcDataTypeTable);
				assertThat(result, hasProperties(fixtures.rc_data_type_table));
				assertEquals(9.99, result.a_decimal);
				assertFalse(isNaN(result.a_decimal));
				assertFalse("Expect a_decimal to be a Number and not a string.", result.a_decimal is String);  // FIXME: that seems to occur on the Rails side.
				assertStrictlyEquals(9.99, result.a_decimal);
			})			
		}
		
		[Test(async)]
		public function testCreate():void {
			var record:RcDataTypeTable = new RcDataTypeTable({
				a_string    :  "A String",
				a_text      : "A text that can be very long",
				an_integer  : 3,
				a_float     : 2.5,
				a_decimal   : 99.99,
				a_datetime  : "2011-08-15 17:06:09",
				a_timestamp : "2011-08-15 17:06:09",
				a_time      : "2011-08-15 17:06:09",
				a_date      : "2011-08-15",
				a_binary    : null,
				a_boolean   : true
			});
			assertCall(ActiveResource.create(RcDataTypeTable, record), function(result:Object):void {  //<-- CREATE
				assertNotNull(result);
				assertTrue(result is RcDataTypeTable);
				assertEquals(99.99, result.a_decimal);
				assertEquals("A String", result.a_string)
				assertEquals("A text that can be very long", result.a_text);
				assertNotNull(result.id);
				assertTrue(result.id is Number);
			})					
		}		
		
		[Test(async)]
		public function testUpdate():void {
			var id:Number = fixtures.rc_data_type_table.id;			
			assertCall(ActiveResource.find(RcDataTypeTable, id), function(result:Object):void {
				// First we get a record
				assertTrue(result is RcDataTypeTable);
				var record:RcDataTypeTable = result as RcDataTypeTable;
				record.a_string = "I just go updated!";
				assertCall(ActiveResource.update(RcDataTypeTable, record), function(result:Object):void {  //<-- UPDATE
					// Then update it
					assertNull(result); // Update just set head :ok by default
					assertCall(ActiveResource.find(RcDataTypeTable, id), function(result:Object):void {
						// Just checking that the record is really updated.
						assertTrue(result is RcDataTypeTable);
						assertEquals("I just go updated!", result.a_string);
					})					
				})			
			})			
		}		
		
		[Test(async)]
		public function testDelete():void {
			var id:Number = fixtures.rc_data_type_table.id;			
			assertCall(ActiveResource.find(RcDataTypeTable, id), function(result:Object):void {
				// First we get a record
				var record:RcDataTypeTable = result as RcDataTypeTable;
				assertCall(ActiveResource.destroy(RcDataTypeTable, record), function(result:Object):void {  //<-- DELETE
					// Then update it
					assertNull(result); // Delete just set head :ok by default
					assertCall(ActiveResource.findAll(RcDataTypeTable), function(result:Object):void {
						// Just checking that the record is really gone
						assertTrue(result is ArrayCollection);
						assertEquals(0, result.length);
					})					
				})			
			})			
		}		
		
		[Test(async)]
		public function testCreateWithValidationErrors():void {
			var record:Department = new Department({
				name :  "A name that is too long as it's more than 20 characters", 
				city : "A text that can be very long",
				state: "CO"
			});
			assertCall(ActiveResource.create(Department, record), 
				function(result:Object):void {
					fail("Expect the faultHandler to be called");
				},
				function(faultEvent:FaultEvent, token:Object=null):void {
					assertNotNull(faultEvent.fault.content);
					assertTrue(record.errors is RailsErrors);
					assertStrictlyEquals(record.errors, faultEvent.fault.content)
					assertEquals(2, record.errors.count);
					
					assertTrue(record.errors.on("city") is Array);
					assertEquals(1, record.errors.on("city").length);
					assertEquals("is too long (maximum is 20 characters)", record.errors.on("city")[0]);
					
					assertTrue(record.errors.on("name") is Array);
					assertEquals(1, record.errors.on("name").length);
					assertEquals("is too long (maximum is 20 characters)", record.errors.on("name")[0]);
					
					assertEquals("city is too long (maximum is 20 characters)\nname is too long (maximum is 20 characters)", record.errors.fullMessages());
				}
			)					
		}
		

		
	}
}