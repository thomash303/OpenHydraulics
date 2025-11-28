within OpenHydraulics.Developed.Interfaces.BaseClasses;

partial model NPort "Two horizontally oriented fluid ports"

  // include the base characteristics for ANY fluid two-port
  extends PartialFluidComponent;
  
  // Import from the MSL
  import Modelica.Units.SI;
  
  // Port connects
  parameter Integer n_ports(min = 1) "Number of ports (min=1)" annotation(
    Dialog(tab = "Sizing"));
  FluidPort port[n_ports](m_flow(each start = 0), p(each start = p_init)) annotation(
    Placement(transformation(extent = {{-10, -11}, {10, 10}})));
  
  // Media properties
  SI.AbsolutePressure p[n_ports](each start = p_init) "Media properties at each port";
equation
  for i in 1:n_ports loop
  // Set the fluid properties (set two state variable for each instance of medium)
    p[i] = port[i].p;
  end for;
end NPort;
