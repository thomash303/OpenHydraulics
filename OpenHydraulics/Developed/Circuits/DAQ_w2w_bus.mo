within OpenHydraulics.Developed.Circuits;

expandable connector DAQ_w2w_bus

  // Importing from the MSL
  import Modelica.Units.SI;
  
  // Rigid body mechanics
  //SI.Height eta  "Wave elevation";
  input SI.Position s "Body position";
  input SI.Velocity v "Body velocity";
  
  //SI.Force Fpto "PTO force";
  //SI.Force Fexc "Excitation force";
  
  // Hydraulics
  input SI.Pressure pA "Hydraulic cylinder chamber A pressure";
  input SI.Pressure pB "Hydraulic cylinder chamber B pressure";
  input SI.Pressure pHP "High pressure accumulator pressure";
  input SI.Pressure pLP "Low pressure accumulator pressure";
  
  input SI.MassFlowRate mHP "Mass flow from the hydraulic cylinder";
  input SI.MassFlowRate mLP "Mass flow to the hydraulic cylinder";
  input SI.MassFlowRate mm "Mass flow through the motor";
  
  // Rotational mechanics
  input SI.AngularVelocity omega "Shaft angular velocity";
  input SI.Torque T "Shaft torque";
  
  // Electrial dynamics
  input SI.Voltage V "Voltage space phasor";
  
  input SI.Current i "Current space phasor";

end DAQ_w2w_bus;
