function cont = greycode2cont(grey)

% This function takes in a grey code binary number (least significant bit
% on the right) in the form of a row vector of zeros and ones and converts
% the number to decimal

cont = 0;
n = length(grey);

% First, convert from grey code to binary
bin = grey;
for i = 2:n
    bin(i) = xor(grey(i),bin(i-1));
end

% Now convert to decimal
for i = 1:n
    cont = cont + bin(i)*2^(n-i);
end