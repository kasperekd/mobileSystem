% START - TASK: 1
disp('TASK 1: ');
originalText = 'Hello World.';
bitStream = sign_encoder(originalText);
decodedText = sign_decoder(bitStream);

disp(['Source: ', originalText]);
disp(['Ecnoded bits: ', num2str(bitStream)]);
disp(['Decoded text: ', decodedText]);
% END - TASK: 1

% START - TASK: 2
disp('TASK 2: ');
codedBits = conv_encoder(bitStream);
decodedBits = viterbi_decoder(codedBits);
decodedText_2 = sign_decoder(bitStream);

disp(['Исходные биты: ', num2str(bitStream)]);
disp(['Закодированные биты: ', num2str(codedBits)]);
disp(['Декодированные биты: ', num2str(decodedBits)]);
disp(['Decoded text: ', decodedText_2]);

% END - TASK: 2

% START - TASK: 3
disp('TASK 3: ');

interleavedBits = interleave_forward(codedBits);

deinterleavedBits = interleave_reverse(interleavedBits);

disp(['Исходные закодированные биты: ', num2str(codedBits)]);
disp(['Перемешанные биты: ', num2str(interleavedBits)]);
disp(['Восстановленные биты: ', num2str(deinterleavedBits)]);

decodedBits_3 = viterbi_decoder(deinterleavedBits);
decodedText_3 = sign_decoder(decodedBits_3);
disp(['Декодированный текст: ', decodedText_3]);

% END - TASK: 3

% START - TASK: 4
