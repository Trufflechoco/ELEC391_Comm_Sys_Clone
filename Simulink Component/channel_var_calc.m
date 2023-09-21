index1 = 0;
index2 = 0;

for n = 1:length(SNR_out)
    if (SNR_out(n) == 9)
        index1 = index1 + 1;

    else
        index2 = index2 + 1;

    end
end

prob9 = index1/(index1 + index2);
prob21 = 1-prob9;

var = prob9 * 9 + prob21 * 21
