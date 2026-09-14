unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, WinApi.ShellAPI, System.IniFiles,
  Vcl.StdCtrls, Vcl.FileCtrl, System.StrUtils, System.IOUtils, System.Types,
  Vcl.Menus, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    OpenDialog2: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Clear1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox1: TListBox;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    ComboBox2: TComboBox;
    GroupBox4: TGroupBox;
    ComboBox1: TComboBox;
    Button8: TButton;
    CheckBox12: TCheckBox;
    GroupBox1: TGroupBox;
    ComboBox4: TComboBox;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    ScrollBar1: TScrollBar;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Panel1: TPanel;
    Label4: TLabel;
    Label1: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    GroupBox2: TGroupBox;
    ComboBox5: TComboBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    GroupBox6: TGroupBox;
    Edit1: TEdit;
    ComboBox6: TComboBox;
    Label6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox7: TComboBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    ComboBox8: TComboBox;
    Label15: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox21: TCheckBox;
    ComboBox9: TComboBox;
    SpinEdit1: TSpinEdit;
    Label7: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    TabSheet3: TTabSheet;
    HeaderControl1: THeaderControl;
    Image1: TImage;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ProgressBar1: TProgressBar;
    ClearafterProgress1: TMenuItem;
    Open1: TMenuItem;
    N2: TMenuItem;
    Remove1: TMenuItem;
    Properties1: TMenuItem;
    N3: TMenuItem;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox20Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label20MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label20MouseLeave(Sender: TObject);
    procedure Label21Click(Sender: TObject);
    procedure Label21MouseLeave(Sender: TObject);
    procedure Label21MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label27Click(Sender: TObject);
    procedure Label27MouseLeave(Sender: TObject);
    procedure Label27MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    flbHorzScrollWidth: Integer;
    procedure FolderContent(const FolderPath: string); // get folder content
    procedure WMDROPFILES(var Msg: TMessage);  // drop files & folders
    procedure LBWindowProc(var Message: TMessage);
    procedure AddFile(sFileName: string);     // add files ti ListBox
  public
    { Public declarations }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  app, path : string;
  TIF : TIniFile;
  zip : string;
  OldLBWindowProc: TWndMethod;

implementation

{$R *.dfm}

// get application MainPath
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   // create options folder when not exists
   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
    WriteInteger(OPT,'Compressor',ComboBox1.ItemIndex);
    WriteInteger(OPT,'Priority',ComboBox2.ItemIndex);
    WriteInteger(OPT,'CompressMode',ComboBox3.ItemIndex);
    WriteInteger(OPT,'CompressLevel', Scrollbar1.Position);
    WriteInteger(OPT,'Format',ComboBox4.ItemIndex);
    WriteInteger(OPT,'CharsetFiles',ComboBox5.ItemIndex);
    WriteInteger(OPT,'CPUMulti',ComboBox6.ItemIndex);
    WriteInteger(OPT,'CharsetConsole',ComboBox7.ItemIndex);
    WriteInteger(OPT,'CPUCores',ComboBox8.ItemIndex);
    WriteInteger(OPT,'VolumeMeasurement',ComboBox9.ItemIndex);
    WriteBool(OPT,'Volume',CheckBox21.Checked);
    WriteInteger(OPT,'VolumeSize',SpinEdit1.Value);
    WriteBool(OPT,'Keep',CheckBox1.Checked);
    WriteBool(OPT,'Force',CheckBox2.Checked);
    WriteBool(OPT,'Verbose',CheckBox3.Checked);
    WriteBool(OPT,'Status',CheckBox4.Checked);
    WriteBool(OPT,'Quiet',CheckBox5.Checked);
    WriteBool(OPT,'Trailing',CheckBox6.Checked);
    WriteBool(OPT,'Recompress',CheckBox7.Checked);
    WriteBool(OPT,'CaseMode',CheckBox8.Checked);
    WriteBool(OPT,'ArchiveName',CheckBox9.Checked);
    WriteBool(OPT,'FileError',CheckBox10.Checked);
    WriteBool(OPT,'LastAccess',CheckBox11.Checked);
    WriteBool(OPT,'Console',CheckBox12.Checked);
    WriteBool(OPT,'SharedFiles',CheckBox13.Checked);
    WriteBool(OPT,'TimeStamp',CheckBox14.Checked);
    WriteBool(OPT,'Wildcard',CheckBox15.Checked);
    WriteBool(OPT,'Duplication',CheckBox16.Checked);
    WriteBool(OPT,'Overwrite',CheckBox17.Checked);
    WriteBool(OPT,'UseFullPath',CheckBox18.Checked);
    WriteBool(OPT,'Recurse',CheckBox19.Checked);
    WriteBool(OPT,'DeleteFiles',CheckBox20.Checked);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      Combobox1.ItemIndex:=ReadInteger(OPT,'Compressor',ComboBox1.ItemIndex);
      Combobox2.ItemIndex:=ReadInteger(OPT,'Priority',ComboBox2.ItemIndex);
      Combobox3.ItemIndex:=ReadInteger(OPT,'CompressMode',ComboBox3.ItemIndex);
      Scrollbar1.Position:=ReadInteger(OPT,'CompressLevel',Scrollbar1.Position);
      Combobox4.ItemIndex:=ReadInteger(OPT,'Format',ComboBox4.ItemIndex);
      Combobox5.ItemIndex:=ReadInteger(OPT,'CharsetFiles',ComboBox5.ItemIndex);
      Combobox6.ItemIndex:=ReadInteger(OPT,'CPUMulti',ComboBox6.ItemIndex);
      Combobox7.ItemIndex:=ReadInteger(OPT,'CharsetConsole',ComboBox7.ItemIndex);
      Combobox8.ItemIndex:=ReadInteger(OPT,'CPUCores',ComboBox8.ItemIndex);
      Combobox9.ItemIndex:=ReadInteger(OPT,'VolumeMeasurement',ComboBox9.ItemIndex);
      CheckBox21.Checked:=ReadBool(OPT,'Volume',CheckBox21.Checked);
      SpinEdit1.Value:=ReadInteger(OPT,'VolumeSize',SpinEdit1.Value);
      CheckBox1.Checked:=ReadBool(OPT,'Keep',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'Force',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'Verbose',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'Status',CheckBox4.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'Quiet',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'Trailing',CheckBox6.Checked);
      CheckBox7.Checked:=ReadBool(OPT,'Recompress',CheckBox7.Checked);
      CheckBox8.Checked:=ReadBool(OPT,'CaseMode',CheckBox8.Checked);
      CheckBox9.Checked:=ReadBool(OPT,'ArchiveName',CheckBox9.Checked);
      CheckBox10.Checked:=ReadBool(OPT,'FileError',CheckBox10.Checked);
      CheckBox11.Checked:=ReadBool(OPT,'LastAccess',CheckBox11.Checked);
      CheckBox12.Checked:=ReadBool(OPT,'Console',CheckBox12.Checked);
      CheckBox13.Checked:=ReadBool(OPT,'SharedFiles',CheckBox13.Checked);
      CheckBox14.Checked:=ReadBool(OPT,'TimeStamp',CheckBox14.Checked);
      CheckBox15.Checked:=ReadBool(OPT,'Wildcard',CheckBox15.Checked);
      CheckBox16.Checked:=ReadBool(OPT,'Duplication',CheckBox16.Checked);
      CheckBox17.Checked:=ReadBool(OPT,'Overwrite',CheckBox17.Checked);
      CheckBox18.Checked:=ReadBool(OPT,'UseFullPath',CheckBox18.Checked);
      CheckBox19.Checked:=ReadBool(OPT,'Recurse',CheckBox19.Checked);
      CheckBox20.Checked:=ReadBool(OPT,'DeleteFiles',CheckBox20.Checked);
      Free;
    end;
  end;
