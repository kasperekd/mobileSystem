% START - TASK: 1
disp('TASK 1: ');
originalText = 'Hello World. 1234';
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
disp('TASK 4: ');

modulatedSymbols = qpsk_modulator(interleavedBits);
demodulatedBits = qpsk_demodulator(modulatedSymbols);

disp(['Перемешанные биты: ', num2str(interleavedBits)]);
disp(['Демодулированные биты: ', num2str(demodulatedBits)]);

deinterleavedBits_4 = interleave_reverse(demodulatedBits);
decodedBits_4 = viterbi_decoder(deinterleavedBits_4);
disp(['decodedBits_4: ', num2str(decodedBits_4)]);
decodedText_4 = sign_decoder(decodedBits_4);

disp(['Decoded text after modulation/demodulation: ', decodedText_4]);

% END - TASK: 4

% START - TASK: 5
disp('TASK 5: ');

delta_Rs = 6;
T_CP = 16;
C = 0.25;
N_subcarrier = 128;

ofdm_symbol = ofdm_modulator(modulatedSymbols, delta_Rs, T_CP, C, N_subcarrier);

% disp(ofdm_symbol)

% END - TASK: 5

% START - TASK: 6
disp('TASK 6: ');

N_path = 3;
N0_dB = 15;
max_delay = 6;
rx_signal = channel_model(ofdm_symbol, N_path, N0_dB, max_delay);

disp(rx_signal);
% END - TASK: 6

% START - TASK: 7

disp('TASK 7: ');

received_symbols = ofdm_demodulator(rx_signal, delta_Rs, T_CP, C, N_subcarrier);
% received_symbols = ofdm_demodulator(ofdm_symbol, delta_Rs, T_CP, C, N_subcarrier);
demodulatedBits = qpsk_demodulator(received_symbols);

% disp('Original QPSK symbols:');
% disp(modulatedSymbols);
% disp('Received QPSK symbols:');
% disp(received_symbols);

% END - TASK: 7

% START - TASK: 8
disp('TASK 8: ');

min_length = min(length(demodulatedBits), length(interleavedBits));

demodulatedBits_truncated = demodulatedBits(1:min_length);
interleavedBits_truncated = interleavedBits(1:min_length);

% Расчет BER
bit_errors = sum(demodulatedBits_truncated ~= interleavedBits_truncated);
total_bits = length(demodulatedBits_truncated);
BER = bit_errors / total_bits;

disp(['Количество ошибочных битов: ', num2str(bit_errors)]);
disp(['Общее количество битов: ', num2str(total_bits)]);
disp(['BER: ', num2str(BER)]);

figure(1);

subplot(2, 2, 1);
plot(abs(fft(ofdm_symbol)));
title('Спектр переданного символа');
xlabel('Частота');
ylabel('Амплитуда');

subplot(2, 2, 2);
plot(abs(fft(rx_signal)));
title('Спектр принятого символа до эквалайзирования');
xlabel('Частота');
ylabel('Амплитуда');

subplot(2, 2, 3);
scatter(real(modulatedSymbols), imag(modulatedSymbols), 'filled')
title('Сигнальное созвездие в передатчике');
xlabel('Re');
ylabel('Im');

subplot(2, 2, 4);
scatter(real(received_symbols), imag(received_symbols), 'filled');
title('Сигнальное созвездие в приемнике');
xlabel('Re');
ylabel('Im');

% END - TASK: 8
