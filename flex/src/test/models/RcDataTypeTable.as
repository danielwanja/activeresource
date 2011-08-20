package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class RcDataTypeTable extends ActiveResource
	{
		public function RcDataTypeTable(attributes:Object=null)
		{
			super(attributes);
		}
		
		resource("rc_data_type_tables", RcDataTypeTable); 			
	}
}