end;

// execute windows file properties dialog
procedure PropertiesDialog(const aFilename: string);
var
  sei: ShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.lpFile := PChar(aFilename);
  sei.lpVerb := 'properties';
  sei.fMask  := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@sei);
end;

// remove items from list
procedure TForm1.Remove1Click(Sender: TObject);
var
  I : Integer;
begin
  ListBox1.Items.BeginUpdate; // Prevents the UI from flickering
  try
    for I := ListBox1.Items.Count - 1 downto 0 do
    begin
      if ListBox1.Selected[I] then
        ListBox1.Items.Delete(I);
    end;
  finally
    StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
    ListBox1.Items.EndUpdate; // Re-enables UI rendering
  end;
end;

procedure TForm1.AddFile(sFileName: string);
begin
  ListBox1.Items.Add(sFilename);
end;

procedure TForm1.Label20Click(Sender: TObject);
begin
  if shellexecute(handle,'open','https://github.com/?locale=de-de',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label20MouseLeave(Sender: TObject);
begin
  Label20.Font.Color := clBlack;
   Label20.Font.Style := [];
end;

procedure TForm1.Label20MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label20.Font.Color := clBlue;
   Label20.Font.Style := [fsUnderline];
end;

procedure TForm1.Label21Click(Sender: TObject);
begin
  if shellexecute(handle,'open','https://www.7-zip.org/',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label21MouseLeave(Sender: TObject);
begin
  Label21.Font.Color := clBlack;
   Label21.Font.Style := [];
end;

procedure TForm1.Label21MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label21.Font.Color := clBlue;
   Label21.Font.Style := [fsUnderline];
end;

procedure TForm1.Label27Click(Sender: TObject);
begin
  if shellexecute(handle,'open','https://www.7-zip.org/support.html',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label27MouseLeave(Sender: TObject);
begin
  Label27.Font.Color := clBlack;
   Label27.Font.Style := [];
end;

procedure TForm1.Label27MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label27.Font.Color := clBlue;
   Label27.Font.Style := [fsUnderline];
end;

procedure TForm1.LBWindowProc(var Message: TMessage);
begin
  if Message.Msg = WM_DROPFILES then
    WMDROPFILES(Message); // handle WM_DROPFILES message
  OldLBWindowProc(Message);
  // call default ListBox1 WindowProc method to handle all other messages
end;

// drag % drop files
procedure TForm1.WMDropFiles(var Msg: TMessage);
var
  DropHandle: HDROP;
  FileCount: Integer;
  I: Integer;
  BufferLen: Integer;
  FileName: string;
begin
  inherited;
  // Das Handle aus der Windows-Nachricht extrahieren
  DropHandle := Msg.WParam;
  try
    // 1. Determine the number of dropped files ($FFFFFFFF signals a request for the count)
    FileCount := DragQueryFile(DropHandle, $FFFFFFFF, nil, 0);
    // Freeze ListBox updates during the loop (speeds up the process)
    ListBox1.Items.BeginUpdate;
    try
      for I := 0 to FileCount - 1 do
      begin
        // 2. Determine the required buffer length for the file name
        BufferLen := DragQueryFile(DropHandle, I, nil, 0);
        if BufferLen > 0 then
        begin
          // Set string length (including placeholder for API null termination)
          SetLength(FileName, BufferLen);
          // 3. Extract the actual path into the string.
          DragQueryFile(DropHandle, I, PChar(FileName), BufferLen + 1);
          // Add file to the ListBox
          ListBox1.Items.Add(FileName);

          zip := ExtractFileDir(FileName);
        end;
      end;
    finally
      ListBox1.Items.EndUpdate;
    end;
  finally
    // 4. Windows signals that the drag-and-drop operation is complete.
    DragFinish(DropHandle);
  end;
end;

// Determine the folder name.
function ExtractDirName(Path:string):string;
var
  i:integer;
begin
  // Check if last Char is \
  if Pos('\', Path[Length(Path)]) = 1 then
    Path:=Copy(Path,1,Length(Path) - 1);
  // ExtractDirName
  for i:=Length(Path) downto 0 do
    if Pos('\', Path[i]) = 1 then
    begin
      Result:=Copy(Path,i+1,Length(Path)-i);
      Exit;
    end;
end;

// Determining the size of the entire folder.
function GetDirectorySize(const Path: string): Int64;
var
  SearchRec: TSearchRec;
  FindResult: Integer;
  SearchPath: string;
begin
  Result := 0;
  { ensures that a path in Delphi always ends with a valid
    separator (such as \ on Windows or / on other systems) }
  SearchPath := IncludeTrailingPathDelimiter(Path);

  // Search for all files and folders
  FindResult := FindFirst(SearchPath + '*.*', faAnyFile, SearchRec);
  try
    while FindResult = 0 do
    begin
      // Ignore specific directories
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      begin
        if (SearchRec.Attr and faDirectory) <> 0 then
        begin
          // If it is a subfolder, call the function recursively.
          Inc(Result, GetDirectorySize(SearchPath + SearchRec.Name));
        end
        else
        begin
          // Add file size to the total sum
          Inc(Result, SearchRec.Size);
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    System.SysUtils.FindClose(SearchRec);
  end;
end;

// Directly loading all files in a folder into the list box
procedure TForm1.FolderContent(const FolderPath: string);
var
  FileName: string;
begin
  ListBox1.Items.Clear;
  for FileName in TDirectory.GetFiles(FolderPath) do
  begin
    ListBox1.Items.Add(FileName); // Adds the full path
    // Or just the filename:
    // ListBox1.Items.Add(ExtractFileName(FileName));
  end;
end;

// Determining whether or not the folder name contains spaces.
function HasSpaceInFolder(const Path: string): Boolean;
var
  FolderName: string;
begin
  // removes the last slash or backslash from a folder path string if it is there
  FolderName := ExtractFileName(ExcludeTrailingPathDelimiter(Path));
  // Here, the specified string is checked—in this case, a space.
  Result := Pos(' ', FolderName) > 0;
end;

// Determine the list of files to be displayed as icons in the list box.
procedure GetAllFilesExtra(List: TStrings);
var
  Search: TSearchRec;
begin
  //Path := ExtractFilePath(ParamStr(0));

  // find all files in folder
  if FindFirst(Path + '*.*', faAnyFile, Search) = 0 then
  try
    repeat
      if (Search.Attr <> faDirectory) and (Search.Name[1] <> '.') then
        // add the files in the listbox
        List.Add(Path + Search.Name);
    until FindNext(Search) <> 0;
  finally
    FindClose(Search);
  end;
end;

// Convert the icon to a bitmap.
procedure IcoToBmpA(Ico: TIcon; Bmp: TBitmap; SmallIcon: Boolean);
var
  WH: Byte; // Width and Height
begin
  with Bmp do
  begin
    // Here, any color can be specified as transparent.
    Canvas.Brush.Color := clFuchsia;
    TransparentColor := clFuchsia;

    // Determine the width and height and draw as a bitmap.
    Width := 16;
    Height := 16;
    Canvas.Draw(0, 0, Ico);

    if SmallIcon then
      WH := 16
    else
      WH := 32;

    // reduce or enlarge to a specific size
    Canvas.StretchDraw(Rect(0, 0, WH, WH), Bmp);
    Width := WH; Height := WH;
    Transparent :=  True;
  end;
end;

// Here, the file's icon is retrieved from shell32.dll.
procedure GetIconFromFileB(const FileName: String; Icon: TIcon;
  SmallIcon: Boolean);
var
  sfi: TSHFILEINFO;
const
  uFlags : array[Boolean] of DWord = (SHGFI_LARGEICON, SHGFI_SMALLICON);
begin
  if SHGetFileInfo(PChar(FileName), 0, sfi, SizeOf(sfi), SHGFI_ICON or
     uFlags[SmallIcon]) <> 0 then
    Icon.Handle := sfi.hIcon;
end;

procedure DrawListBoxExtra(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  { These constants declare a constant or typed array that uses the Boolean
    data type as the index (key) and returns color values of type TColor. }
  Col1: array [Boolean] of TColor = ($00F8F8F8, clWindow);
  Col2: array [Boolean] of TColor = (clInactiveCaptionText, clWindowText);
var
  Icon: TIcon;
  Bmp: TBitmap;
begin
  with (Control as TListbox) do
  begin
    // Create memory access for the icon and bitmap.
    Icon := TIcon.Create;
    Bmp := TBitmap.Create;
    try
      if odSelected in State then
        Canvas.Font.Color := clCaptionText
      else
      begin
        // determine properties
        Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
        Canvas.Brush.Color := Col1[Odd(Index)];
        Canvas.Font.Color := Col2[(Control as TListBox).Enabled];
      end;
      GetIconFromFileB(Items[Index], Icon, True);
      IcoToBmpA(Icon, Bmp, True);
      // Vertical and horizontal spacing between the item strings and the bitmaps
      Canvas.TextRect(Rect, Rect.Left + Bmp.Width + 4, Rect.Top + 2, Items[Index]);
      // Draw the graphics into the list box.
      Canvas.Draw(Rect.Left, Rect.Top, Bmp);
    finally
      Bmp.Free;
      Icon.Free;
    end;
  end;
end;

// compress level setting bar
procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label10.Caption := 'Level  : ' + IntToStr(ScrollBar1.Position);
end;

// Start the help message process and wait until it is finished.
procedure ExecuteHelpmessageAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected process flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble help message command line
  CmdLine := Format('cmd.exe /k "%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  StartupInfo.wShowWindow := SW_NORMAL;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// Start the decompression process and wait until it is finished.
procedure ExecuteDecompressAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble command line
  CmdLine := Format('"%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  if Form1.CheckBox12.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// Start the compression process and wait until it is finished.
procedure ExecuteAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble command line
    CmdLine := Format('"%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  if Form1.CheckBox12.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// precise determination of the file size
function Get_File_Size(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  // check if file exists
  FH := FindFirstFile(PChar(S), FD);
  // check file handle ist value
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

// start compress operation
procedure TForm1.Button1Click(Sender: TObject);
begin
  if SelectDirectory('Select directory', '', path) then
  begin
    {
    // Check if the folder contains spaces.
    if HasSpaceInFolder(path) = true then
    begin
      MessageDlg('The folder you selected has too many spaces.' +chr(10)+
                 'Please select a different folder or rename the folder.',
                 mtInformation, [mbOK], 0);
      Button6.Enabled := false;
      Button7.Enabled := false;
      ListBox1.Clear;
      StatusBar1.Panels[1].Text := '0 kb';
      Exit;    // If so, get out.
    end;
     }
    Button6.Enabled := true;
    Button7.Enabled := true;
    // Add a backslash to the path.
    zip := path;
    path := path + '\';
    ListBox1.Clear;
    GetAllFilesExtra(ListBox1.Items);
    // // Determine the size of the entire folder content.
    StatusBar1.Panels[1].Text := IntToStr( GetDirectorySize(path) div 1000) + '.kb';
  end;
end;

// load folder files for compress operation
procedure TForm1.Button6Click(Sender: TObject);
var
  i : integer;
  parameter, p1, p2 : PChar;
  result, unicode : string;
  volume : string;
  size, multiple, files : integer;
  path : string;
begin
  // If no files have been loaded
  if ListBox1.Items.Count = 0 then
  begin
    MessageDlg('No files found to compress!',mtInformation, [mbOK], 0);
    Exit;
  end;

  // If no files have been selected
  if ListBox1.ItemIndex = -1 then
  begin
    MessageDlg('Select files to compress',mtInformation, [mbOK], 0);
    Exit;
  end;

  // Prompt to delete the files after the compression process, if enabled.
  if CheckBox20.Checked = true then
  begin
    Beep;
    if MessageBox(Handle,'Warning:'+#13+
                'The file deletion function is enabled; all files will be deleted after compression. Are you sure?','Confirm deleting files',MB_YESNO) = IDNO then
    BEGIN
      Exit;
    END;
  end;

  Panel1.SetFocus;
  Screen.Cursor := crHourGlass;

  // clear parameter & switches, this is important to avoid errors.
  Label3.Caption := '';
  parameter := '';

  // Create archive volumes, no spaces may be entered.
  if CheckBox21.Checked = true then
  begin
    case ComboBox9.ItemIndex of
     0 : volume := 'b';  // byte
     1 : volume := 'k';  // kilobyte
     2 : volume := 'm';  // megabyte
     3 : volume := 'g';  // gigabyte
    end;

    size := SpinEdit1.Value;
    Label3.Caption := ' -v' + IntToStr(size) + volume;
  end;

  { ---------------------------------------- parameter flags }
  // compression level settings
  case ComboBox3.ItemIndex of
    0 : begin
          // fastes compress operation
          p1 := parameter;
          unicode := ' -mx1';
          p2 := PChar(unicode);
          result := string(p2) + string(p2);
          parameter := PChar(result);
        end;
    1 : begin
          // best compress operation
          p1 := parameter;
          unicode := ' -mx9';
          p2 := PChar(unicode);
          result := string(p2) + string(p2);
          parameter := PChar(result);
        end;
        // manual setting of the compression process
    2 : begin
          p1 := parameter;
          unicode := ' -mx' + IntToStr(ScrollBar1.Position);
          p2 := PChar(unicode);
          result := string(p2) + string(p2);
          parameter := PChar(result);
        end;
  end;

  // set CPU thread affinity mask (hexadecimal number), the string "-stmF" stands for more
  if ComboBox8.Enabled = true then
  begin
    case ComboBox8.ItemIndex of
    0 : begin
          p1 := parameter;
          p2 := ' -stm1';
          result := string(p1) + string(p2);
          parameter := PChar(result);
        end;
    1 : begin
          p1 := parameter;
          p2 := ' -stm2';
          result := string(p1) + string(p2);
          parameter := PChar(result);
        end;
    2 : begin
          p1 := parameter;
          p2 := ' -stm3';
          result := string(p1) + string(p2);
          parameter := PChar(result);
        end;
    3 : begin
          p1 := parameter;
          p2 := ' -stmF';
          result := string(p1) + string(p2);
          parameter := PChar(result);
        end;
    end;
  end;

  // set output log level
  if CheckBox1.Checked = true then
    Label3.Caption := Label3.Caption + ' -bb3';

  // create archive password
  if Edit1.Text <> '' then
  begin
    Label3.Caption := Label3.Caption + ' -p' + Edit1.Text;
  end;

  // disable progress indicator
  if CheckBox2.Checked = true then Label3.Caption := Label3.Caption + ' -bd';

  // show execution time statistics
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' -bt';

  // set Large Pages mode
  if CheckBox5.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -slp';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // show technical information for l (List) command
  if CheckBox6.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -slt';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // store hard links as links
  if CheckBox7.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -snh';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // switch manages case-sensitive file name matching
  if CheckBox8.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -ssc';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // set Archive name mode
  if CheckBox9.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -saa';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // stop archive creating, if it can't open some input file
  if CheckBox10.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -sse';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // do not change Last Access Time of source files while archiving
  if CheckBox11.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -ssp';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // compress shared files
  if CheckBox13.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -ssw';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // set archive timestamp from the most recently modified file
  if CheckBox14.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -stl';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // disable wildcard matching for file names
  if CheckBox15.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -spd';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // eliminate duplication of root folder for extract command
  if CheckBox16.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -spe';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // switch specifies the Overwrite Mode during extraction
  if CheckBox17.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -aoa';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // Use Full Pathnames
  if CheckBox18.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -spf';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // Recurse subdirectories for name search
  if CheckBox19.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -r';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // Recurse subdirectories for name search
  if CheckBox20.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -sdel';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // Multi-threading usage (multi-core processor usage)
  if ComboBox6.ItemIndex = 0 then
  begin
    p1 := parameter;
    unicode := ' -mmt=' + ComboBox6.Text;
    p2 := PChar(unicode);
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // Parameters that are set automatically
  // set charset for list files
  begin
    p1 := parameter;
    unicode := ' -scs' + ComboBox5.Text;
    p2 := PChar(unicode);
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // set charset for console output
  begin
    p1 := parameter;
    unicode := ' -scc' + ComboBox7.Text;
    p2 := PChar(unicode);
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // assume Yes on all queries - That should always go at the end.
  if CheckBox4.Checked = true then
  begin
    p1 := parameter;
    p2 := ' -y';
    result := string(p1) + string(p2);
    parameter := PChar(result);
  end;

  // Determine the path to "7z.exe".
  case ComboBox1.ItemIndex of
    0 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\7za.exe';
    1 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\x64\7za.exe';
    2 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\arm64\7za.exe';
  end;

  // update statusbar
  StatusBar1.Panels[5].Text := 'wait, compressing';
  // update program
  Application.ProcessMessages;

  // Start the compression folder process and wait until it is finished.
  // All kinds of files are being compressed.
  for i := 0 to ListBox1.Items.Count -1 do
  begin
    try
      if ListBox1.Selected[i] then
      begin
        ProgressBar1.Max := i;

        case ComboBox4.ItemIndex of
          0, 1 : // create *.7z; *.zip; packed multi file/folder archive
          begin ExecuteAndWait(PChar(app), PChar(' a ' +            // main parameter to create archive
                                           Label3.Caption +   // switch parameter functions
                                           ' "' + zip + '\' + ExtractDirName(zip) +  // new archive filename
                                           '.' + ComboBox4.Text + '"' +   // file format
                                           ' "' + ListBox1.Items.Strings[i] + '" ' +
                                           parameter));
          end;


          2 : // create *.tar; packed multi file/folder archive
          ExecuteAndWait(PChar(app), PChar(' a -ttar ' +     // main parameter to create archive
                                             Label3.Caption +   // switch parameter functions
                                             ' "' + zip + '\' + ExtractFileName(ListBox1.Items.Strings[i]) +  // new archive filename
                                             '.' + ComboBox4.Text + '"' +   // file format
                                             ' "' + ListBox1.Items.Strings[i] + '" ' +
                                             parameter));

          3 : // create *.xz packed single archive
          ExecuteAndWait(PChar(app), PChar(' a -txz ' +     // main parameter to create archive
                                             //Label3.Caption +   // switch parameter functions
                                             ' "' + zip + '\' + ExtractFileName(ListBox1.Items.Strings[i]) +  // new archive filename
                                             '.' + ComboBox4.Text + '"' +   // file format
                                             ' "' + ListBox1.Items.Strings[i] + '" ' +
                                             parameter));


          4 : // create *.gzip single archive
          begin
            ExecuteAndWait(PChar(app), PChar(' a -tgzip ' +     // main parameter to create archive
                                             Label3.Caption +   // switch parameter functions
                                             ' "' + zip + '\' + ExtractFileName(ListBox1.Items.Strings[i]) +  // new archive filename
                                             '.' + ComboBox4.Text + '"' +   // file format
                                             ' "' + ListBox1.Items.Strings[i] + '" ' +
                                             parameter));
          end;

          5 : // create *.bzip2 single archive
          begin
            ExecuteAndWait(PChar(app), PChar(' a -tbzip2 ' +    // main parameter to create archive
                                             Label3.Caption +   // switch parameter functions
                                             ' "' + zip + '\' + ExtractFileName(ListBox1.Items.Strings[i]) +  // new archive filename
                                             '.' + ComboBox4.Text + '"' +   // file format
                                             ' "' + ListBox1.Items.Strings[i] + '"' +
                                             parameter));
          end;

        end;  // case of

        // step the ProgressBar
        ProgressBar1.Position := i;

        // update statusbar
        StatusBar1.Panels[5].Text := 'wait, compressing.. ' + IntToStr(i);
        Application.ProcessMessages;
      end;   // selected items end

    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;    // compress loop


  // Determine the new archive size for *.7zip & *.zip
  if (ComboBox4.ItemIndex = 0) or (ComboBox4.ItemIndex = 1) then
  begin
    // Assemble a safe path
    path := zip + '\' + ExtractFileName(zip) + '.' + ComboBox4.Text;
    // Determine the size of the archive content.
    StatusBar1.Panels[3].Text := IntToStr(Get_File_Size(PChar(path)) div 1000) + ' kb';
  end else begin

    // Iterate through all entries in the ListBox
    for multiple := 0 to ListBox1.Items.Count - 1 do
    begin
      // Check whether the current entry is selected.
      if ListBox1.Selected[multiple] then
        try
          // Summing up the archive sizes
          files := files + Get_File_Size(PChar(ListBox1.Items.Strings[multiple])) div 1000;
        except
          on E: Exception do
            ShowMessage(E.Message);
        end;
    end;

    // display the multiple archive size
    StatusBar1.Panels[3].Text := 'Multiple - ' + IntToStr(files) + ' kb';
  end;

  // Show the parameters that were used.
  Label3.Caption := Label3.Caption + parameter;

  // clear list after progress
  if ClearafterProgress1.Checked = true then
  begin
    ListBox1.Clear;
  end else begin
    // Update the contents of the folder in the ListBox if necessary.
    //FolderContent(zip);
  end;

  StatusBar1.Panels[5].Text := 'Compress finish.';
  Screen.Cursor := crDefault;
end;

// folder decompressed opration
procedure TForm1.Button7Click(Sender: TObject);
var
  i : integer;
  mZip,                // file path
  force,               // only filename
  dir,                 // filenpath without to create folpdername suffix
  dirExt,              // filenpath with suffix
  FileName : string;
begin
  if ListBox1.Items.Count = 0 then
  begin
    MessageDlg('No files found to decompress!',mtInformation, [mbOK], 0);
    Exit;
  end;

  // If no files have been selected
  if ListBox1.ItemIndex = -1 then
  begin
    MessageDlg('Select files to decompress',mtInformation, [mbOK], 0);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  // clear parameter string
  Label3.Caption := '';

  // Determine the path to "7zip.exe".
  case ComboBox1.ItemIndex of
    0 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\7za.exe';
    1 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\x64\7za.exe';
    2 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\arm64\7za.exe';
  end;

  StatusBar1.Panels[5].Text := 'wait, decompressing';
  // update program
  Application.ProcessMessages;


  // Start the decompression process and wait until it is finished.
  // Do not remove the "-d" parameter, as it is for decompression operation.
  for i := 0 to ListBox1.Items.Count -1 do
  begin
    if ListBox1.Selected[i] then
    begin
      // get item filename from path
      FileName := ExtractFilename(ListBox1.Items.Strings[i]);

      mZip := ListBox1.Items.Strings[i];
      //FileZip := ExtractDirName(mZip);
      mZip := ExtractFileDir(mZip);
      //Label7.Caption := mZip;

      force := FileName;
      dirExt := PChar(mZip + '\' + force);
      dir := ChangeFileExt(dirExt, '');

      // create options folder when not exists
      if not DirectoryExists(dir) then
      begin
        try
          // create the folder with archive name
          ForceDirectories(dir);
        except
          on E: Exception do
            ShowMessage(E.Message);
        end;
      end;

      // start decompress operation
      ExecuteAndWait(PChar(app), PChar(' x ' +   // decrompress
                                       ' "' + ListBox1.Items.Strings[i] + '"' + // archive path
                                       ' -o"' + dir + '"'));        // compressed path
    end;
  end;

  // Determine the size of the entire folder content.
  StatusBar1.Panels[1].Text := '0 kb';

  // load the new decompressed files
  // This causes an overwrite error if the file already exists.
  //FolderContent(path);

  Screen.Cursor := crDefault;
  StatusBar1.Panels[5].Text := 'Decompress finish.';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  // Determine the path to "*zip.exe".
  case ComboBox1.ItemIndex of
    0 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\7za.exe';
    1 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\x64\7za.exe';
    2 : app := ExtractFilePath(Application.ExeName)+'Data\7zip\arm64\7za.exe';
  end;

  // execute the help console message for selected compressor
  ExecuteHelpmessageAndWait(PChar(app), PChar(' -h '));
  StatusBar1.SetFocus;
end;

// clear all items in the listbox
procedure TForm1.CheckBox20Click(Sender: TObject);
begin
  if CheckBox20.Checked = true then
  begin
    Beep;
    MessageDlg('Warning: This function deletes all files after the compression process.',mtInformation, [mbOK], 0);
  end;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  ListBox1.Clear;
  StatusBar1.Panels[1].Text := '0 kb';
  StatusBar1.Panels[3].Text := '0 kb';
end;

// compress settings
procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  case ComboBox3.ItemIndex of
  0 : begin
        Label10.Enabled := false;       // super fast
        ScrollBar1.Enabled := false;
      end;
  1 : begin
        Label10.Enabled := false;       // best ration
        ScrollBar1.Enabled := false;
      end;
  2 : begin
        Label10.Enabled := true;        // custom
        ScrollBar1.Enabled := true;
      end;
  end;
end;

// header compress messages
procedure TForm1.ComboBox4Change(Sender: TObject);
begin
  case ComboBox4.ItemIndex of
    0 : HeaderControl1.Sections[2].Text := '"7-Zip" is set up for individual files or folders.';
    1 : HeaderControl1.Sections[2].Text := '"Zip" is set up for individual files or folders.';
    2 : HeaderControl1.Sections[2].Text := '"tar" is set up for individual multiple files only.';
    3 : HeaderControl1.Sections[2].Text := '"xz" is set up for individual multiple files only.';
    4 : HeaderControl1.Sections[2].Text := '"gz" is set up for individual multiple files only.';
    5 : HeaderControl1.Sections[2].Text := '"bz2" is set up for individual multiple files only.';
  end;
end;

// CPU Multi-Threading setting
procedure TForm1.ComboBox6Change(Sender: TObject);
begin
  case ComboBox6.ItemIndex of
    0 : begin
          ComboBox8.Enabled := false;
          Label15.Enabled := false;
        end;

    1 : begin
          ComboBox8.Enabled := true;
          Label15.Enabled := true;
        end;
  end;
end;

// archive volume size setting
procedure TForm1.ComboBox9Change(Sender: TObject);
begin
  case ComboBox9.ItemIndex of
    0 : Label11.Caption := 'byte';
    1 : Label11.Caption := 'kb';
    2 : Label11.Caption := 'MB';
    3 : Label11.Caption := 'GB';
  end;
end;

// write the options
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin
  {----------------------------------------------------------------------------}
  {--> do not use "DoubleBuffered" function or the process becomes sluggish <--}
  {----------------------------------------------------------------------------}

  // It is necessary in order to see the horizontal scrollbar in the listbox.
  Listbox1.Perform(LB_SetHorizontalExtent, 2000, Longint(0));

  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  // Allows the ListBox to accept dragged files.
  OldLBWindowProc := ListBox1.WindowProc; // store defualt WindowProc
  ListBox1.WindowProc := LBWindowProc; // replace default WindowProc
  DragAcceptFiles(ListBox1.Handle, True); // now ListBox1 accept dropped files

  // Resolves blocks if the app is running as administrator (Windows 7 and later).
  ChangeWindowMessageFilter(WM_DROPFILES, MSGFLT_ADD);
  ChangeWindowMessageFilter(WM_COPYDATA, MSGFLT_ADD);
  ChangeWindowMessageFilter($0049, MSGFLT_ADD); // WM_COPYGLOBALDATA

  StatusBar1.Panels[5].Text := '"7za.exe" found !';

  { Checking for the existence of the files that generate the
    compression and decompression process.}

  // check if 7zip  exists
  if not FileExists(MainDir + 'Data\7zip\7za.exe') then
  begin
    MessageDlg('Error "7za.exe" not found, check Folder ..\Data\7zip\..' +Chr(10)+
               'Download "7za.exe" if not found.'
               ,mtWarning, [mbOK], 0);
    Button6.Enabled := false;
    Button7.Enabled := false;
    StatusBar1.Panels[5].Text := '7za.exe not found!';
  end;

  // check if 7zip 64bit  exists
  if not FileExists(MainDir + 'Data\7zip\x64\7za.exe') then
  begin
    MessageDlg('Error "7za.exe (x64)" not found, check Folder ..\Data\7zip\x64\..' +Chr(10)+
               'Download "7za.exe (x64)" if not found.'
               ,mtWarning, [mbOK], 0);
    Button6.Enabled := false;
    Button7.Enabled := false;
    StatusBar1.Panels[5].Text := '7za.exe (x64) not found!';
  end;

  CheckBox12.Hint := 'Show the console report during the processing operation.';
  CheckBox1.Hint  := '7-Zip, the verbosity and output logging are controlled' + #10#13 +
                     'via the -bb (Set output log level) switch. This switch' + #10#13 +
                     'works during Add (a), Delete (d), Extract (e, x), and' + #10#13 +
                     'Update (u) operations.';
  CheckBox2.Hint  := 'You can disable the progress indicator in 7-Zip using' + #10#13 +
                     'the -bd switch in your command-line instructions.';
  CheckBox3.Hint  := 'Display execution time statistics';
  CheckBox4.Hint  := 'All follow-up questions are automatically answered with “Yes”.';
  CheckBox5.Hint  := 'Windows user account must have the "Lock pages in memory"' + #10#13 +
                     'privilege assigned in the Local Security Policy.';
  CheckBox6.Hint  := 'Show technical information for l (List) command';
  CheckBox7.Hint  := 'Serves to store hard links as actual links in the' + #10#13 +
                     'archive, rather than copying the linked files multiple times.';
  CheckBox8.Hint  := 'Switch manages case-sensitive file name matching.' + #10#13 +
                     'It determines whether 7-Zip treats uppercase and' +#10#13+
                     'lowercase letters as identical or different when' +#10#13+
                     'processing files, masks, and wildcards.';
  CheckBox9.Hint  := 'Forces 7-Zip to append the format extension to your' + #10#13 +
                     'file name, even if your string already contains an extension.';
  CheckBox10.Hint := 'Stop archive creating, if it can`t open some input file.';
  CheckBox11.Hint := 'Ensures that the operating system does not modify the ' +#10#13+
                     '"Last Access Time" property of the original files during' +#10#13+
                     'the packing or hashing process.';
  CheckBox13.Hint := 'Forces the program to compress files that are currently' + #10#13 +
                     'open in another application or locked for writing.';
  CheckBox14.Hint := 'Set the archive file`s timestamp to match the most' + #10#13 +
                     'recently modified file inside that archive.';
  CheckBox15.Hint := 'Disables the processing of wildcards' + #10#13 +
                     '(placeholders such as * or ?), so that these are' +#10#13+
                     'treated as normal, regular characters in the filename.';
  CheckBox16.Hint := 'Prevents duplicate root folders when unpacking' + #10#13 +
                     'archives if the name of the target folder exactly' +#10#13+
                     'matches the name of the top-level folder in the archive.';
  CheckBox17.Hint := 'Switch specifies the Overwrite Mode during extraction.';
  CheckBox18.Hint := 'Switch stands for "Use Full Pathnames"';
  CheckBox19.Hint := 'Search inside subfolders for matching files when' + #10#13 +
                     'creating, extracting, listing, or modifying archives.';
  CheckBox20.Hint := 'Deletes all files that have been compressed.';

  // Prevents free text input
  ComboBox2.Style := csDropDownList;
  // Link names and the corresponding WinAPI constants
  ComboBox2.AddItem('Idle (Low)', TObject(IDLE_PRIORITY_CLASS));
  // Manually defined for older Delphi versions, if applicable.
  ComboBox2.AddItem('Below Normal', TObject($00004000));
  ComboBox2.AddItem('Normal', TObject(NORMAL_PRIORITY_CLASS));
  // Manually defined if necessary
  ComboBox2.AddItem('Above Normal', TObject($00008000));
  ComboBox2.AddItem('High (Process)', TObject(HIGH_PRIORITY_CLASS));
  ComboBox2.AddItem('Realtime (Real-Time)', TObject(REALTIME_PRIORITY_CLASS));
  // Select 'Normal' by default (index 4)
  ComboBox2.ItemIndex := 4;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // Cleans up the registry upon closing.
  ListBox1.WindowProc := OldLBWindowProc;
  DragAcceptFiles(ListBox1.Handle, False);
end;

// read the options
procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
  ComboBox3.OnChange(sender);
  ComboBox4.OnChange(sender);
  ComboBox9.OnChange(sender);
end;

// Generating the icons for the files and the horizontal scrollbar for the listbox.
procedure TForm1.ListBox1Click(Sender: TObject);
begin
  // Determine the size of the entire folder content.
  StatusBar1.Panels[1].Text := IntToStr( Get_File_Size(ListBox1.Items.Strings[ListBox1.ItemIndex]) div 1000) + ' kb';
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
 Len: Integer;
 NewText: String;
begin
  NewText := Listbox1.Items[Index];

  // draw horizontal scrollbar
  with Listbox1.Canvas do
  begin
    FillRect(Rect);
    TextOut(Rect.Left + 1, Rect.Top, NewText);
    Len := TextWidth(NewText) + Rect.Left + 10;
    if Len>flbHorzScrollWidth then
    begin
      flbHorzScrollWidth := Len;
      Listbox1.Perform(LB_SETHORIZONTALEXTENT, flbHorzScrollWidth, 0 );
    end;
  end;

  // draw the icons in the listbox
  DrawListBoxExtra(Control, Index, Rect, State);
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  Panel1.SetFocus;
end;

procedure TForm1.Properties1Click(Sender: TObject);
var
  i : integer;
begin
  // Iterate through all entries in the ListBox
  for i := 0 to ListBox1.Items.Count - 1 do
  begin
    // Check whether the current entry is selected.
    if ListBox1.Selected[i] then
      // show the windows properties dialog
      PropertiesDialog(ListBox1.Items.Strings[ListBox1.ItemIndex]);
  end;
end;

end.
