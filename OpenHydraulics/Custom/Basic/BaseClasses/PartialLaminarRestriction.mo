within OpenHydraulics.Custom.Basic.BaseClasses;

partial model PartialLaminarRestriction
  // the sizing parameters
  parameter Modelica.Units.SI.Diameter D(final min = 0) = 0.01 "Hydraulic diameter of restriction (for computation of Re)" annotation(
    Dialog(tab = "Sizing"));
  // advanced parameters
  parameter Boolean check_Re = false "true, check whether Re<Re_laminar" annotation(
    Evaluate = true,
    Dialog(tab = "Advanced"));
  parameter Modelica.Units.SI.ReynoldsNumber Re_laminar = 2000 "Boundary of laminar flow regime" annotation(
    Dialog(tab = "Advanced", enable = check_Re));
  // since Re is used only for diagnostics, do not generate events --> noEvent
  Modelica.Units.SI.ReynoldsNumber Re = noEvent(abs(port_a.m_flow))*4/(Modelica.Constants.pi*max(D, 1e-20)*eta) "Reynolds number";
  Modelica.Units.SI.DynamicViscosity eta = 0.036 "Average dynamic viscosity";
  Modelica.Units.SI.Density d = 850 "Average density";
  Types.HydraulicConductance conductance "Hydraulic Conductance of restriction";
  extends Interfaces.HorizontalTwoPort;
equation
  if check_Re and D > 0 then
    assert(Re <= Re_laminar, "Flow is outside laminar region: Re = " + String(Re));
  end if;
// mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";
// pressure vs. flow relationship
// assumes laminar flow
//conductance = Modelica.Constants.pi*D^4*d/(128*eta*L);
algorithm
  port_a.m_flow := conductance*dp;
  annotation(
    Diagram(graphics = {Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}), Line(points = {{-60, 20}, {-44, 14}, {-30, 10}, {-20, 8}, {-6, 6}, {6, 6}, {20, 8}, {30, 10}, {44, 14}, {60, 20}}, color = {0, 0, 0}), Line(points = {{-60, -20}, {-44, -14}, {-30, -10}, {-20, -8}, {-6, -6}, {6, -6}, {20, -8}, {30, -10}, {44, -14}, {60, -20}}, color = {0, 0, 0})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}), Line(points = {{-60, 20}, {-44, 14}, {-30, 10}, {-20, 8}, {-6, 6}, {6, 6}, {20, 8}, {30, 10}, {44, 14}, {60, 20}}, color = {0, 0, 0}), Line(points = {{-60, -20}, {-44, -14}, {-30, -10}, {-20, -8}, {-6, -6}, {6, -6}, {20, -8}, {30, -10}, {44, -14}, {60, -20}}, color = {0, 0, 0})}));
end PartialLaminarRestriction;
