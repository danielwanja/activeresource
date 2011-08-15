rails generate scaffold rc_data_type_table  a_string:string a_text:text an_integer:integer a_float:float a_decimal:decimal a_datetime:datetime a_timestamp:timestamp a_time:time a_date:date a_binary:binary a_boolean:boolean


rails generate scaffold department name:string city:string state:string
rails generate scaffold employee   first_name:string last_name:string job_id:integer department_id:integer manager_id:integer hire_date:datetime salary:integer
rails generate scaffold job name:string
rails generate scaffold course job_id:integer title:string description:text

