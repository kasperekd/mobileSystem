function textMessage = sign_decoder(bitStream)
    alphabet = ['ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789. '];
    numBits = 7;
    numSymbols = length(bitStream) / numBits;

    if mod(length(bitStream), numBits) ~= 0
        error('Длина битового потока некорректна');
    end

    textMessage = '';

    for i = 1:numSymbols
        binaryCode = bitStream((i - 1) * numBits + 1:i * numBits);
        index = bin2dec(char(binaryCode + '0')) + 1;
        textMessage = [textMessage, alphabet(index)];
    end

end
