package test.active_resource
{
	import active_resource.RailsDecoder;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.hamcrest.object.hasProperties;
	
	import test.fixtures.Fixtures;
	import test.fixtures.RailFixtures;
	import test.models.Department;
	import test.models.Employee;
	import test.models.RcDataTypeTable;

	public class FromJSONTest
	{		
		private var fixtures:RailFixtures ;
		
		[BeforeClass]
		static public function registerResources():void {
			// Static block that register the resource is only invoked when need...and that is too late for Employee
			// as it needs to be registered before decoding the employees attributes. Hence forning registartion as follows:
			new Employee();
		}
		
		[Before]
		public function setUp():void
		{
			fixtures = new RailFixtures();
		}
		
		[After]
		public function tearDown():void
		{
			fixtures = null;
		}
		
		[Test]
		public function testDataTypes():void {
			var rcDataTypeTables:ArrayCollection = RailsDecoder.from_rails(RcDataTypeTable, fixtures.rcDataTypeTables) as ArrayCollection;
			assertEquals(2, rcDataTypeTables.length);
			assertTrue(rcDataTypeTables.getItemAt(0) is RcDataTypeTable);
			assertTrue(rcDataTypeTables.getItemAt(1) is RcDataTypeTable);
			var data:RcDataTypeTable = rcDataTypeTables.getItemAt(0) as RcDataTypeTable;
			assertEquals();
			assertNull(data.a_binary);
			assertFalse(data.a_boolean);
			assertEquals(9.99, data.a_decimal);
			assertEquals(1.5, data.a_float);
			assertEquals("MyString", data.a_string);
			assertEquals("MyText", data.a_text);
			assertEquals(1, data.an_integer);
			assertEquals(298486374, data.id);
			
			// TODO: add date conversion			
//			"a_date": "2011-08-15",
//			"a_datetime": "2011-08-15T17:06:09Z",
//			"a_time": "2000-01-01T17:06:09Z",
//			"a_timestamp": "2011-08-15T17:06:09Z",
//			"created_at": "2011-08-20T19:44:34Z",
//			"updated_at": "2011-08-20T19:44:34Z"			
		}
		
		[Test]
		public function testAssociations():void {
			var departments:ArrayCollection =  RailsDecoder.from_rails(Department,  fixtures.departments) as ArrayCollection;
			assertEquals(3, departments.length);
			assertTrue(departments.getItemAt(0) is Department);
			assertTrue(departments.getItemAt(1) is Department);
			assertTrue(departments.getItemAt(2) is Department);
			var department:Department = departments.getItemAt(0) as Department;
			
			assertThat(department, hasProperties({ id: 980190963, 
				name:"department1",
				state: "CO",
				city : "Littleton"
			}));
			assertTrue(department.employees is ArrayCollection);
			assertEquals(3, department.employees.length);	
			
			assertTrue("Expected Employee but was "+department.employees.getItemAt(0), department.employees.getItemAt(0) is Employee);
			var employee:Employee = department.employees.getItemAt(0) as Employee;

			assertThat(employee, hasProperties({ id: 980190963,
				department_id: 980190963,
				first_name: "first_1",
				job_id: 12,
				last_name: "last_1",
				manager_id: 980190965,
				salary: null
			}));		
			
		}
		
	}
}