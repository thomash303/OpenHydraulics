within OpenHydraulics.Developed.Circuits;

model DAQ_w2w

  // Importing from the MSL
  import Modelica.Units.SI;
  
  // Rigid body mechanics
  SI.Height eta "Wave elevation";
  SI.Position s "Body position";
  SI.Velocity v "Body velocity";
  
  SI.Force Fpto "PTO force";
  SI.Force Fexc "Excitation force";
  
  // Hydraulics
  SI.Pressure PA "Hydraulic cylinder chamber A pressure";
  SI.Pressure PB "Hydraulic cylinder chamber B pressure";
  SI.Pressure PHP "High pressure accumulator pressure";
  SI.Pressure PLP "Low pressure accumulator pressure";
  
  SI.MassFlowRate mHP "Mass flow from the hydraulic cylinder";
  SI.MassFlowRate mLP "Mass flow to the hydraulic cylinder";
  SI.MassFlowRate mm "Mass flow through the motor";
  
  // Rotational mechanics
  SI.AngularVelocity omega "Shaft angular velocity";
  SI.Torque T "Shaft torque";
  
  // Electrial dynamics
  SI.Voltage Va "Voltage of A phase";
  SI.Voltage Vb "Voltage of B phase";
  SI.Voltage Vc "Voltage of C phase";
  
  SI.Current ia "Current of A phase";
  SI.Current ib "Current of B phase";
  SI.Current ic "Current of C phase";
  

equation

end DAQ_w2w;
