within OpenHydraulics.Developed.Circuits;

model DAQ


  import Modelica.Blocks.Interfaces.RealInput;
  import Modelica.Units.SI;
  
  RealInput P1 annotation(
    Placement(transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-108, 82}, extent = {{-20, -20}, {20, 20}})));
  RealInput P2 annotation(
    Placement(transformation(origin = {-120, 46}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 44}, extent = {{-20, -20}, {20, 20}})));
  RealInput P3 annotation(
    Placement(transformation(origin = {-120, 16}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, 10}, extent = {{-20, -20}, {20, 20}})));
  RealInput P4 annotation(
    Placement(transformation(origin = {-120, -22}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, -18}, extent = {{-20, -20}, {20, 20}})));
  RealInput P5 annotation(
    Placement(transformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-112, -66}, extent = {{-20, -20}, {20, 20}})));
  RealInput P6 annotation(
    Placement(transformation(origin = {-120, -88}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-110, -84}, extent = {{-20, -20}, {20, 20}})));
  RealInput F1 annotation(
    Placement(transformation(origin = {120, 50}, extent = {{20, -20}, {-20, 20}}, rotation = -0), iconTransformation(origin = {124, 40}, extent = {{-20, -20}, {20, 20}})));
  RealInput F2 annotation(
    Placement(transformation(origin = {122, -50}, extent = {{20, -20}, {-20, 20}}, rotation = -0), iconTransformation(origin = {132, -60}, extent = {{-20, -20}, {20, 20}})));

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

end DAQ;
