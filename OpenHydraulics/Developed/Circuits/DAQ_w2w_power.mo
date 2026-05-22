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

annotation (
  Icon(
    coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
    graphics={
      Rectangle(
        extent={{-80,60},{80,-60}},
        lineColor={0,0,0},
        fillColor={200,200,200},
        fillPattern=FillPattern.Solid),
        Text(textColor = {0, 0, 255}, extent = {{0, 110}, {0, 74}}, textString = "%name"),
      Text(
        extent={{-60,20},{60,-20}},
        lineColor={0,0,0},
        textString="DAQ",
        fontSize=24),
      Line(points={{-80,30},{-60,30}}, color={0,0,255}),
      Line(points={{-80,10},{-60,10}}, color={0,0,255}),
      Line(points={{-80,-10},{-60,-10}}, color={0,0,255}),
      Line(points={{-80,-30},{-60,-30}}, color={0,0,255}),
      Line(points={{60,30},{80,30}},   color={255,0,0}),
      Line(points={{60,10},{80,10}},   color={255,0,0}),
      Line(points={{60,-10},{80,-10}}, color={255,0,0}),
      Line(points={{60,-30},{80,-30}}, color={255,0,0})
    }),
  Diagram(
    coordinateSystem(extent={{-100,-100},{100,100}}),
    graphics={
      Rectangle(
        extent={{-80,60},{80,-60}},
        lineColor={0,0,0},
        fillColor={230,230,230},
        fillPattern=FillPattern.Solid)
    })
);
end DAQ_w2w_power;
