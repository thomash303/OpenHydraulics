within OpenHydraulics.Custom.Valves;

partial model PartialLaminarRestriction

  // Extending from OpenHydraulics
  extends Custom.Valves.BaseClasses.RestrictionInterface;
  
  // Importing from the MSL
  import Modelica.Units.SI;
  import Modelica.Fluid.Types.CvTypes;
  import Modelica.Fluid.Valves.BaseClasses.valveCharacteristic;
  import Modelica.Blocks.{Interfaces,Continuous};
  import Modelica.Constants.pi;


  // the sizing parameters
  parameter SI.Diameter D(final min = 0) = 0.01 "Hydraulic diameter of restriction (for computation of Re)" annotation(
    Dialog(tab = "Sizing"));
  
  // Reynold's number condition
  parameter Boolean check_Re = false "true, check whether Re<Re_laminar" annotation(
    Evaluate = true,
    Dialog(tab = "Advanced"));
  parameter SI.ReynoldsNumber Re_laminar = 2000 "Boundary of laminar flow regime" annotation(
    Dialog(tab = "Advanced", enable = check_Re));
  // since Re is used only for diagnostics, do not generate events --> noEvent
  SI.ReynoldsNumber Re = noEvent(abs(port_a.m_flow))*4/(Modelica.Constants.pi*max(D, 1e-20)*eta_avg) "Reynolds number";
  
  // Variable averages
  SI.DynamicViscosity eta_avg = (oil.dynamicViscosity(p_a) + oil.dynamicViscosity(p_b))/2 "Average dynamic viscosity";
  SI.Density rho_avg = (oil.density(p_a) + oil.density(p_b))/2 "Average density";
  
  // Brought from VariableRestrictionSeriesValve to then inherit
  parameter SI.Pressure dp_nom =1e6 "Nominal pressure drop" annotation(
    Dialog(tab = "Nominal operating point"));
  parameter SI.MassFlowRate m_flow_nom = 0.85 "Nominal operating point"
  annotation(Dialog(group="Nominal operating point"));    
   
  // This one needs care, should get inherited from fluid properties
  parameter SI.Density rho_nom=850
    "Nominal inlet density"
  annotation(Dialog(group="Nominal operating point",
                    enable = (CvData==CvTypes.OpPoint)));
                    
  // Modifications from the MSL
  parameter CvTypes CvData=CvTypes.OpPoint
    "Selection of flow coefficient"
   annotation(Dialog(group = "Flow coefficient"));
  parameter SI.Area Av(
    fixed= CvData == CvTypes.Av,
    start=m_flow_nom/(sqrt(rho_nom*dp_nom))*valveCharacteristic(
        opening_nom)) "Av (metric) flow coefficient"
   annotation(Dialog(group = "Flow coefficient",
                     enable = (CvData==CvTypes.Av)));
  parameter Real Kv = 0 "Kv (metric) flow coefficient [m3/h]"
  annotation(Dialog(group = "Flow coefficient",
                    enable = (CvData==CvTypes.Kv)));
  parameter Real Cv = 0 "Cv (US) flow coefficient [USG/min]"
  annotation(Dialog(group = "Flow coefficient",
                    enable = (CvData==CvTypes.Cv)));  
  
  
  parameter Real opening_nom(min=0,max=1)=1 "Nominal opening"
  annotation(Dialog(group="Nominal operating point",
                    enable = (CvData==CvTypes.OpPoint)));
  parameter Boolean filteredOpening=false
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(group="Filtered opening"),choices(checkBox=true));
  parameter SI.Time riseTime=1
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation(Dialog(group="Filtered opening",enable=filteredOpening));
  parameter Real leakageOpening(min=0,max=1)=1e-3
    "The opening signal is limited by leakageOpening (to improve the numerics)"
    annotation(Dialog(group="Filtered opening",enable=filteredOpening)); 
 
  replaceable function valveCharacteristic =
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.linear
    constrainedby
    Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
    "Inherent flow characteristic"
    annotation(choicesAllMatching=true);

public
  constant SI.Area Kv2Av = 27.7e-6 "Conversion factor";
  constant SI.Area Cv2Av = 24.0e-6 "Conversion factor";

  Interfaces.RealInput opening(min=0, max=1)
    "Valve position in the range 0..1"
                                   annotation (Placement(transformation(
        origin={0,90},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));

  Interfaces.RealOutput opening_filtered if filteredOpening
    "Filtered valve position in the range 0..1"
    annotation (Placement(transformation(extent={{60,40},{80,60}}),
        iconTransformation(extent={{60,50},{80,70}})));

  Continuous.Filter filter(order=2, f_cut=5/(2*pi
        *riseTime)) if filteredOpening
    annotation (Placement(transformation(extent={{34,44},{48,58}})));

protected
  Interfaces.RealOutput opening_actual
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
    
  MinLimiter minLimiter(uMin=leakageOpening)
    annotation (Placement(transformation(extent={{10,44},{24,58}})));
    
  parameter SI.Pressure dp_small=if system.use_eps_Re then dp_nom/m_flow_nom*m_flow_small else system.dp_small
    "Regularisation of zero flow"
   annotation(Dialog(tab="Advanced"));
initial equation
  if CvData == CvTypes.Kv then
    Av = Kv*Kv2Av "Unit conversion";
  elseif CvData == CvTypes.Cv then
    Av = Cv*Cv2Av "Unit conversion";
  end if;   
   
equation
  if check_Re and D > 0 then
    assert(Re <= Re_laminar, "Flow is outside laminar region: Re = " + String(Re));
  end if;
// mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

  connect(filter.y, opening_filtered) annotation (Line(
      points={{48.7,51},{60,51},{60,50},{70,50}}, color={0,0,127}));

  if filteredOpening then
     connect(filter.y, opening_actual);
  else
     connect(opening, opening_actual);
  end if;

  connect(minLimiter.y, filter.u) annotation (Line(
      points={{24.7,51},{32.6,51}}, color={0,0,127}));
  connect(minLimiter.u, opening) annotation (Line(
      points={{8.6,51},{0,51},{0,90}}, color={0,0,127}));
  
  annotation(
    Diagram(graphics = {Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}), Line(points = {{-60, 20}, {-44, 14}, {-30, 10}, {-20, 8}, {-6, 6}, {6, 6}, {20, 8}, {30, 10}, {44, 14}, {60, 20}}, color = {0, 0, 0}), Line(points = {{-60, -20}, {-44, -14}, {-30, -10}, {-20, -8}, {-6, -6}, {6, -6}, {20, -8}, {30, -10}, {44, -14}, {60, -20}}, color = {0, 0, 0})}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}), Line(points = {{-60, 20}, {-44, 14}, {-30, 10}, {-20, 8}, {-6, 6}, {6, 6}, {20, 8}, {30, 10}, {44, 14}, {60, 20}}, color = {0, 0, 0}), Line(points = {{-60, -20}, {-44, -14}, {-30, -10}, {-20, -8}, {-6, -6}, {6, -6}, {20, -8}, {30, -10}, {44, -14}, {60, -20}}, color = {0, 0, 0})}));
end PartialLaminarRestriction;
