pragma SPARK_Mode (On);

with AS_Io_Wrapper ;  use AS_Io_Wrapper ;
with SPARK.Text_IO;use  SPARK.Text_IO;

package runway is
 
   type Plane_Status_Type is (Not_On_Runway, Allowed, Not_Allowed, Takeoff_Allowed, Landing_Allowed, Takeoff_Aborted, Plane_Rerouted);
   
   type Outcome is
      record
         wind_speed : Integer;
         movement : Integer;
         runway_plane : Integer;
         plane_status : Plane_Status_Type;
      end record;

   type safety is
      record
         wind_speed : Integer;
         plane_status : Plane_Status_Type;
      end record;
     
   
   Maximum_wind_speed : constant Integer := 231; 
   
   Critical_Wind_Speed : constant Integer := 34;

   
   result : Outcome; 
   status : safety;
   
   procedure read_wind_speed with
     Global => (In_Out => (Standard_Output, Standard_Input,result)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input), 
                (Standard_Input)  => Standard_Input,
                 result   => (result, Standard_Input)),
     Pre => (result.wind_speed in 0 .. Maximum_wind_speed),
     Post => (result.wind_speed in 0 .. Maximum_wind_speed);
   
 
   procedure manuever with
     Global => (In_Out => (Standard_Output, Standard_Input,result)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input), 
                (Standard_Input)  => Standard_Input,
                 result   => (result, Standard_Input));
   
   
   
   procedure plane_on_runway with
     Global => (In_Out => (Standard_Output, Standard_Input,result)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input), 
                (Standard_Input)  => Standard_Input,
                 result   => (result, Standard_Input));
   
   
   


   procedure status_set with
     Global => (In_Out => (result)),
     Depends => (result => result);
   
     

   
   function Plane_Status_To_String (plane_status   : Plane_Status_Type) return String;
   
   procedure print_status with
     Global => (In_Out => Standard_Output, 
                Input  => result),
     Depends => (Standard_Output => (Standard_Output,result));
   
   procedure Init with
     Global => (Output => (Standard_Output,Standard_Input, result)),
     Depends => ((Standard_Output,Standard_Input, result) => null);
   
   
     
   
   
end runway;

