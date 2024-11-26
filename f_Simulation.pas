unit f_Simulation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Viewport3D,
  System.Math.Vectors, FMX.Controls3D, FMX.Types3D, FMX.Objects3D, FMX.Objects;

type
  TfSimulation = class(TForm)
    Viewport3D: TViewport3D;
    Camera: TCamera;
    Light: TLight;
    Model3D: TModel3D;
    Sphere: TSphere;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadGCode(GCode: TStringList);
    procedure ParseGCodeToViewport(GCode: TStringList; Viewport: TViewport3D);
  end;

var
  fSimulation: TfSimulation;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure TfSimulation.LoadGCode(GCode: TStringList);
begin
  ParseGCodeToViewport(GCode, Viewport3D);
end;

procedure TfSimulation.ParseGCodeToViewport(GCode: TStringList; Viewport: TViewport3D);
var
  i: Integer;
  Line: string;
  X, Y, Z: Single;
  LastX, LastY, LastZ: Single;
  Cylinder: TCylinder;
  Direction: TPoint3D;
  Distance: Single;
  RotationAngle: Single;
  RotationVector: TPosition3D;
begin
  // Initial position
  LastX := 0;
  LastY := 0;
  LastZ := 0;

  for i := 0 to GCode.Count - 1 do
  begin
    Line := Trim(GCode[i]);

    // Skip comments and empty lines
    if (Line = '') or (Line[1] = ';') then
      Continue;

    // Process G0 or G1 commands
    if Line.StartsWith('G0') or Line.StartsWith('G1') then
    begin
      X := LastX;
      Y := LastY;
      Z := LastZ;

      // Extract coordinates from the GCode line
      if Pos('X', Line) > 0 then
        X := StrToFloatDef(Copy(Line, Pos('X', Line) + 1, 10), LastX);
      if Pos('Y', Line) > 0 then
        Y := StrToFloatDef(Copy(Line, Pos('Y', Line) + 1, 10), LastY);
      if Pos('Z', Line) > 0 then
        Z := StrToFloatDef(Copy(Line, Pos('Z', Line) + 1, 10), LastZ);

      // Calculate direction and distance
      Direction := Point3D(X, Y, Z) - Point3D(LastX, LastY, LastZ);
      Distance := Direction.Length;

      // Create cylinder (used as a line)
      Cylinder := TCylinder.Create(Viewport);
      Cylinder.Parent := Viewport;
      Cylinder.Height := Distance;
      Cylinder.Depth := 0.1;  // Minimal thickness to look like a line
      Cylinder.Width := 0.1;
      Cylinder.Position.Point := (Point3D(LastX, LastY, LastZ) + Point3D(X, Y, Z)) * 0.5;

      // Calculate the rotation vector
      RotationVector := TPosition3D.Create(Direction);

      // Apply rotation (around the Z axis as an example)
      Cylinder.RotationAngle := RotationVector;

      Cylinder.MaterialSource := nil; // Optionally set a color or material here

      // Update last position
      LastX := X;
      LastY := Y;
      LastZ := Z;
    end;
  end;
end;


end.

