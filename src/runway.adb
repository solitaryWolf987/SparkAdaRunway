pragma SPARK_Mode (On);
with AS_Io_Wrapper ;  use AS_Io_Wrapper ;

package body runway is

   --Asks user for wind speed, between 0 and 231mph and records it
   procedure read_wind_speed is  
      wind_speed : Integer;
   begin
      AS_Put_Line("Please type in current wind speed ");
      loop
         AS_Get(wind_speed, "Please type an Integer");
         exit when (wind_speed >= 0) and (wind_speed <= Maximum_wind_speed);
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_wind_speed);
         AS_Put_Line("");
      end loop;   
      result.wind_speed := wind_speed;
      --status.wind_speed := wind_speed;
   end read_wind_speed;
     
   --Asks user if the plane is taking off or landing
   procedure manuever is
      movement : Integer;
   begin
      AS_Put_Line("Is the plane taking off or landing? ");
      AS_Put_Line("Please type either '0' for takeoff or '1' for landing.");
      loop
         AS_Get(movement);
         if result.wind_speed >= Critical_Wind_Speed and movement = 0 then     
            result.movement := 0;
         elsif result.wind_speed >= Critical_Wind_Speed and movement = 1 then
            result.movement := 1;
         elsif result.wind_speed < Critical_Wind_Speed and movement = 0 then
            result.movement := 2;
         else
            result.movement := 3;
         end if;    
      exit when (movement >= 0) and (movement <= 1);
         AS_Put("Please type in either 0 or 1");
         AS_Put_Line("");
      end loop;    
   end manuever;
    
   --Asks user if there is a plane already on the runway
   procedure plane_on_runway is
      runway_plane : Integer;
   begin
      AS_Put_Line("Is there a plane on the runway? ");
      AS_Put_Line("Please type either '0' for yes or '1' for no.");
      loop
         AS_Get(runway_plane);  
         exit when (runway_plane >= 0) and (runway_plane <= 1);
         AS_Put("Please type in either 0 or 1");
         AS_Put_Line("");
      end loop;  
      result.runway_plane := runway_plane;
   end plane_on_runway;        
      
   --Sets the status of the plane - whether it can or cannot take-off or land
   procedure status_set is  
   begin
      if result.runway_plane = 0 then
         if result.movement = 0 then
            result.plane_status := Takeoff_Aborted;
           -- status.plane_status := Not_Allowed;
         elsif result.movement = 1 then
            result.plane_status := Plane_Rerouted;
            --status.plane_status := Not_Allowed;
         elsif result.movement = 2 then
            result.plane_status := Takeoff_Aborted;
            --status.plane_status := Not_Allowed;
         else
            result.plane_status := Plane_Rerouted;
            --status.plane_status := Not_Allowed;
         end if;
      else
         if result.movement = 0 then
            result.plane_status := Takeoff_Aborted;
            --status.plane_status := Not_Allowed;
         elsif result.movement = 1 then
            result.plane_status := Plane_Rerouted;
            --status.plane_status := Not_Allowed;
         elsif result.movement = 2 then
            result.plane_status := Takeoff_Allowed;
           -- status.plane_status := Allowed;
         else
            result.plane_status := Landing_Allowed;
            --status.plane_status := Allowed;
         end if;
      end if;
      
   end status_set; 
   
   --Turns the Plane Status Type variable into printable text
   function Plane_Status_To_String (plane_status   : Plane_Status_Type) return String is
   begin
      if (plane_status = Takeoff_Aborted) then
         return "Takeoff Aborted";
      elsif (plane_status = Plane_Rerouted) then
         return "Plane Rerouted";
      elsif (plane_status = Takeoff_Allowed) then
         return "Takeoff Allowed";
      else 
         return "Landing Allowed";
      end if;
   end Plane_Status_To_String;
   
   --Prints the plane status according to all the inout variables
   procedure print_status is  
   begin
      if result.runway_plane = 0 then
         AS_Put("There is a plane on the runway therefore ");
         AS_Put_Line(Plane_Status_To_String(result.plane_status));
      else
         AS_Put("Wind speed: ");
         AS_Put((result.wind_speed));
         AS_Put("mph");
         AS_Put_Line("");
         AS_Put("Plane Status: ");
         AS_Put_Line(Plane_Status_To_String(result.plane_status));
         
      end if;
   end print_status;
   
   
   
   procedure Init is
   begin
      AS_Init_Standard_Input; 
      AS_Init_Standard_Output;
      result := (wind_speed => 0, movement => 0, runway_plane => 1,
                 plane_status => Not_On_Runway);
   end Init;
   
end runway;
