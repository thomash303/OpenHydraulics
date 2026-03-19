within OpenHydraulics.Developed.Circuits;

model DAQ_w2w

  // Importing from the MSL
  import Modelica.Units.SI;
  /*
  // Rigid body mechanics
  SI.Height eta  "Wave elevation";
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
  SI.AngularVelocity omega = sensor_bus.omega "Shaft angular velocity";
  SI.Torque T "Shaft torque";
  
  // Electrial dynamics
  SI.Voltage Va "Voltage of A phase";
  SI.Voltage Vb "Voltage of B phase";
  SI.Voltage Vc "Voltage of C phase";
  
  SI.Current ia "Current of A phase";
  SI.Current ib "Current of B phase";
  SI.Current ic "Current of C phase";
  */
  
  SI.Height eta "Wave elevation";
  SI.Force Fpto "PTO force";
  SI.Force Fexc "Excitation force";
  SI.Volume D "Motor displacement";
  
  // Double acting cylinder parameters
  /*
  
  SI.Force Fpto "PTO force";
  SI.Force Finer "Inertial force";
  SI.Force FgravIner "Gravity component 1of the inertial force";
  SI.Force FflIner "Fluid inertia component of the inertial force";
  SI.Force Ffric "Friction force";
  
  // Power
  SI.Power Pcyl_mech "Mechanical power in the cylinder";
  SI.Power Pcyl_hyd "Hydraulic power in the cylinder";
  
  // Energy
  SI.Energy Ecyl_mech "Mechanical power in the cylinder";
  SI.Energy Ecyl_hyd "Hydraulic power in the cylinder";
  
  
  */
  DAQ_w2w_bus sensor_bus;
  

equation

end DAQ_w2w;
