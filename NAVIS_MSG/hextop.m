% function [p] = hextoP(hex)
% Returns floating point pressure 16-bit hex-encoded value
% Written by: Dan Quittman
% Copyright 2012 Sea-Bird Electronics
function [p] = hextop(hex)
  format long g
  if (hex == 32768)
    p = NaN;
  elseif (hex > 32768)
    p = (hex-65536)/10;
  else 
    p = hex/10;
  end
end

