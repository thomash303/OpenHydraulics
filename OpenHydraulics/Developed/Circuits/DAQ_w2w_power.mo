within OpenHydraulics.Developed.Circuits;

model DAQ_w2w_power

  // Importing from the MSL
  import Modelica.Units.SI;
  
  SI.Height eta "Wave elevation";
  //SI.Force Fpto "PTO force";
  SI.Force Fexc "Excitation force";
  SI.Volume D "Motor displacement";
  
  // Environment
  SI.Power Pwav "Wave power";
  
  
  // Double acting cylinder parameters
  
  
  SI.Force Fpto "PTO force";
  SI.Force Finer "Inertial force";
  SI.Force FgravIner "Gravity component 1of the inertial force";
  SI.Force FflIner "Fluid inertia component of the inertial force";
  SI.Force FpistIner "Inertia of the piston and rod";
  SI.Force Ffric "Friction force";
  
  // Power
  SI.Power Pcyl_mech "Mechanical power in the cylinder";
  SI.Power Pcyl_hyd "Hydraulic power in the cylinder";
  
  // Energy
  SI.Energy Ecyl_mech "Mechanical power in the cylinder";
  SI.Energy Ecyl_hyd "Hydraulic power in the cylinder";
  
  // Efficiency
  //Real cylEff "Cylinder efficiency";
  
  
  
  
  // Valve parameters
  /*
  SI.Power P_T "Hydraulic power at valve high-pressure outlet";
  SI.Energy E_T "Hydraulic energy at valve high-pressure outlet";
  */
  
  // Pipe loss parameter template
  /*
  Real pipeHPEff "Efficiency of high pressure pipe";
  */
  
  // Pump/motor parameters
  
  // Power, energy, and efficiency
  //SI.Power Pmot_hyd "Hydraulic pump/motor power";
  SI.Power Pmot_mech "Mechanical pump/motor power";
  
  //SI.Energy Emot_hyd "Hydraulic pump/motor energy";
  SI.Energy E_mech "Mechanical pump/motor energy";
  
  //Real motEff "Pump/motor efficiency";
  
  // Generator parameters
  SI.Power Pelec "Electrical (output) power";
  SI.Energy Eelec "Electrical (output) energy";
  
  SI.Power Pgen_fric "Generator friction loss power";
  SI.Power Pgen_cop "Generator copper loss power";  
  SI.Power Pgen_mech "Generator mechanical power";

  
  DAQ_w2w_bus sensor_bus;
  

equation

  der(Eelec) = Pelec;

end DAQ_w2w_power;
