% START - TASK: 1
originalText = 'Hello World.';
bitStream = sign_encoder(originalText);
decodedText = sign_decoder(bitStream);

disp(['Source: ', originalText]);
disp(['Ecnoded bits: ', num2str(bitStream)]);
disp(['Decoded bits: ', decodedText]);
% END - TASK: 1

% START - TASK: 2
codedBits = conv_encoder(bitStream);
decodedBits = viterbi_decoder(codedBits);

disp(['Исходные биты: ', num2str(inputBits)]);
disp(['Закодированные биты: ', num2str(codedBits)]);
disp(['Декодированные биты: ', num2str(decodedBits)]);

% END - TASK: 2
