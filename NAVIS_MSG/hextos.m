% function [S] = hextoS(hex)
% Returns floating point salinity from 16-bit hex-encoded value
% Written by: Dan Quittman
% Copyright 2012 Sea-Bird Electronics
function [S] = hextoS(hex)
  format long g
  if (hex == 61440)
    S = NaN;
  elseif (hex > 61440)
    S = (hex-65536)/1000;
  else 
    S = hex/1000;
  end
end

