function [qpsk_symbols] = ofdm_demodulator(rx_signal, delta_Rs, T_CP, C, N_subcarrier)
    N_FFT = length(rx_signal) - T_CP;
    N_0 = round(C * (N_subcarrier / (1 - C)));

    rx_signal_noCP = rx_signal(T_CP + 1:end);

    C = fft(rx_signal_noCP, N_FFT);

    C = C(N_0 + 1:end - N_0);

    rs_indices = 1:delta_Rs:N_subcarrier;
    R_rx = C(rs_indices);

    R_tx = 0.707 + 1j * 0.707;
    H_est = R_rx ./ R_tx;

    all_indices = 1:N_subcarrier;
    data_indices = setdiff(all_indices, rs_indices);
    H_EQ = interp1(rs_indices, H_est, all_indices, 'linear');

    C_EQ = C ./ H_EQ;

    qpsk_symbols = C_EQ(data_indices);
end
