program pwd_gen;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='kripag';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTFormMain, TFormMain);
  Application.Run;
end.

