function textMessage = sign_decoder(bitStream)
    alphabet = ['ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789. '];
    numBits = 6;
    numSymbols = length(bitStream) / numBits;

    % if mod(length(bitStream), numBits) ~= 0
    %     error('Длина битового потока некорректна');
    % end

    textMessage = '';

    for i = 1:numSymbols
        binaryCode = bitStream((i - 1) * numBits + 1:i * numBits);
        index = bin2dec(char(binaryCode + '0')) + 1;

        if index < 1 || index > length(alphabet)
            error(['Некорректный индекс ', num2str(index), ' для символа ', num2str(binaryCode)]);
        end

        textMessage = [textMessage, alphabet(index)];
    end

end
