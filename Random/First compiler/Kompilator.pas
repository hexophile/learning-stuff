program Kompilator;
uses SysUtils,crt;
const
  ID=1;
var
  fIn,app:text;
  SourceCodeDir,cmd,param:string;
  comm:array[0..99]of char;
  i,j,line,address,variable:integer;
  ender:boolean;
function error(line:integer;error_type:byte;command:string):string;
begin
  case(error_type)of
  1:error:='Line: '+inttostr(line)+' - Complie failed, expected ";" after parameters.';
  2:error:='Line: '+inttostr(line)+' - Compile failed, expected "Start" at begin.';
  3:error:='Line: '+inttostr(line)+' - Compile failed, unknown command "'+command+'"';
  end;
  readkey;
  exit;
end;

begin
i:=0x10;
writeln(i);
readkey;

if ParamCount=0 then
write('No file passed')
else
begin
line:=1;
address:=0;
variable:=0;
end;
ender:=false;
SourceCodeDir:=ParamStr(ID);
if not FileExists(SourceCodeDir) then
   write('File "',SourceCodeDir,'" not exist')
   else
   begin
        AssignFile(app,ExtractFilePath(ParamStr(0))+'Program.com');
        writeln(ExtractFilePath(ParamStr(0))+'Program.com');
        {$I-}
        Rewrite(app);
        {$I+}
        if IOResult<>0 then
           write('Compiler can'#39't create file!')
        else
        begin
        AssignFile(fIn,SourceCodeDir);
        {$I-}
        Reset(fIn);
        {$I+}
        if IOResult<>0 then
           write('Program can'#39't open file "',SourceCodeDir,'"!')
        else
        begin
   readln(fIn,cmd);
   if(cmd<>'Start')then
   writeln(error(1,2,cmd))
   else
   begin
        repeat
            readln(fIn,cmd);
            line:=line+1;
            comm:=cmd;
            cmd:='';
            ender:=false;
            for i:=0 to 255 do
            begin
              if(comm[i]=':')then
              begin
                   if cmd='Pisz' then            //wypisz ciąg znaków
                   begin
                   address:=address+7;
                   variable:=address;
                   write(app,#180#9);
                   variable:=ord(variable);
                   write(app,#186,chr(variable),#01#205#33);
                   for j:=i+1 to 255 do
                   begin
                        if(comm[j]=';') then
                        begin
                             ender:=true;
                             break;
                        end
                        else if((j=255) and (comm[j]<>';')) then
                        begin
                             writeln(error(line,1,cmd));
                        end
                        else
                        begin
                             write(app,comm[j]);
                             inc(address);
                        end;
                   end;
                   write(app,#36);
                   inc(address);
                   end//KONIEC PIERWSZEGO IF'A KOMENDY
                   else if cmd='Koniec' then
                   begin
                        write(app,#184#76#0#205#33);
                        address:=address+5;
                   end
                   else if cmd='Pauza' then
                   begin
                        write(app,#180#0#205#22);
                        address:=address+4;
                   end
                   else
                   begin
                        writeln(error(line,3,cmd));
                   end;
              end//KONIEC IF'A KOMEND
              else if (comm[i]<>':') then
              begin
                   cmd:=cmd+comm[i];
              end;
              if ender then break;
            end;
        until eof(fIn);
        close(fIn);
        close(app);
   end;
   end;
   end;
readln;
end;
end.
