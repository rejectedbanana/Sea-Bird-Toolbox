function [kvar_name, kvar_format, kvar_units] = interpretSBSvariable( sbs_var )

% function [kvar_name, kvar_format, kvar_units] = interpretSBSvariable( sbs_var )
%
% DESCRIPTION:
% Converts the strings that define SBE variables to strings that matlab can
% use as functions. Gives units for each variable and defines whether
% it is a number or a text string. 
%
% All variables imported from SBEDataProcessing_7.26.4.pdf. There may be
% additional variables added in future versions of Sea-Bird Data processing
% modules that are not included here. Please email kmartini@seabird.com if
% you find one to keep the code current.
%
% INPUT:
%   sbs_var         =   text string with variable name
%
% OUTPUT: 
%   kvar_name       =   converted, matlab code readable variable name
%   kvar_format     =   defines whether variable is a float or a string
%   kvar_units      =   variable units. Empty string if undefined.
%
%
% KiM MARTiNi 07.2017
% Sea-Bird Scientific 
% kmartini@seabird.com

switch sbs_var
    % TEMPERATURE
    % primary sensor
    case {'t090Cm', 't4990C', 'tnc90C', 'tv290C', 't090C'}
        kvar_name = 't090C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case {'t090F', 't4990F', 'tnc90F', 'tv290F'}
        kvar_name = 't090F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F'; 
    case {'t068C', 't4968C','tnc68C', 'tv268C'}
        kvar_name = 't068C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case {'t068F', 't4968F','tnc68F', 'tv268F'}
        kvar_name = 't068F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
    case {'t090'}
        kvar_name = 't090';
        kvar_format = '%f';
        kvar_units = 'SBE49, deg C';
        
    %secondary temperature   
    case {'t190C', 'tnc290C'}
        kvar_name = 't190C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';      
    case {'t190F', 'tnc290F'}
        kvar_name = 't190F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case {'t168C', 'tnc268C'}
        kvar_name = 't168C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';      
    case {'t168F', 'tnc268F'}
        kvar_name = 't168F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';   
    
    % SBE38 REFERENCE TEMPERATURE
    % primary sensor
    case {'t3890C', 't38_90C'}
        kvar_name = 't03890C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case {'t3890F', 't38_90F'}
        kvar_name = 't03890F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case {'t3868C', 't38_68C'}
        kvar_name = 't03868C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case {'t3868F', 't38_68F'}
        kvar_name = 't03868F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
    % secondary sensor
    case {'t3890C1'}
        kvar_name = 't13890C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case {'t3890F1'}
        kvar_name = 't13890F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case {'t3868C1'}
        kvar_name = 't13868C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case {'t3868F1'}
        kvar_name = 't13868F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
        
    % TEMPERATURE DIFFERENCE
    case 'T2-T190C'
        kvar_name = 'tdiff90C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C'; 
    case 'T2-T190F'
        kvar_name = 'tdiff90F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case 'T2-T168C'
        kvar_name = 'tdiff68C';
        kvar_format = '%f';
        kvar_units = 'IPTS-68, deg C';
    case 'T2-T168F'
        kvar_name = 'tdiff68F';
        kvar_format = '%f';
        kvar_units = 'IPTS-68, deg F';
        
    % CONDUCTIVITY
    % primary conductivity
    case {'c_S/m', 'cond0S/m', 'c0S/m'}
        kvar_name = 'c0Sm';
        kvar_format = '%f';
        kvar_units = 'S/m';
    case {'c_mS/cm', 'cond0mS/cm', 'c0mS/cm'}
        kvar_name = 'c0mScm';
        kvar_format = '%f';
        kvar_units = 'mS/cm';
    case {'c_uS/cm', 'cond0uS/cm', 'c0uS/cm'}
        kvar_name = 'c0uScm';
        kvar_format = '%f';
        kvar_units = 'microS/cm';
    % secondary conductivity
    case 'c1S/m'
        kvar_name = 'c1Sm';
        kvar_format = '%f';
        kvar_units = 'S/m';
    case 'c1mS/cm'
        kvar_name = 'c1mScm';
        kvar_format = '%f';
        kvar_units = 'mS/cm';
    case 'c1uS/cm'
        kvar_name = 'c1uScm';
        kvar_format = '%f';
        kvar_units = 'microS/cm';
        
    % CONDUCTIVITY DIFFERENCE
    case 'C2-C1S/m'
        kvar_name = 'cdiffSm';
        kvar_format = '%f';
        kvar_units = 'S/m';
    case 'C2-C1mS/cm'
        kvar_name = 'cdiffmScm';
        kvar_format = '%f';
        kvar_units = 'mS/cm';
    case 'C2-C1uS/cm'
        kvar_name = 'cdiffuScm';
        kvar_format = '%f';
        kvar_units = 'microS/cm';
        
    % PRESSURE
    % user entered pressure values
    case 'pr' % SBE 49
        kvar_name = 'p';
        kvar_format = '%f';
        kvar_units = 'db';
    case 'prM'
        kvar_name = 'pM';
        kvar_format = '%f';
        kvar_units = 'db (user entered)';
    case 'prE'
        kvar_name = 'pE';
        kvar_format = '%f';
        kvar_units = 'psi (user entered)';
    % digiquartz pressure
    case {'prDM'}
        kvar_name = 'pm';
        kvar_format = '%f';
        kvar_units = 'db'; 
    case {'prDE'}
        kvar_name = 'pe';
        kvar_format = '%f';
        kvar_units = 'psi';
   % strain gauge pressure
    case {'prSM', 'prdM'}
        kvar_name = 'pm';
        kvar_format = '%f';
        kvar_units = 'db'; 
    case {'prSE',  'prdE'}
        kvar_name = 'pe';
        kvar_format = '%f';
        kvar_units = 'psi';
    % pressure temperature    
    case {'ptempC'}
        kvar_name = 'ptempC';
        kvar_format = '%f';
        kvar_units = 'deg C';
    case {'ptempF'}
        kvar_name = 'ptempF';
        kvar_format = '%f';
        kvar_units = 'deg F';
    % FGP Pressure
    case {'fgp0'}
        kvar_name = 'fgp0';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp1'}
        kvar_name = 'fgp1';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp2'}
        kvar_name = 'fgp2';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp3'}
        kvar_name = 'fgp3';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp4'}
        kvar_name = 'fgp4';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp5'}
        kvar_name = 'fgp5';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp6'}
        kvar_name = 'fgp6';
        kvar_format = '%f';
        kvar_units = 'KPa';
    case {'fgp7'}
        kvar_name = 'fgp7';
        kvar_format = '%f';
        kvar_units = 'KPa';
    % SBE 50
    case {'pr50M'}
        kvar_name = 'p050m';
        kvar_format = '%f';
        kvar_units = 'db';
    case {'pr50E'}
        kvar_name = 'p050e';
        kvar_format = '%f';
        kvar_units = 'psi';
    case {'pr50M1'}
        kvar_name = 'p150m';
        kvar_format = '%f';
        kvar_units = 'db';
    case {'pr50E1'}
        kvar_name = 'p150e';
        kvar_format = '%f';
        kvar_units = 'psi';
        
        
    % FREQUENCY OUTPUT
    case  {'f0', 'f1', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'f11', 'f12', 'f13', 'f14', 'f15', 'f16', 'f17', 'f18',...
            'f19', 'f20', 'f21', 'f22', 'f23', 'f24', 'f25', 'f26', 'f27', 'f28', 'f29', 'f30', 'f31', 'f32', 'f33', 'f34', 'f35', 'f36'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'Hz';
        
     % VOLTAGE OUTPUT
    case  {'v0', 'v1', 'v2', 'v3', 'v4', 'v5', 'v6', 'v7', 'v8', 'v9', 'v10', 'v11', 'v12', 'v13', 'v14', 'v15'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'V';
        
    % GTD-DO SENSORS
    % PRESSURE
    case  {'GTDDOP0', 'GTDDOP1', 'GTDDOPdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'mb';
    % TEMPERATURE
    case  {'GTDDOT0', 'GTDDOT1', 'GTDDOTdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'deg C';
    % GTD-N2 SENSOR
    % PRESSURE
    case  {'GTDN2P0', 'GTDN2P1', 'GTDN2Pdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'mb';
    % TEMPERATURE
    case  {'GTDN2T0', 'GTDN2T1', 'GTDN2Tdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'deg C';
        
    % TIME
    % elapsed time
    case  'timeS' 
        kvar_name = 'timeS';
        kvar_format = '%f';
        kvar_units = 'elapsed time seconds'; 
    case  'timeM' 
        kvar_name = 'timeM';
        kvar_format = '%f';
        kvar_units = 'elapsed time minutes'; 
    case  'timeH'
        kvar_name = 'timeH';
        kvar_format = '%f';
        kvar_units = 'elapsed time hours';
    case  'timeJ' 
        kvar_name = 'timeJ';
        kvar_format = '%f';
        kvar_units = 'elapsed time Julian Days';
    case  'timeN'
        kvar_name = 'timeN';
        kvar_format = '%f';
        kvar_units = 'From NMEA: seconds since January 1, 2000;';
    case  'timeQ'
        kvar_name = 'timeQ';
        kvar_format = '%f';
        kvar_units = 'From NMEA: seconds since January 1, 1970';   
    case  'timeK'
        kvar_name = 'timeK';
        kvar_format = '%f';
        kvar_units = 'SBE timestamp: seconds since January 1, 2000';
    case  'timeJV2' % julian days
        kvar_name = 'jdays';
        kvar_format = '%f';
        kvar_units = 'SBE timestamp: julian days';
    case  'timeSCP' % julian days
        kvar_name = 'jdays';
        kvar_format = '%f';
        kvar_units = 'SBE timestamp: julian days';
    case  'timeY'
        kvar_name = 'timeY';
        kvar_format = '%f';
        kvar_units = 'Computer Time: seconds since January 1, 1970';
        
    % POSITION
    case  'latitude'
        kvar_name = 'lat';
        kvar_format = '%f';
        kvar_units = 'from NMEA degrees';
    case  'longitude'
        kvar_name = 'lon';
        kvar_format = '%f';
        kvar_units = 'from NMEA degrees';
        
    % DEPTH
    case  'depSM'
        kvar_name = 'depSM';
        kvar_format = '%f';
        kvar_units = 'depth salt water, m';
    case  'depSF'
        kvar_name = 'depSF';
        kvar_format = '%f';
        kvar_units = 'depth salt water, ft';
    case  'depFM'
        kvar_name = 'depFM';
        kvar_format = '%f';
        kvar_units = 'depth fresh water, m';
    case  'depFF'
        kvar_name = 'depSM';
        kvar_format = '%f';
        kvar_units = 'depth fresh water, ft';
    case  'dNMEA'
        kvar_name = 'depSM';
        kvar_format = '%f';
        kvar_units = 'depth from NMEA salt water, m';
        
    % POTENTIAL TEMPERATURE
    % I use the abbreviation of the greek symbol theta to designate
    % potential temperature
    case  'potemp090C'
        kvar_name = 'th090C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'potemp090F'
        kvar_name = 'th090F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case  'potemp068C'
        kvar_name = 'th068C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case  'potemp068F'
        kvar_name = 'th068F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
    case  'potemp190C'
        kvar_name = 'th190C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'potemp190F'
        kvar_name = 'th190F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case  'potemp168C'
        kvar_name = 'th168C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case  'potemp168F'
        kvar_name = 'th168F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
    
    % POTENTIAL TEMPEATURE DIFFERENCE
    case  'potemp90Cdiff'
        kvar_name = 'th090Cdiff';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'potemp90Fdiff'
        kvar_name = 'th090Fdiff';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case  'potemp68Cdiff'
        kvar_name = 'th068Cdiff';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case  'potemp68Fdiff'
        kvar_name = 'th068Fdiff';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
        
   % POTENTIAL TEMPEATURE ANOMALY 
       case  'tha090C'
        kvar_name = 'tha090C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'tha090F'
        kvar_name = 'tha090F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case  'tha068C'
        kvar_name = 'tha068C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case  'tha068F'
        kvar_name = 'tha068F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
    case  'tha190C'
        kvar_name = 'tha190C';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'tha190F'
        kvar_name = 'tha190F';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case  'tha168C'
        kvar_name = 'tha168C';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg C';
    case  'tha168F'
        kvar_name = 'tha168F';
        kvar_format = '%f';
        kvar_units = 'ITS-68, deg F';
        
    % SALINITY
    case  'sal00'
        kvar_name = 's0';
        kvar_format = '%f';
        kvar_units = 'PSU';
    case  'sal11'
        kvar_name = 's1';
        kvar_format = '%f';
        kvar_units = 'PSU';
    case  'secS-priS'
        kvar_name = 'sdiff';
        kvar_format = '%f';
        kvar_units = 'PSU';
        
    % DENSITY
    % sg: potential density, based on greek letter sg
    % sgth: potential denisty sg calculated with potential temperature
    % theta (th)
    case  'density00'
        kvar_name = 'rho0';
        kvar_format = '%f';
        kvar_units = 'density, kg/m^3';
    case  'sigma-é00'
        kvar_name = 'sgth0';
        kvar_format = '%f';
        kvar_units = 'sigma-theta (p=0 db),kg/m^3';
    case  'sigma-t00'
        kvar_name = 'sgt0';
        kvar_format = '%f';
        kvar_units = 'sigma-t (p=0 db), kg/m^3';
    case  'sigma-100'
        kvar_name = 'sg10';
        kvar_format = '%f';
        kvar_units = 'sigma-1 (p=1000 db),kg/m^3';
    case  'sigma-200'
        kvar_name = 'sg20';
        kvar_format = '%f';
        kvar_units = 'sigma-2 (p=2000 db),kg/m^3';
    case  'sigma-300'
        kvar_name = 'sg30';
        kvar_format = '%f';
        kvar_units = 'sigma-3 (p=3000 db),kg/m^3';
    case  'sigma-400'
        kvar_name = 'sg40';
        kvar_format = '%f';
        kvar_units = 'sigma-4 (p=4000 db),kg/m^3';
    case  'density11'
        kvar_name = 'rho1';
        kvar_format = '%f';
        kvar_units = 'density, kg/m^3';
    case  'sigma-é11'
        kvar_name = 'sgth1';
        kvar_format = '%f';
        kvar_units = 'sigma-theta (p=0 db),kg/m^3';
    case  'sigma-t11'
        kvar_name = 'sgt1';
        kvar_format = '%f';
        kvar_units = 'sigma-t (p=0 db), kg/m^3';
    case  'sigma-111'
        kvar_name = 'sg11';
        kvar_format = '%f';
        kvar_units = 'sigma-1 (p=1000 db),kg/m^3';
    case  'sigma-211'
        kvar_name = 'sg21';
        kvar_format = '%f';
        kvar_units = 'sigma-2 (p=2000 db),kg/m^3';
    case  'sigma-311'
        kvar_name = 'sg31';
        kvar_format = '%f';
        kvar_units = 'sigma-3 (p=3000 db),kg/m^3';
    case  'sigma-411'
        kvar_name = 'sg41';
        kvar_format = '%f';
        kvar_units = 'sigma-4 (p=4000 db),kg/m^3';
    
    % DENSITY DIFFERENCE
    case  {'D2-D1, d'}
        kvar_name = 'rhodiff';
        kvar_format = '%f';
        kvar_units = 'density, kg/m^3';
    case  'D2-D1,th'
        kvar_name = 'sgthdiff';
        kvar_format = '%f';
        kvar_units = 'sigma-theta, kg/m^3';
    case  'D2-D1,t'
        kvar_name = 'sgtdiff';
        kvar_format = '%f';
        kvar_units = 'sigma-t, kg/m^3';
    case  'D2-D1,1'
        kvar_name = 'sg1diff';
        kvar_format = '%f';
        kvar_units = 'sigma-1 (p=1000 db),kg/m^3';
    case  'D2-D1,2'
        kvar_name = 'sg2diff';
        kvar_format = '%f';
        kvar_units = 'sigma-2 (p=1000 db),kg/m^3';
    case  'D2-D1,3'
        kvar_name = 'sg3diff';
        kvar_format = '%f';
        kvar_units = 'sigma-3 (p=1000 db),kg/m^3';
    case  'D2-D1,4'
        kvar_name = 'sg4diff';
        kvar_format = '%f';
        kvar_units = 'sigma-4 (p=1000 db),kg/m^3';

    % SOUND VELOCITY
    % primary sensor
    case  'svCM'
        kvar_name = 'sv0CM';
        kvar_format = '%f';
        kvar_units = 'Chen-Millero, m/s';
    case  'svCF'
        kvar_name = 'sv0CF';
        kvar_format = '%f';
        kvar_units = 'Chen-Millero, ft/s';
    case  'svDM'
        kvar_name = 'sv0DM';
        kvar_format = '%f';
        kvar_units = 'Delgrosso, m/s';
    case  'svDF'
        kvar_name = 'sv0DF';
        kvar_format = '%f';
        kvar_units = 'Delgrosso, ft/s';
    case  'svWM'
        kvar_name = 'sv0WM';
        kvar_format = '%f';
        kvar_units = 'Wilson, m/s';
    case  'svWF'
        kvar_name = 'sv0WF';
        kvar_format = '%f';
        kvar_units = 'Wilson, ft/s';
    % secondary sensor
    case  'svCM1'
        kvar_name = 'sv1CM';
        kvar_format = '%f';
        kvar_units = 'Chen-Millero, m/s';
    case  'svCF1'
        kvar_name = 'sv1CF';
        kvar_format = '%f';
        kvar_units = 'Chen-Millero, ft/s';
    case  'svDM1'
        kvar_name = 'sv1DM';
        kvar_format = '%f';
        kvar_units = 'Delgrosso, m/s';
    case  'svDF1'
        kvar_name = 'sv1DF';
        kvar_format = '%f';
        kvar_units = 'Delgrosso, ft/s';
    case  'svWM1'
        kvar_name = 'sv1WM';
        kvar_format = '%f';
        kvar_units = 'Wilson, m/s';
    case  'svWF1'
        kvar_name = 'sv1WF';
        kvar_format = '%f';
        kvar_units = 'Wilson, ft/s';
    % IOW sound velocity sensor
    case  'iowSv'
        kvar_name = 'iowSv';
        kvar_format = '%f';
        kvar_units = 'IOW sound velocity sensor, m/s';
    case  'sbeSv-iowSv'
        kvar_name = 'svdiff';
        kvar_format = '%f';
        kvar_units = 'SBE CTD - IOW SV sensor, m/s';
    % AVERAGE SOUND VELOCITY
    case  'avgsvCM'
        kvar_name = 'avgsvCM';
        kvar_format = '%f';
        kvar_units = 'Chen-Millero, m/s';
    case  'avgsvCF'
        kvar_name = 'avgsvCF';
        kvar_format = '%f';
        kvar_units = 'Chen-Millero, ft/s';
    case  'avgsvDM'
        kvar_name = 'avgsvDM';
        kvar_format = '%f';
        kvar_units = 'Delgrosso, m/s';
    case  'avgsvDF'
        kvar_name = 'avgsvDF';
        kvar_format = '%f';
        kvar_units = 'Delgrosso, ft/s';
    case  'avgsvWM'
        kvar_name = 'avgsvWM';
        kvar_format = '%f';
        kvar_units = 'Wilson, m/s';
    case  'avgsvWF'
        kvar_name = 'avgsvWF';
        kvar_format = '%f';
        kvar_units = 'Wilson, ft/s';
        
    % BUOYANCY
    case  'N'
        kvar_name = 'N';
        kvar_format = '%f';
        kvar_units = 'cycles/hour';
    case  'N^2'
        kvar_name = 'N2';
        kvar_format = '%f';
        kvar_units = 'rad^2/s^2';
        
    % ACCELERATION
    case  'accM'
        kvar_name = 'accM';
        kvar_format = '%f';
        kvar_units = 'm/s^2';
    case  'accF'
        kvar_name = 'accF';
        kvar_format = '%f';
        kvar_units = 'ft/s^2';
        
    % DESCENT RATE
    case  'dz/dtM'
        kvar_name = 'dzdtM';
        kvar_format = '%f';
        kvar_units = 'm/s';
    case  'dz/dtF'
        kvar_name = 'dzdtF';
        kvar_format = '%f';
        kvar_units = 'ft/s';
        
    % SEAFLOOR DEPTH
    case  'sfdSM'
        kvar_name = 'sfdSM';
        kvar_format = '%f';
        kvar_units = 'salt water, m';
    case  'sfdSF'
        kvar_name = 'sfdSF';
        kvar_format = '%f';
        kvar_units = 'salt water, ft';
    case  'sfdFM'
        kvar_name = 'sfdFM';
        kvar_format = '%f';
        kvar_units = 'fresh water, m';
    case  'sfdFF'
        kvar_name = 'sfdFF';
        kvar_format = '%f';
        kvar_units = 'fresh water, ft';
        
    % OTHER DERIVED VARIABLES 
    % DYNAMIC METERS
    case  'dm'
        kvar_name = 'dm';
        kvar_format = '%f';
        kvar_units = '10 J/kg';
    % GEOPOTENTIAL ANOMALY
    case  'gpa'
        kvar_name = 'gpa';
        kvar_format = '%f';
        kvar_units = 'J/kg';
    % PLUME ANOMALY
    case  'pla'
        kvar_name = 'pla';
        kvar_format = '%f';
        kvar_units = '?';
    % SPECIFIC VOLUME ANOMALY
    case  'sva'
        kvar_name = 'sva';
        kvar_format = '%f';
        kvar_units = '10^-8 *m^3/kg';
    % STABILITY
    case  'E'
        kvar_name = 'E';
        kvar_format = '%f';
        kvar_units = 'rad^2/m';
    case  'E10^-8'
        kvar_name = 'E10e_8';
        kvar_format = '%f';
        kvar_units = '10^-8 *rad^2/m';
    % THERMOSTERIC ANOMALY
    case  'tsa'
        kvar_name = 'tsa';
        kvar_format = '%f';
        kvar_units = '10^-8 *m^3/kg';
    % SPECIFIC CONDUCTANCE
    case  'specc'
        kvar_name = 'specc';
        kvar_format = '%f';
        kvar_units = 'uS/cm';
    case  'speccumhoscm'
        kvar_name = 'speccumhoscm';
        kvar_format = '%f';
        kvar_units = 'umhos/cm';
    case  'speccmsm'
        kvar_name = 'speccmsm';
        kvar_format = '%f';
        kvar_units = 'mS/cm';
    case  'speccmmhoscm'
        kvar_name = 'speccmmhoscm';
        kvar_format = '%f';
        kvar_units = 'mmhos/cm';

    % BIOGEOCHEMICAL SENSORS

    % OXYGEN 
    % RAW OXYGEN, SBE 43
    case 'sbeox0V'
        kvar_name = 'sbeox0V';
        kvar_format = '%f';
        kvar_units = 'V';
    case  'sbeox0F'
        kvar_name = 'sbeox0F';
        kvar_format = '%f';
        kvar_units = 'Hz';
    case 'sbeox1V'
        kvar_name = 'sbeox1V';
        kvar_format = '%f';
        kvar_units = 'V';
    case  'sbeox1F'
        kvar_name = 'sbeox1F';
        kvar_format = '%f';
        kvar_units = 'Hz';
    % DERIVED OXYGEN, SBE 43
    case  'sbeox0ML/L'
        kvar_name = 'sbeox0mL_L';
        kvar_format = '%f';
        kvar_units = 'mL/L';
    case  'sbeox0Mg/L'
        kvar_name = 'sbeox0mg_L';
        kvar_format = '%f';
        kvar_units = 'mg/L';
    case  'sbeox0PS'
        kvar_name = 'sbeox0PS';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'sbeox0Mm/Kg'
        kvar_name = 'sbeox0mum_kg';
        kvar_format = '%f';
        kvar_units = 'micromol/kg';
    case  'sbeox0Mm/L'
        kvar_name = 'sbeox0mum_L';
        kvar_format = '%f';
        kvar_units = 'micromole/L';
    case  'sbeox0dOV/dT'
        kvar_name = 'sbeox0dOV_dT';
        kvar_format = '%f';
        kvar_units = 'V/s';
    case  'sbeox1ML/L'
        kvar_name = 'sbeox1mL_L';
        kvar_format = '%f';
        kvar_units = 'mL/L';
    case  'sbeox1Mg/L'
        kvar_name = 'sbeox1mg_L';
        kvar_format = '%f';
        kvar_units = 'mg/L';
    case  'sbeox1PS'
        kvar_name = 'sbeox1PS';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'sbeox1Mm/Kg'
        kvar_name = 'sbeox1mum_kg';
        kvar_format = '%f';
        kvar_units = 'micromol/kg';
    case  'sbeox1Mm/L'
        kvar_name = 'sbeox1mum_L';
        kvar_format = '%f';
        kvar_units = 'micromole/L';
    case  'sbeox1dOV/dT'
        kvar_name = 'sbeox1dOV_dT';
        kvar_format = '%f';
        kvar_units = 'V/s';
    % Difference between SBE 43 sensors        
    case  'sbeox0ML/Ldiff'
        kvar_name = 'sbeox0ML_Ldiff';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'sbeox0Mg/Ldiff'
        kvar_name = 'sbeox0Mg_Ldiff';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'sbeox0PSdiff'
        kvar_name = 'sbeox0PSdiff';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'sbeox0Mm/Kgdiff'
        kvar_name = 'sbeox0Mm_Kgdiff';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    case  'sbeox0Mm/Ldiff'
        kvar_name = 'sbeox0Mm_Ldiff';
        kvar_format = '%f';
        kvar_units = 'umol/l';
    % RAW OXYGEN, SBE 63
    case  'sbeoxpd'
        kvar_name = 'sbeoxpd';
        kvar_format = '%f';
        kvar_units = 'usec';
    case  'sbeoxpdv'
        kvar_name = 'sbeoxpdv';
        kvar_format = '%f';
        kvar_units = 'V';
    case  'sbeoxpd1'
        kvar_name = 'sbeoxpd1';
        kvar_format = '%f';
        kvar_units = 'usec';
    case  'sbeoxpdv1'
        kvar_name = 'sbeoxpdv1';
        kvar_format = '%f';
        kvar_units = 'sbeoxpdv1';
    case  'sbeoxtv'
        kvar_name = 'sbeoxtv';
        kvar_format = '%f';
        kvar_units = 'sbeoxtv';
    case  'sbeoxtv1'
        kvar_name = '';
        kvar_format = '%f';
        kvar_units = 'sbeoxtv1';
    % RAW OXYGEN TEMPERATURE, SBE 63
    case  'sbeoxTC'
        kvar_name = '';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'sbeoxTF'
        kvar_name = '';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    case  'sbeoxTC1'
        kvar_name = '';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg C';
    case  'sbeoxTF1'
        kvar_name = '';
        kvar_format = '%f';
        kvar_units = 'ITS-90, deg F';
    % DERIVED OXYGEN, SBE 63
    case  'sbeopoxML/L'
        kvar_name = 'sbeopoxML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'sbeopoxMg/L'
        kvar_name = 'sbeopoxMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'sbeopoxPS'
        kvar_name = 'sbeopoxPS';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'sbeopoxMm/Kg'
        kvar_name = 'sbeopoxMm_Kg';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    case  'sbeopoxMm/L'
        kvar_name = 'sbeopoxMm_L';
        kvar_format = '%f';
        kvar_units = 'umol/l';
    case  'sbeopoxML/L1'
        kvar_name = 'sbeopoxML_L1';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'sbeopoxMg/L1'
        kvar_name = 'sbeopoxMg_L1';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'sbeopoxPS1'
        kvar_name = 'sbeopoxPS1';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'SbeopoxMm/Kg1'
        kvar_name = 'SbeopoxMm_Kg1';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    case  'sbeopoxMm/L1'
        kvar_name = 'sbeopoxMm/L1';
        kvar_format = '%f';
        kvar_units = 'umol/l';
    % AANDERAA OPTODE
    case  'opoxML/L'
        kvar_name = 'opoxML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'opoxMg/L'
        kvar_name = 'opoxMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'opoxPS'
        kvar_name = 'opoxPS';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'opoxMm/L'
        kvar_name = 'opoxMm_L';
        kvar_format = '%f';
        kvar_units = 'umol/l';
    % BECKMAN/YSI
    case  'oxC'
        kvar_name = 'oxC';
        kvar_format = '%f';
        kvar_units = 'uA';
    case  'oxsC'
        kvar_name = 'oxsC';
        kvar_format = '%f';
        kvar_units = 'uA';
    case  'oxTC'
        kvar_name = 'oxTC';
        kvar_format = '%f';
        kvar_units = 'deg C';
    case  'oxTF'
        kvar_name = 'oxTF';
        kvar_format = '%f';
        kvar_units = 'deg F';
    case  'oxsTC'
        kvar_name = 'oxsTC';
        kvar_format = '%f';
        kvar_units = 'deg C';
    case  'oxsTF'
        kvar_name = 'oxsTF';
        kvar_format = '%f';
        kvar_units = 'deg F';       
    case  'oxML/L'
        kvar_name = 'oxML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'oxMg/L'
        kvar_name = 'oxMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'oxPS'
        kvar_name = 'oxPS';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'oxMm/Kg'
        kvar_name = 'oxMm_Kg';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    case  'oxdOC/dT'
        kvar_name = 'oxdOC_dT';
        kvar_format = '%f';
        kvar_units = 'doc/dt';
    case  'oxsML/L'
        kvar_name = 'oxsML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'oxsMg/L'
        kvar_name = 'oxsMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'oxsPS'
        kvar_name = 'oxsPS';
        kvar_format = '%f';
        kvar_units = '% saturation';
    case  'oxsMm/Kg'
        kvar_name = 'oxsMm_Kg';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    case  'oxsdOC/dT'
        kvar_name = 'oxsdOC_dT';
        kvar_format = '%f';
        kvar_units = 'doc/dt';
    % IOW OXYGEN SATURATIONS
    case  'iowOxML/L'
        kvar_name = 'iowOxML/L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    % GARCIA & GORDON OXYGEN SATURATION
    case  'oxsolML/L'
        kvar_name = 'oxsolML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'oxsolMg/L'
        kvar_name = 'oxsolMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'oxsolMm/Kg'
        kvar_name = 'oxsolMm_Kg';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    % WEISS OXYGEN SATURATION
    case  'oxsatML/L'
        kvar_name = 'oxsatML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'oxsatMg/L'
        kvar_name = 'oxsatMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'oxsatMm/Kg'
        kvar_name = 'oxsatMm_Kg';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
        
        
    % OPTICAL SENSORS
    % TURNER CYCLOPS
    % CDOM
    case  {'cdomflTC0', 'cdomflTC1', 'cdomflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ppb QS';
    % FLUORESCENCE
    case  {'chloroflTC0', 'chloroflTC1', 'chloroflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ug/l';
    % CRUDE OIL
    case  {'croilflTC0', 'croilflTC1', 'croilflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ppb QS';
    % FLUORESCEIN
    case  {'flflTC0', 'flflTC1', 'flflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ppb';
    % OPTICAL BRIGHTENERS
    case  {'obrflTC0', 'obrflTC1', 'obrflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ppb QS';
    % PHYCOCYANIN
    case  {'phycyflTC0', 'phycyflTC1', 'phycyflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'RFU';
    % PHYCOERYTHRIN
    case  {'phyeryflTC0', 'phyeryflTC1', 'phyeryflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'RFU';
    % REFINED FUELS
    case  {'rfuels0', 'rfuels1', 'rfuelsdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ppb NS';
    % RHODAMINE
    case  {'rhodflTC0', 'rhodflTC1', 'rhodflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ppb';
    % TURNER CYCLOPS TURBIDITY
    case  {'turbflTC0', 'turbflTC1', 'turbflTCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'NTU';

    
    % BIOSPHERICAL
    % FLUORESCENCE
    case  {'chConctr', 'naFluor', 'product'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % CHELSEA AQUA 3
    % FLUORESCENCE
    case  {'flC', 'flC1', 'flCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ug/l';
    % CHELSEA MINI CHL CON
    % FLUORESCENCE
    case  'flCM'
        kvar_name = 'flCM';
        kvar_format = '%f';
        kvar_units = 'ug/l';
    % CHELSEA UV AQUATRACKA
    % FLUORESCENCE
    case  {'flCUVA', 'flCUVA1', 'flCUVAdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'ug/l';
    % DR HAARDT
    % Fluorescence: Chlorophyll a, Phycoerythrin, Yellow Sub
    case  {'haardtC', 'haardtP', 'haardtY'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % SEAPOINT
    % FLUORESCENCE
    case  {'flSP', 'flSP1', 'flSPdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % RHODAMINE
    case  'flSPR'
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % ULTRAVIOLET
    case  {'flSPuv0', 'flSPuv1', 'flSPuvdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % SEATECH FLUORESCENCE
    case  'flS'
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % TURNER 10-005
    case  'flT'
        kvar_name = 'flT';
        kvar_format = '%f';
        kvar_units = '';
    % TURNER 10-Au-005
    case  'flTAu'
        kvar_name = 'flTAu';
        kvar_format = '%f';
        kvar_units = '';
    % TURNER SCUFA CORRECTED
    case  {'flSCC', 'flSCC1', 'flSCCdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'RFU';
    % TURNER SCUFA
    case  {'flScufa', 'flScufa1', 'flScufadiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % WETLABS AC3
    case  'wetChAbs'
        kvar_name = 'wetChAbs';
        kvar_format = '%f';
        kvar_units = '1/m';
    % WETLABS CDOM
    case  {'wetCDOM', 'wetCDOM1', 'wetCDOM2', 'wetCDOM3', 'wetCDOM4', 'wetCDOM5', 'wetCDOMdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    % WETLABS AC3 CHLOROPHYLL
    case  'wetChConc'
        kvar_name = 'wetChConc';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    % WETLABS ECO-AFL
    case  'flECO-AFL'
        kvar_name = 'flECO_AFL';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    case  'flECO-AFL1'
        kvar_name = 'flECO_AFL1';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    case  'flECO-AFL2'
        kvar_name = 'flECO_AFL2';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    case  'flECO-AFL3'
        kvar_name = 'flECO_AFL3';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    case  'flECO-AFL4'
        kvar_name = 'flECO_AFL4';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    case  'flECO-AFL5'
        kvar_name = 'flECO_AFL5';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    case  'flECO-AFLdiff'
        kvar_name = 'flECO_AFLdiff';
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    % WETLABS SEAOWL
    % FLUOROMETER
    case  {'flWETSeaOWLchl0', 'flWETSeaOWLchl1', 'flWETSeaOWLchldiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '?g/l';
    % FDOM
    case  {'flWETSeaOWLfdom0', 'flWETSeaOWLfdom1', 'flWETSeaOWLfdomdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '?g/l';
    % WETSTAR 
    case  {'wetStar', 'wetStar1', 'wetStar2', 'wetStar3', 'wetStar4', 'wetStar5', 'wetStardiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'mg/m^3';
    
    % BACKSCATTER
    % D & A BACKSCATTERANCE
    case  {'obs', 'obs1', 'obsdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'NTU';
    % CHELSEA NEPHELOMETER
    case  'nephc'
        kvar_name = 'nephc';
        kvar_format = '%f';
        kvar_units = 'FTU';
    % D & A
    case  'obs3+'
        kvar_name = 'obs3plus';
        kvar_format = '%f';
        kvar_units = 'NTU';
    case  'obs3+1'
        kvar_name = 'obs3plus1';
        kvar_format = '%f';
        kvar_units = 'NTU';
    case  'obs3+diff'
        kvar_name = 'obs3plusdiff';
        kvar_format = '%f';
        kvar_units = 'NTU';
    % DR. HAARDT
    case  'haardtT'
        kvar_name = 'haardtT';
        kvar_format = '%f';
        kvar_units = '';
    % IFREMER
    case  'diff'
        kvar_name = 'diff';
        kvar_format = '%f';
        kvar_units = '';
    % SEATECH LS6000
    case  {'stLs6000', 'stLs60001', 'stLs6000diff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % TURNER SCUFA
    case  {'obsscufa', 'obsscufa1', 'obsscufadiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = ''; 
    % WETLABS RAW COUNTS
    case  {'wl0', 'wl1', 'wl2', 'wl3', 'wl4', 'wl5'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'Counts';
    
    % TURBIDITY
    % SEAPOINT TURBIDITY
    case  {'seaTurbMtr', 'seaTurbMtr1', 'seaTurbMtrdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'FTU';
    % WETLABS ECO BB 
    case  {'turbWETbb0', 'turbWETbb1', 'turbWETbb2', 'turbWETbb3', 'turbWETbb4', 'turbWETbb5', 'turbWETbbdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'm^-1/sr';
    % WETLABS ECO
    case  {'turbWETntu0', 'turbWETntu1', 'turbWETntu2', 'turbWETntu3', 'turbWETntu4', 'turbWETntu5', 'turbWETntudiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'NTU';
    % WETLABS SEAOWL
    case  {'turbWETSeaOWLbb0', 'turbWETSeaOWLbb1', 'turbWETSeaOWLbbdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = 'm^-1/sr';        
   
    % TRANSMISSOMETERS
    % CHELSEA/SEATECH BEAM ATTENUATION
    case  {'bat', 'bat1', 'batdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '1/m';
    % WETLABS AC3 BEAM TRANSMISSION
    case  'wetBAttn'
        kvar_name = 'wetBAttn';
        kvar_format = '%f';
        kvar_units = '1/m';
    % WETLABS C-STAR BEAM ATTENUATION
    case  {'CStarAt', 'CStarAt0', 'CStarAt1', 'CStarAt2', 'CStarAt3', 'CStarAt4', 'CStarAt5', 'CStarAtdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '1/m';
    % CHELSEA/SEATECH BEAM TRANSMISSION
    case  {'xmiss', 'xmiss1', 'xmissdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '%';
    % WETLABS AC3 BEAM TRANSMISSION   
    case  'wetBTrans'
        kvar_name = 'wetBTrans';
        kvar_format = '%f';
        kvar_units = '%';
    % WETLABS C-STAR BEAM TRANSMISSION
    case  {'CStarTr', 'CStarTr0', 'CStarTr1', 'CStarTr2', 'CStarTr3', 'CStarTr4', 'CStarTr5', 'CStarTrdiff'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '%';
        
    % LISST
    case  'lisstBC'
        kvar_name = 'lisstBC';
        kvar_format = '%f';
        kvar_units = '1/m';
    case  'lisstOT'
        kvar_name = 'lisstOT';
        kvar_format = '%f';
        kvar_units = '%';
    case  'lisstMD'
        kvar_name = 'lisstMD';
        kvar_format = '%f';
        kvar_units = 'u';
    case  'lisstTVC'
        kvar_name = 'lisstTVC';
        kvar_format = '%f';
        kvar_units = 'ul/l';
        
        
    % PAR
    case  'cpar'
        kvar_name = 'cpar';
        kvar_format = '%f';
        kvar_units = '%';
    case 'par'
        kvar_name = 'par';
        kvar_format = '%f';
        kvar_units = '';
    case  'par1'
        kvar_name = 'par1';
        kvar_format = '%f';
        kvar_units = '';
    case  'par/log'
        kvar_name = 'par_log';
        kvar_format = '%f';
        kvar_units = 'umol photons/m2/s';
    case  'spar'
        kvar_name = 'spar';
        kvar_format = '%f';
        kvar_units = '';

    
    % BIOGEOCHEMICAL SENSORS
    % METHANE FRANATECH METS
    case  'meth'
        kvar_name = 'meth';
        kvar_format = '%f';
        kvar_units = 'umol/l';
    case  'methT'
        kvar_name = 'methT';
        kvar_format = '%f';
        kvar_units = 'deg C';
    % NITROGEN
    case  'n2satML/L'
        kvar_name = 'n2satML_L';
        kvar_format = '%f';
        kvar_units = 'ml/l';
    case  'n2satMg/L'
        kvar_name = 'n2satMg_L';
        kvar_format = '%f';
        kvar_units = 'mg/l';
    case  'n2satumol/kg'
        kvar_name = 'n2satumol_kg';
        kvar_format = '%f';
        kvar_units = 'umol/kg';
    % OXIDATION REDUCTION POTENTIAL
    case  'orp'
        kvar_name = 'orp';
        kvar_format = '%f';
        kvar_units = 'mV';
    % pH
    case {'ph', 'phInt', 'phExt'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % ZAPS
    case  'zaps'
        kvar_name = 'zaps';
        kvar_format = '%f';
        kvar_units = 'nmol';
              
    % USER DEFINED VARIABLE
    case  {'user', 'user1', 'user2', 'user3', 'user4', 'user5'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % USER POLYNOMIAL
    case  {'upoly0', 'upoly1', 'upoly2'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';

        
    % PACKAGE STATUS
    % ALTIMETER
    case  'altM'
        kvar_name = 'altM';
        kvar_format = '%f';
        kvar_units = 'm';
    case  'altF'
        kvar_name = 'altF';
        kvar_format = '%f';
        kvar_units = 'ft';
        
        % Bottom Contact
    case  'bct'
        kvar_name = 'bct';
        kvar_format = '%f';
        kvar_units = '';

        
   % WATER SAMPLER STATUS
   % BOTTLE POSITION, BOTTLES CLOSED (HB), BOTTLES FIRED, NEW POSITION'
    case  {'bpos', 'HBBotCls', 'nbf', 'newpos'}
        kvar_name = sbs_var;
        kvar_format = '%f';
        kvar_units = '';
    % PUMP STATUS
    case  'pumps'
        kvar_name = 'pumps';
        kvar_format = '%f';
        kvar_units = '';
        
   % DATA STREAM
   % BYTE COUNT
   case  'nbytes'
        kvar_name = 'nbytes';
        kvar_format = '%f';
        kvar_units = '';
   % MODULO ERROR COUNT
   case  'modError'
        kvar_name = 'modError';
        kvar_format = '%f';
        kvar_units = '';
   % MODULO WORD
    case  'mod'
        kvar_name = 'mod';
        kvar_format = '%s';
        kvar_units = '';
   % SCAN COUNT
    case  'scan'
        kvar_name = 'scan';
        kvar_format = '%f';
        kvar_units = '';
    % SCANS PER BIN
    case  'nbin'
        kvar_name = 'nbin';
        kvar_format = '%f';
        kvar_units = '';
        
        
    % FLAGS
    case 'flag'
        kvar_name = 'flag';
        kvar_format = '%f';
        
    otherwise
        % assign the original SBS name to the output variable
        kvar_name = sbs_var;
        % find and replace all the characters that are not alphabetic,
        % numbers or underscores with underscores
        noninds = regexp( dumstr, '\W');
        kvar_name(noninds) = '_'; 
        disp( ['Assigning ', sbs_var, ' as ', kvar_name])
        kvar_format = '%f';
        kvar_units = '';
                
%     case  ''
%         kvar_name = '';
%         kvar_format = '%f';
%         kvar_units = '';
        
end


