function decodedBits = viterbi_decoder(codedBits)
    constraintLength = 7;
    polynomials = [171, 133];
    trellis = poly2trellis(constraintLength, polynomials);

    if mod(length(codedBits), 2) ~= 0
        error('Некорректная длина закодированного сообщения');
    end

    decodedBits = vitdec(codedBits, trellis, 5 * constraintLength, 'trunc', 'hard');
end
