function grey = cont2greycode(cont,n)

% This function takes in a decimal integer and produces a row vector
% of ones and zeros corresponding to the binary representation of the 
% number in grey code (least significant bit on the right)

var = cont;
bin = zeros(1,n);
grey = bin;
counter = 0;
if n <= (log(cont)/log(2))
    error('Number of bits too low.')
end

while var > 0
    var = var/2;
    remainder = round(var - floor(var));
    var = var - remainder/2;
    bin(n - counter) = remainder;
    counter = counter + 1;
end

% Convert binary number to grey code

grey(1) = bin(1);
grey(2:end) = xor(bin(2:end),bin(1:end-1));