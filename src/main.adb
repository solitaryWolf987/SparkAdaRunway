pragma SPARK_Mode (On);

with AS_Io_Wrapper ;  use AS_Io_Wrapper ;
with runway; use runway;


procedure Main is

   exit_condition : Integer;
begin
   Init;
   loop
      pragma Loop_Invariant (result.wind_speed in 0 .. Critical_Wind_Speed and result.movement in 0 .. 1 and result.runway_plane in 0 .. 1 and
                               (result.plane_status = Not_On_Runway or result.plane_status = Landing_Allowed or result.plane_status = Takeoff_Allowed
                               or result.plane_status = Takeoff_Aborted or result.plane_status = Plane_Rerouted));
      read_wind_speed;
      manuever;
      plane_on_runway;
      status_set;
      print_status;
      AS_Put_Line;
      AS_Put_Line("Would you like to continue? ");
      AS_Put_Line("Please type either '0' for yes or '1' for no.");
      AS_Get(exit_condition);
         exit when (exit_condition = 1);
   end loop;
end Main;
