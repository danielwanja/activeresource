package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class RcDataTypeTable extends ActiveResource
	{
		public function RcDataTypeTable(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var a_string:String;
		public var a_text:String;
		public var an_integer:Number;
		public var a_float:Number
		public var a_decimal:Number
		public var a_datetime:Date;
		public var a_timestamp:Date;
		public var a_time:Date;
		public var a_date:Date;
		public var a_binary:*;   // Fixme: How to map a binary?
		public var a_boolean:Boolean;
		public var created_at:Date;
		public var updated_at:Date;
		
		/* static block */		
		resource("rc_data_type_tables", RcDataTypeTable); 	
		
	}
}