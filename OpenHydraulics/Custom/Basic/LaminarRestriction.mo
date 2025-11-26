within OpenHydraulics.Custom.Basic;

model LaminarRestriction
  // the sizing parameters
  parameter Modelica.Units.SI.Length L(final min = 0) "Length of restriction" annotation(
    Dialog(tab = "Sizing"));
  extends BaseClasses.PartialLaminarRestriction;
equation
  conductance = Modelica.Constants.pi*D^4*d/(128*eta*L);
end LaminarRestriction;
