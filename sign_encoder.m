function bitStream = sign_encoder(textMessage)
    alphabet = ['ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789. '];
    numBits = 6;
    bitStream = [];

    for i = 1:length(textMessage)
        index = find(alphabet == textMessage(i));

        if isempty(index)
            error('В тексте есть недопустимые символы');
        end

        binaryCode = dec2bin(index - 1, numBits);
        bitStream = [bitStream, binaryCode - '0'];
    end

end
