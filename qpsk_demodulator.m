function bits = qpsk_demodulator(symbols)
    bits = false(1, 2 * length(symbols));

    for k = 1:length(symbols)
        sym = symbols(k);
        I = real(sym);
        Q = imag(sym);

        b0 = I < 0;
        b1 = Q < 0;

        bits(2 * k - 1) = b0;
        bits(2 * k) = b1;
    end

    bits = double(bits);
end
