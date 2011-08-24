package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class RcDataTypeTable extends ActiveResource
	{
		public function RcDataTypeTable(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */		
		resource("rc_data_type_tables", RcDataTypeTable); 	
		
		/* Date Field Declaration: a) or b) Note I want to avoid a) but it's more Flex like, it's however
		                           really nice to stay DRY and not repeat all the model attributes.
		
		a) strongly typed variables 
		var a_date : Date;
		var a_datetime : Date;
		var a_time : Date;
		var a_timestamp : Date;
		var created_at : Date;
		var updated_a : Date;
		
		or b)		
		date_field "a_date,a_datetime,a_time,a_timestamp,created_at,updated_a"
		*/
	}
}