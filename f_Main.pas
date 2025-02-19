unit f_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo, f_Simulation;

type
  TfMain = class(TForm)
    ProgressBar: TProgressBar;
    MemoGCode: TMemo;
    Panel1: TPanel;
    SaveGCode: TButton;
    LoadGCode: TButton;
    OpenDialogGCode: TOpenDialog;
    btnOpenSimulation: TButton;
    procedure LoadGCodeClick(Sender: TObject);
    procedure SaveGCodeClick(Sender: TObject);
    procedure btnOpenSimulationClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure TfMain.btnOpenSimulationClick(Sender: TObject);
var
  SimulationForm: TfSimulation;
  GCode: TStringList;
begin
  GCode := TStringList.Create;
  try
    // Assign the memo's lines to the TStringList
    GCode.Assign(MemoGCode.Lines);
    // Create the SimulationForm object
    SimulationForm := TfSimulation.Create(Self);  // Create the form before using it
    // Now you can use GCode as a TStringList (e.g., pass it to LoadGCode)
    SimulationForm.LoadGCode(GCode);
    // Show the form
    SimulationForm.Show;
  finally
    GCode.Free;
  end;
end;


procedure TfMain.LoadGCodeClick(Sender: TObject);
var
  GCodeFile: TStringList;
  FilteredGCode: TStringList;
  i: Integer;
  Line: string;
begin
  OpenDialogGCode.Filter := 'G-Code Files (*.gcode;*.nc)|*.gcode;*.nc|All Files (*.*)|*.*';
  ProgressBar.Min:=0;
  if OpenDialogGCode.Execute then
  begin
    GCodeFile := TStringList.Create;
    FilteredGCode := TStringList.Create;
    try
      GCodeFile.LoadFromFile(OpenDialogGCode.FileName);
      ProgressBar.Max:= GCodeFile.Count;
      for i := 0 to GCodeFile.Count - 1 do
      begin
        Line := Trim(GCodeFile[i]);
        // ���������� ������ ������ � ������ � ������� �������������
        if (Line = '') or (Line[1] = ';') then
          Continue;
        // ������� ����������� (����� ����� `;`)
        if Pos(';', Line) > 0 then
          Line := Trim(Copy(Line, 1, Pos(';', Line) - 1));
        // ��������� ������ ��������� ������
        if Line <> '' then
          FilteredGCode.Add(Line);
        ProgressBar.Value:= ProgressBar.Value+1;
      end;
      // ���������� ��������� G-���
      MemoGCode.Lines := FilteredGCode;
      ShowMessage('���� ������� �������� � ������ �� ������������.');
      ProgressBar.Value:=0;
    except
      on E: Exception do
        ShowMessage('������: ' + E.Message);
    end;
    GCodeFile.Free;
    FilteredGCode.Free;
  end;
end;

procedure TfMain.SaveGCodeClick(Sender: TObject);
begin
  OpenDialogGCode.Filter := 'G-Code Files (*.gcode;*.nc)|*.gcode;*.nc|All Files (*.*)|*.*';

  if OpenDialogGCode.Execute then
  begin
    try
      MemoGCode.Lines.SaveToFile(OpenDialogGCode.FileName);
      ShowMessage('���� G-���� ������� �������� � ' + OpenDialogGCode.FileName);
    except
      on E: Exception do
        ShowMessage('������ ��� ���������� �����: ' + E.Message);
    end;
  end;
end;

end.
