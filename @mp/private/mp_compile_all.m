% This script compiles the mp routines.
% It is assumed that mex is working, and the mpfr and gmp libraries 
%   are somewhere on your path.

if ~ispc %% *nix systems

 dd=dir;

 for ii=1:length(dd)
  if length(dd(ii).name)>2
   if strcmpi(dd(ii).name(end-1:end),'.c') 
    disp(['compiling:  mex ',dd(ii).name,' -lmpfr -lgmp'])
    %mex([dd(ii).name],' -lmpfr -lgmp');
    mex('-lmpfr','-lgmp',[dd(ii).name])
   end % if strcmpi(dd(ii).
  end % if length(dd(ii).
 end % for ii=1:length(dd)

else %% windows compiling
 
 %some prerrequisites for COMPILATION:
 %  MinGW
 %  gmp.dll as provided
 %  mpfr.dll as provided
 %  libgmp-3.dll as provided (is identical to gmp.dll!)

 MinGWbin='C:\Users\Synchro\scoop\apps\gcc\9.3.0-1\bin'; %no slash at the end!
 d=dir([MinGWbin '\gcc.exe']);
 if isempty(d)
  disp(['MinGW is not located at ' strrep(MinGWbin,'\bin','')])
  error(['Edit this file according to your setup, and run this again'])
 end
 MATLABROOT=strrep(which('matlabrc'),'\toolbox\local\matlabrc.m','');
 %compiled for 13 and 7.2, under W2K, and tested also under XP (but no compilation!)
 % PWD=pwd;
 % % cd([MATLABROOT '/bin/win64/']);
 % % dos([MinGWbin '\dlltool -D libmex.dll -l libmex.a -d ../../extern/include/libmex.def']);
 % % dos([MinGWbin '\dlltool -D libmat.dll -l libmat.a -d ../../extern/include/libmat.def']);
 % % dos([MinGWbin '\dlltool -D libmx.dll -l libmx.a -d ../../extern/include/libmx.def']);
 % % dos(['copy libmex.* ' PWD ]);
 % % dos(['copy libmat.* ' PWD ]);
 % % dos(['copy libmx.* ' PWD ]);
 % cd(PWD)

 dd=dir;

 for ii=1:length(dd)
  if length(dd(ii).name)>2
   if strcmpi(dd(ii).name(end-1:end),'.c')
    disp(['compiling: ' dd(ii).name])
    %We are not using mex, so on principle gnumex is not required
    txt=['!' MinGWbin '\gcc -O2 -shared -fexceptions -o' strrep(dd(ii).name,'.c','.mexw64') ...
         ' -IC:\Users\Synchro\scoop\apps\gcc\9.3.0-1\include -I' MATLABROOT '\extern\include -I. -L. -L' ...
          MATLABROOT '\extern\lib\win64\mingw64 ' dd(ii).name ...
         ' gmp.dll mpfr.dll -lmat -lmex -lmx -lm'];
    disp(txt);eval(txt);
   end % if strcmpi(dd(ii).
  end % if length(dd(ii).
 end % for ii=1:length(dd)

end