within OpenHydraulics.Developed.Circuits;

model DAQ


  import Modelica.Blocks.Interfaces.RealInput;
  import Modelica.Units.SI;
  
    
  RealInput P1;
  RealInput P2;
  RealInput P3;
  RealInput P4;
  RealInput P5;
  RealInput P6;
  RealInput F1;
  RealInput F2;

  SI.Pressure p1 = P1;
  SI.Pressure p2 = P2;
  SI.Pressure p3 = P3;
  SI.Pressure p4 = P4;
  SI.Pressure p5 = P5;
  SI.Pressure p6 = P6;
  
  SI.MassFlowRate f1 = F1;
  SI.MassFlowRate f2 = F2;
  
  SI.Density rho = 850;
  SI.VolumeFlowRate q1 = f1/rho;
  SI.VolumeFlowRate q2 = f2/rho;
  
  Real qL1 = q1 * 1000 * 60;
  Real qL2 = q2 * 1000 * 60;
  

equation

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

end DAQ;
