package test.active_resource
{
	public class TestLoadFromXML
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		// RcDataTypeTable.all.to_xml(:dasherize =>false)
		private var rcDataTypeTableFixture:XML = 
			<rc_data_type_tables type="array">
			  <rc_data_type_table>
				<id type="integer">298486374</id>
				<a_string>MyString</a_string>
				<a_text>MyText</a_text>
				<an_integer type="integer">1</an_integer>
				<a_float type="float">1.5</a_float>
				<a_decimal type="decimal">9.99</a_decimal>
				<a_datetime type="datetime">2011-08-15T17:06:09Z</a_datetime>
				<a_timestamp type="datetime">2011-08-15T17:06:09Z</a_timestamp>
				<a_time type="datetime">2000-01-01T17:06:09Z</a_time>
				<a_date type="date">2011-08-15</a_date>
				<a_binary type="binary" nil="true" encoding="base64"></a_binary>
				<a_boolean type="boolean">false</a_boolean>
				<created_at type="datetime">2011-08-17T02:18:58Z</created_at>
				<updated_at type="datetime">2011-08-17T02:18:58Z</updated_at>
			  </rc_data_type_table>
			  <rc_data_type_table>
				<id type="integer">980190962</id>
				<a_string>MyString</a_string>
				<a_text>MyText</a_text>
				<an_integer type="integer">1</an_integer>
				<a_float type="float">1.5</a_float>
				<a_decimal type="decimal">9.99</a_decimal>
				<a_datetime type="datetime">2011-08-15T17:06:09Z</a_datetime>
				<a_timestamp type="datetime">2011-08-15T17:06:09Z</a_timestamp>
				<a_time type="datetime">2000-01-01T17:06:09Z</a_time>
				<a_date type="date">2011-08-15</a_date>
				<a_binary type="binary" nil="true" encoding="base64"></a_binary>
				<a_boolean type="boolean">false</a_boolean>
				<created_at type="datetime">2011-08-17T02:18:58Z</created_at>
				<updated_at type="datetime">2011-08-17T02:18:58Z</updated_at>
			  </rc_data_type_table>
			</rc_data_type_tables>;	
		
		
		// Department.all.to_xml(:include=>:employees, :dasherize =>false)
		private var departmentsFixture:XML = 
			<departments type="array">
			  <department>
				<id type="integer">980190963</id>
				<name>department1</name>
				<city>Littleton</city>
				<state>CO</state>
				<created_at type="datetime">2011-08-17T02:49:27Z</created_at>
				<updated_at type="datetime">2011-08-17T02:49:27Z</updated_at>
				<employees type="array">
				  <employee>
					<id type="integer">980190963</id>
					<first_name>first_1</first_name>
					<last_name>last_1</last_name>
					<job_id type="integer">12</job_id>
					<department_id type="integer">980190963</department_id>
					<manager_id type="integer">980190965</manager_id>
					<hire_date type="datetime" nil="true"></hire_date>
					<salary type="integer" nil="true"></salary>
					<created_at type="datetime">2011-08-17T02:49:28Z</created_at>
					<updated_at type="datetime">2011-08-17T02:49:28Z</updated_at>
				  </employee>
				  <employee>
					<id type="integer">980190964</id>
					<first_name>first_2</first_name>
					<last_name>last_2</last_name>
					<job_id type="integer">12</job_id>
					<department_id type="integer">980190963</department_id>
					<manager_id type="integer" nil="true"></manager_id>
					<hire_date type="datetime" nil="true"></hire_date>
					<salary type="integer" nil="true"></salary>
					<created_at type="datetime">2011-08-17T02:49:28Z</created_at>
					<updated_at type="datetime">2011-08-17T02:49:28Z</updated_at>
				  </employee>
				  <employee>
					<id type="integer">980190965</id>
					<first_name>first_3</first_name>
					<last_name>last_3</last_name>
					<job_id type="integer">12</job_id>
					<department_id type="integer">980190963</department_id>
					<manager_id type="integer" nil="true"></manager_id>
					<hire_date type="datetime" nil="true"></hire_date>
					<salary type="integer" nil="true"></salary>
					<created_at type="datetime">2011-08-17T02:49:28Z</created_at>
					<updated_at type="datetime">2011-08-17T02:49:28Z</updated_at>
				  </employee>
				</employees>
			  </department>
			  <department>
				<id type="integer">980190964</id>
				<name>department2</name>
				<city>Littleton</city>
				<state>CO</state>
				<created_at type="datetime">2011-08-17T02:49:29Z</created_at>
				<updated_at type="datetime">2011-08-17T02:49:29Z</updated_at>
				<employees type="array"/>
			  </department>
			  <department>
				<id type="integer">980190965</id>
				<name>department3</name>
				<city>Littleton</city>
				<state>CO</state>
				<created_at type="datetime">2011-08-17T02:49:29Z</created_at>
				<updated_at type="datetime">2011-08-17T02:49:29Z</updated_at>
				<employees type="array"/>
			  </department>
			</departments>;			
	}
}