function rx_signal = channel_model(ofdm_symbol, N_path, SNR_dB, max_delay)
    N = length(ofdm_symbol);

    h = zeros(1, max_delay);
    path_delays = randperm(max_delay, N_path);
    path_gains = (randn(1, N_path) + 1i * randn(1, N_path)) / sqrt(2);

    for k = 1:N_path
        h(path_delays(k)) = path_gains(k);
    end

    h = h / sqrt(mean(abs(h) .^ 2));

    channel_output = conv(ofdm_symbol, h, 'same');

    signal_power = mean(abs(channel_output) .^ 2);
    channel_output = channel_output / sqrt(signal_power);

    SNR_linear = 10 ^ (SNR_dB / 10);
    noise_power = 1 / SNR_linear;
    noise = sqrt(noise_power / 2) * (randn(1, N) + 1i * randn(1, N));

    rx_signal = channel_output + noise;

    random_ir = (randn(1, max_delay) + 1i * randn(1, max_delay)) / sqrt(2);
    random_ir = random_ir / sqrt(mean(abs(random_ir) .^ 2));

    rx_signal = conv(rx_signal, random_ir, 'same');
end
