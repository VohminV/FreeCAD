program FreeCAD;

uses
  System.StartUpCopy,
  FMX.Forms,
  f_Main in 'f_Main.pas' {fMain},
  f_Simulation in 'f_Simulation.pas' {fSimulation};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfSimulation, fSimulation);
  Application.Run;
end.
