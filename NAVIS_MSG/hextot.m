% function [T] = hextoT(hex)
% Returns floating point temp from from 16-bit hex-encoded value
% Written by: Dan Quittman
% Copyright 2012 Sea-Bird Electronics
function [T] = hextoT(hex)
  format long g
  if (hex == 61440)
    T = NaN;
  elseif (hex > 61440)
    T = (hex-65536)/1000;
  else 
    T = hex/1000;
  end
end

