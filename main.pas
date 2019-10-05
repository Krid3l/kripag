unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLProc,
  ExtCtrls;

type

  { TTFormMain }

  TTFormMain = class(TForm)
    ButtonGen: TButton;
    CheckBoxHun: TCheckBox;
    CheckBoxLch: TCheckBox;
    CheckBoxUch: TCheckBox;
    CheckBoxNum: TCheckBox;
    CheckBoxOth: TCheckBox;
    EditCharsLong: TEdit;
    EditPwdField: TEdit;
    EditRangeFrom: TEdit;
    EditRangeTo: TEdit;
    Label1: TLabel;
    LabelMax: TLabel;
    LabelErrMsg: TLabel;
    LabelLength: TLabel;
    LabelHyphen: TLabel;
    LabelAllow: TLabel;
    RadioRange: TRadioButton;
    RadioFixed: TRadioButton;
    procedure ButtonGenClick(Sender: TObject);
    procedure CheckBoxOthChange(Sender: TObject);
    procedure EditCharsLongChange(Sender: TObject);
    procedure EditPwdFieldChange(Sender: TObject);
    procedure EditRangeFromChange(Sender: TObject);
    procedure EditRangeToChange(Sender: TObject);
    procedure LabelMaxClick(Sender: TObject);
    procedure LabelMin(Sender: TObject);
    procedure LabelLengthClick(Sender: TObject);
    procedure LabelHyphenClick(Sender: TObject);
    procedure LabelAllowClick(Sender: TObject);
    procedure RadioRangeChange(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private

  public

  end;

var
  TFormMain: TTFormMain;

implementation

{$R *.lfm}

{ TTFormMain }

procedure TTFormMain.ButtonGenClick(Sender: TObject);
type
  { Custom data types definitions }
  OptionsArray = Array [0..4] of Boolean;
var
  optvals: OptionsArray; { Holds all the checkbox's states }
  minLen, maxLen, actualLen, i: Shortint;
  pwd, pwdChars, toAdd: String;
  randomInt, tstiOutput: Integer;
begin
  LabelErrMsg.Caption := ''; { Recieves a value later if something goes wrong }
  pwd := '';
  pwdChars := '';
  toAdd := '';
  Randomize(); { Initialize the random number generator }
  optvals[0] := CheckBoxLch.Checked;
  optvals[1] := CheckBoxUch.Checked;
  optvals[2] := CheckBoxNum.Checked;
  optvals[3] := CheckBoxHun.Checked;
  optvals[4] := CheckBoxOth.Checked;
  For i := 0 to Length(optvals) do
  begin
    If optvals[i] then
      Case i of
        0 : toAdd := 'abcdefghijklmnopqrstuvwxyz';
        1 : toAdd := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        2 : toAdd := '0123456789';
        3 : toAdd := '-_';
        4 : toAdd := '!#%$&@';
      end;
      pwdChars := pwdChars + toAdd;
    { end if }
  end;
  If RadioRange.Checked then
    begin
      { Checks if either of the min or max password length fields are empty }
      If not TryStrToInt(EditRangeFrom.Text, tstiOutput) or not TryStrToInt(EditRangeTo.Text, tstiOutput) then
        begin
          LabelErrMsg.Caption := 'Please specify a min and a max character amount.';
          exit();
        end;
      minLen := StrToInt(EditRangeFrom.Text);
      maxLen := StrToInt(EditRangeTo.Text);
      If minLen <> maxLen then
        begin
          { Password length is a random number between the min and max lengths }
          actualLen := Random(maxLen - minLen) + minLen;
        end
      else
        begin
          actualLen := minLen;
        end
    end
  else if RadioFixed.Checked then
    begin
      { Checks if a fixed password length was indeed specified }
      if not TryStrToInt(EditCharsLong.Text, tstiOutput) then
        begin
          LabelErrMsg.Caption := 'Please specify a fixed character amount.';
          exit();
        end;
      actualLen := StrToInt(EditCharsLong.Text);
    end;
  { end if }
  randomInt := 0;
  For i := 0 to (actualLen - 1) do
  begin
    randomInt := Random(Length(pwdChars)) + 1;
    { Adds a random char from the user-specified char pool to the password }
    pwd := pwd + pwdChars[randomInt];
  end;
  { Outputs the generated password }
  EditPwdField.Text := pwd;
end;

procedure checkLength(editElm: TEdit);
var
  pwdLen, tstiOutput: Integer;
begin
  if not TryStrToInt(editElm.Text, tstiOutput) then
    begin
      editElm.Text := '1';
    end
  else
  begin
    pwdLen := StrToInt(editElm.Text);
    if pwdLen <= 0 then
    begin
         editElm.Text := '1';
    end
    else if pwdLen > 64 then
    begin
         editElm.Text := '64';
    end;
  end;
end;

procedure checkFromAndTo(editFrom: TEdit; editTo: TEdit);
var
  tstiOutput: Integer;
begin
  if not TryStrToInt(editFrom.Text, tstiOutput) then
    begin
      editFrom.Text := '1';
    end;
  if not TryStrToInt(editTo.Text, tstiOutput) then
    begin
      editTo.Text := '1';
    end;
  if StrToInt(editFrom.Text) > StrToInt(editTo.Text) then
    begin
      editFrom.Text := editTo.Text;
    end
end;

procedure TTFormMain.CheckBoxOthChange(Sender: TObject);
begin

end;

procedure TTFormMain.EditCharsLongChange(Sender: TObject);
begin
  checkLength(EditCharsLong);
end;

procedure TTFormMain.EditPwdFieldChange(Sender: TObject);
begin

end;

procedure TTFormMain.EditRangeFromChange(Sender: TObject);
begin
  checkLength(EditRangeFrom);
  checkFromAndTo(EditRangeFrom, EditRangeTo);
end;

procedure TTFormMain.EditRangeToChange(Sender: TObject);
begin
  checkLength(EditRangeTo);
  checkFromAndTo(EditRangeFrom, EditRangeTo);
end;

procedure TTFormMain.LabelMaxClick(Sender: TObject);
begin

end;

procedure TTFormMain.LabelMin(Sender: TObject);
begin

end;

procedure TTFormMain.LabelLengthClick(Sender: TObject);
begin

end;

procedure TTFormMain.LabelHyphenClick(Sender: TObject);
begin

end;

procedure TTFormMain.LabelAllowClick(Sender: TObject);
begin

end;

procedure TTFormMain.RadioRangeChange(Sender: TObject);
begin

end;

procedure TTFormMain.RadioGroup1Click(Sender: TObject);
begin

end;

end.

