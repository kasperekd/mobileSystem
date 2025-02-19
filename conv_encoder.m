function codedBits = conv_encoder(inputBits)
    constraintLength = 7;
    polynomials = [171 133];

    polyMatrix = [dec2bin(oct2dec(polynomials(1)), constraintLength) - '0';
                  dec2bin(oct2dec(polynomials(2)), constraintLength) - '0'];

    shiftReg = zeros(1, constraintLength);

    codedBits = [];

    for i = 1:length(inputBits)
        shiftReg = [inputBits(i), shiftReg(1:end - 1)];

        X = mod(sum(shiftReg .* polyMatrix(1, :)), 2);
        Y = mod(sum(shiftReg .* polyMatrix(2, :)), 2);

        codedBits = [codedBits, X, Y];
    end

end
